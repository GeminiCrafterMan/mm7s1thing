; ---------------------------------------------------------------------------
; Object 8D - Mega Buster bullet
; ---------------------------------------------------------------------------
bshot_lastLoaded = $29 ; byte
bshot_dplcAddr = $30 ; longword
bshot_artAddr = $34 ; longword
bshot_animAddr = $38 ; longword
bshot_yoffset = $3C ; byte

BusterShot:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	BShot_Index(pc,d0.w),d1
		jmp		BShot_Index(pc,d1.w)
; ===========================================================================
BShot_Index:
		dc.w	BShot_Init-BShot_Index
		dc.w	BShot_Main-BShot_Index
		dc.w	BShot_Delete-BShot_Index
; ===========================================================================
BShot_Init:	; Routine 0
		addq.b	#2,obRoutine(a0)		; go to the next routine
		move.b	#4,obRender(a0)		; set render flags
		move.b	#1,obPriority(a0)		; set priority
		
	; stolen from scenery object
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		mulu.w	#22,d0	; god i hope this works
	; 4+4+4+4 = 16, 16+2+1+1+1 = 21, +1 to make it even
		lea		bshot_Values(pc,d0.w),a1
		move.l	(a1)+,obMap(a0)			; 4
		move.l	(a1)+,bshot_dplcAddr(a0); 4
		move.l	(a1)+,bshot_artAddr(a0)	; 4
		move.l	(a1)+,bshot_animAddr(a0); 4
		move.w	(a1)+,obGfx(a0)			; 2
		move.b	(a1)+,obHeight(a0)		; 1
		move.b	(a1)+,obWidth(a0)		; 1
		move.b	obWidth(a0),obActWid(a0)
		move.b	(a1)+,obColProp(a0)		; 1
		rts
	
	bshot_Values:
	; Buster
		dc.l	Map_BusterLemon, 0, 0, Ani_BusterLemon	; mappings/dplcs/art/animations
		dc.w	$6BA	; VRAM tile
		dc.b	6, 8, 1, 0	; height, width/sprite width, health, 0
		dc.l	Map_BusterCharges, BusterChargesDynPLC, Art_BusterCharges, Ani_BusterMid
		dc.w	$7A2
		dc.b	12, 16, 2, 0
		dc.l	Map_BusterCharges, BusterChargesDynPLC, Art_BusterCharges, Ani_BusterFull
		dc.w	$7A2
		dc.b	24, 32, 3, 0
	; Labyrinth Spear
		dc.l	Map_BusterLemon, 0, 0, Ani_BusterLemon
		dc.w	$7A2
		dc.b	6, 8, 2, 0
		even

; ===========================================================================
BShot_Main:	; Routine 2
		cmpi.b	#1,obAnim(a0)
		beq.s	.animate
		btst	#7,obStatus(a0)
		bne.s	.explode
		jsr		(ChkObjectVisible).l	; is the projectile off-screen?
		bne.w	BShot_Delete			; if so, branch and just delete it
;		jsr		ObjFloorDist
;		tst.w	d1
;		bpl.s	.nah
;		bset	#7,obStatus(a0)
;	.nah:
		jsr		(ReactToItem).l
		jsr		(SpeedToPos).l
.animate:
		movea.l	bshot_animAddr(a0),a1
		jsr		AnimateSprite
		bsr.s	.loadGfx
		jmp		DisplaySprite

.explode:
		move.b	#1,obAnim(a0)
		clr.w	obVelX(a0)
;		move.w	#sfx_Lamppost,d0
;		jsr	(PlaySound_Special).l	; play collapsing sound
		rts

	.loadGfx:
		tst.l	bshot_dplcAddr(a0)
		beq.w	.nochange
		moveq	#0,d0
		move.b	obFrame(a0),d0	; load frame number
		cmp.b	bshot_lastLoaded(a0),d0
		beq.s	.nochange
		move.b	d0,bshot_lastLoaded(a0)
		move.l	bshot_dplcAddr(a0),a2
		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		moveq	#0,d5
		move.b	(a2)+,d5
		subq.w	#1,d5
		bmi.s	.nochange
		move.w	obGfx(a0),d4    ; get art tile
		andi.w  #$7FF,d4	; clear art flags
		lsl.w   #5,d4	   ; get VRAM address

    .readentry:
		moveq	#0,d1
		move.b	(a2)+,d1
		lsl.w	#8,d1
		move.b	(a2)+,d1
		move.w	d1,d3
		lsr.w	#8,d3
		andi.w	#$F0,d3
		addi.w	#$10,d3
		andi.w	#$FFF,d1
		lsl.l	#5,d1
		add.l	bshot_artAddr(a0),d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(QueueDMATransfer).l
		dbf	d5,.readentry	; repeat for number of entries

    .nochange:
		rts

; ===========================================================================
BShot_Delete: ; Routine 4
		cmpi.b	#2,obSubtype(a0)
		bne.s	.onlyOne
		subq.b	#2,(v_bulletsonscreen).w	; subtract 2
	.onlyOne:
		subq.b	#1,(v_bulletsonscreen).w	; subtract 1
		jmp		(DeleteObject).l
	.ret:
		rts

Ani_BusterLemon:
    	dc.w .normal-Ani_BusterLemon
    	dc.w .explode-Ani_BusterLemon

.normal:	dc.b 2, 0, afEnd
		even
.explode:	dc.b 0, 1, 2, 2, 3, 3, afRoutine
		even

Ani_BusterMid:
    	dc.w .normal-Ani_BusterMid
    	dc.w .explode-Ani_BusterMid

.normal:	dc.b 0, 1, 2, 2, 3, 3, 3, afEnd
		even
.explode:	dc.b 1, 4, 5, 6, 6, afRoutine
		even

Ani_BusterFull:
    	dc.w .normal-Ani_BusterFull
    	dc.w .explode-Ani_BusterFull

.normal:	dc.b 0, 7, 7, 8, 8, 8, 9, afEnd
		even
.explode:	dc.b 1, $A, $B, $C, $C, afRoutine
		even