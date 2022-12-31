; ---------------------------------------------------------------------------
; Object 04 - Items, placed in the level or dropped by enemies
; ---------------------------------------------------------------------------
; uses flashtime from Sonic's SSTs, if dropped by an enemy.
Items:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Items_Index(pc,d0.w),d1
		jmp		Items_Index(pc,d1.w)
; ===========================================================================
Items_Index:
		dc.w	Items_Main-Items_Index
		dc.w	Items_Animate-Items_Index
		dc.w	Items_Collect-Items_Index
		dc.w	Items_Delete-Items_Index
; ===========================================================================
Items_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Items,obMap(a0)
		move.w	#$565,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#4,obPriority(a0)
		move.b	#$47,obColType(a0)
		move.b	obSubtype(a0),obAnim(a0)
		move.b	#4*60,flashtime(a0)
		cmpi.b	#5,obAnim(a0)
		beq.s	.small
		cmpi.b	#7,obAnim(a0)
		bge.s	.small
		move.b	#8,obHeight(a0)
		move.b	#8,obWidth(a0)
		move.b	#8,obActWid(a0)
		rts
	.small:
		move.b	#4,obHeight(a0)
		move.b	#4,obWidth(a0)
		move.b	#4,obActWid(a0)
		rts
; ===========================================================================
Items_Animate:	; Routine 2
		lea		(Ani_Items).l,a1
		bsr.w	AnimateSprite

		bsr.w	ObjectFall
		jsr		(ObjFloorDist).l
		tst.w	d1
		bpl.s	.notOnFloor
		add.w	d1,obY(a0)	; doesn't this little block make it rest on the floor nicely?
		move.w	#0,obVelY(a0)

	.notOnFloor:
		tst.b	obRespawnNo(a0)
		bne.s	.wasPlaced

		move.b	flashtime(a0),d0
		beq.s	Items_Delete		; if 0, delete
		subq.b	#1,flashtime(a0)	; subtract 1 from the flash time
		cmpi.b	#60,flashtime(a0)	; if 1 second is left, continue
		bhi.s	.justDisplay		; if more than that, just display
		lsr.b	#2,d0				; flash on and off 2 frames each
		bcs.s	.justDisplay		; display if carry is clear (2 of every 4 frames)
		rts							; don't display
	.justDisplay:
		jmp		DisplaySprite		; display

	.wasPlaced:
		bra.w	RememberState		; remember the object's state since it was placed by the dev
; ===========================================================================
Items_Collect:	; Routine 4
		addq.b	#2,obRoutine(a0)
		move.b	#0,obColType(a0)
		move.b	#1,obPriority(a0)
		bsr.s	CollectItem
		lea	(v_objstate).w,a2
		moveq	#0,d0
		move.b	obRespawnNo(a0),d0
		move.b	$34(a0),d1
		bset	d1,2(a2,d0.w)

; ===========================================================================
Items_Delete:	; Routine 6
		jmp		DeleteObject

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||
CollectItem:
		moveq	#0,d0
		move.b	obSubtype(a0),d0
		lsl.w	#2,d0
		movea.l	.itemLUT(pc,d0.w),a1
		jmp		(a1)
	
	.itemLUT:
		dc.l	.1up, .eTank, .wTank, .mTank, .lHP, .sHP, .lEn, .sEn, .scr

	.1up:
		addq.b	#1,(v_lives).w	; add 1 to the number of lives you have
		addq.b	#1,(f_lifecount).w ; update the lives counter
		move.w	#sfx_1up,d0 ; play extra life sound
		bra.s	.playsnd
	.eTank:
		move.w	#sfx_1up,d0 ; play extra life sound
		bra.s	.playsnd
	.wTank:
		move.w	#sfx_1up,d0 ; play extra life sound
		bra.s	.playsnd
	.mTank:
		move.w	#sfx_1up,d0 ; play extra life sound
		bra.s	.playsnd
	.lHP:
		move.w	#sfx_Ring,d0 ; play extra life sound
		bra.s	.playsnd
	.sHP:
		move.w	#sfx_Ring,d0 ; play extra life sound
		bra.s	.playsnd
	.lEn:
		tst.b	(v_weapon).w
		beq.s	.ret
		move.w	#sfx_Ring,d0 ; play extra life sound
		bra.s	.playsnd
	.sEn:
		tst.b	(v_weapon).w
		beq.s	.ret
		move.w	#sfx_Ring,d0 ; play extra life sound
		bra.s	.playsnd
	.scr:	; change this later to add these to the tally at the end of the level.
		; Something about results card subroutines, and a byte in RAM for the amount of score balls collected
		move.w	#100,d0
		jsr		AddPoints
		move.w	#sfx_Ring,d0 ; play extra life sound
;		bra.s	.playsnd

.playsnd:
		jmp	(PlaySound_Special).l

.ret:
		rts