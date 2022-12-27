; ---------------------------------------------------------------------------
; Object 8D - Mega Buster bullet
; ---------------------------------------------------------------------------
bshot_lastLoaded = $29 ; byte
bshot_dplcAddr = $30 ; longword
bshot_artAddr = $34 ; longword
bshot_animAddr = $38 ; longword
bshot_yoffset = $3C ; byte
bshot_properties = $3D

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
		mulu.w	#24,d0	; god i hope this works
	; 4+4+4+4+2+1+1+1+1+1+1 = 24
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
		move.b	(a1)+,obAnim(a0)		; 1
		move.b	(a1)+,(o_busterfx+obAnim).w
		clr.b	(o_busterfx+obAniFrame).w
		move.b	(a1)+,bshot_properties(a0)	; 1
		rts
	
	bshot_Values:
	; Buster
		dc.l	Map_BusterLemon, 0, 0, Ani_BusterLemon	; mappings/dplcs/art/animations
		dc.w	$6BA	; VRAM tile
		dc.b	6, 8, 1, 0, 1, %00000000	; height, width, health, initial animation, buster fx animation, properties
		dc.l	Map_BusterCharges, BusterChargesDynPLC, Art_BusterCharges, Ani_BusterMid
		dc.w	$7A1
		dc.b	12, 16, 2, 0, 2, %00000000
		dc.l	Map_BusterCharges, BusterChargesDynPLC, Art_BusterCharges, Ani_BusterFull
		dc.w	$7A1
		dc.b	24, 32, 3, 0, 3, %00000000
	; Marble Blazer
		dc.l	Map_SpecialWeapons, SpecialWeaponsDynPLC, Art_SpecialWeapons, Ani_SpecialWeapons
		dc.w	$79D
		dc.b	8, 8, 2, 2, 2, %00000000
		dc.l	Map_SpecialWeapons, SpecialWeaponsDynPLC, Art_SpecialWeapons, Ani_SpecialWeapons
		dc.w	$79D
		dc.b	19, 8, 4, 3, 0, %00000000
	; Labyrinth Spear
		dc.l	Map_SpecialWeapons, SpecialWeaponsDynPLC, Art_SpecialWeapons, Ani_SpecialWeapons
		dc.w	$79D
		dc.b	5, 16, 2, 5, 2, %00000000
		even

; ===========================================================================
BShot_Main:	; Routine 2
		cmpi.b	#1,obAnim(a0)
		beq.w	.animate
		btst	#7,obStatus(a0)
		bne.w	.explode
		jsr		(ChkObjectVisible).l	; is the projectile off-screen?
		bne.w	BShot_Delete			; if so, branch and just delete it
		jsr		(ReactToItem).l
	.mBlazer:
		cmpi.b	#3,obSubtype(a0)	; marble blazer air?
		bne.s	.mbGrndChk		; if not, check for the ground variant
		jsr		(ObjectFall).l
		jsr		ObjFloorDist		; check floor dist
		tst.w	d1					; check d1
		bpl.s	.animate			; if positive, gtfo
		jsr		FindFreeObj
	; maybe add a fail routine
	; spawn grounded marble blazer
		move.b	#id_BusterShot,0(a1)
		move.b	#4,obSubtype(a1)
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		subi.w	#12,obY(a1)	; since it's taller
		moveq	#0,d0
		mvabs.w	obVelX(a0),d0
		lsr.w	#2,d0
		btst	#0,obStatus(a0)
		beq.s	.mbSpawnVelX
		neg.w	d0
	.mbSpawnVelX:
		move.w	d0,obVelX(a1)
		move.w	#sfx_Flamethrower,d0
		jsr	(PlaySound_Special).l	; play collapsing sound
		bra.w	BShot_Delete.justDelete
	.mbGrndChk:
		cmpi.b	#4,obSubtype(a0)
		bne.s	.nah
		jsr		(ObjectFall).l
		jsr		ObjFloorDist		; check floor dist
		tst.w	d1					; check d1
		bpl.s	.animate			; if not, gtfo
		add.w	d1,obY(a0)
		bra.s	.animate
	.nah:
		jsr		(SpeedToPos).l
.animate:
		movea.l	bshot_animAddr(a0),a1
		jsr		AnimateSprite
		bsr.s	.loadGfx
		jmp		DisplaySprite

.explode:
		cmpi.l	#Ani_SpecialWeapons,bshot_animAddr(a0)
		beq.w	BShot_Delete
		move.b	#1,obAnim(a0)
		clr.w	obVelX(a0)
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
	.justDelete:
		jmp		(DeleteObject).l

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

Ani_SpecialWeapons:
		dc.w .gwChain-Ani_SpecialWeapons	; probably won't be using this, but who cares
		dc.w .gwBall-Ani_SpecialWeapons		; bleh
		dc.w .mbAir-Ani_SpecialWeapons	; marble blazer placeholder
		dc.w .mbGround-Ani_SpecialWeapons
		dc.w .syzPHolder-Ani_SpecialWeapons ; spring yard weapon placeholder
		dc.w .lsSpike-Ani_SpecialWeapons	; labyrinth spear spike
		dc.w .slzPHolder-Ani_SpecialWeapons	; star light weapon placeholder
		dc.w .sbzPHolder-Ani_SpecialWeapons	; scrap brain weapon placeholder

	.gwChain:	dc.b 0, 1, afEnd
		even
	.gwBall:	dc.b 0, 2, 3, 2, 4, 2, 5, 2, 4, afEnd
		even
	.mbAir:	dc.b 0, 6, 7, 8, afEnd
		even
	.mbGround:	dc.b 2, 9, 10, 11, 12, 13, 12, 13, 12, 11, 10, 9, 0, afRoutine
		even
	.syzPHolder:	dc.b 0, 14, afEnd
		even
	.lsSpike:	dc.b 0, 15, afEnd
		even
	.slzPHolder:	dc.b 0, 16, afEnd
		even
	.sbzPHolder:	dc.b 0, 17, afEnd
		even