; ---------------------------------------------------------------------------
; Object 02 - Mega Buster bullet
; ---------------------------------------------------------------------------

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
		move.l	#Map_BusterShot,obMap(a0)	; set mappings
		move.w	#$7AC,obGfx(a0)		; set VRAM tile
		move.b	#4,obRender(a0)		; set render flags
		move.b	#1,obPriority(a0)		; set priority
		move.b	#8,obHeight(a0)		; set horizontal radius
		move.b	#8,obWidth(a0)		; set horizontal radius
		move.b	#8,obActWid(a0)		; set horizontal radius

; ===========================================================================
BShot_Main:	; Routine 2
		jsr		(ChkObjectVisible).l	; is the projectile off-screen?
		bne.s	BShot_Delete			; if so, branch
		jsr		ObjFloorDist
		tst.w	d1
		ble.s	.explode
		jsr		(ReactToItem).l
		jsr		(SpeedToPos).l
.animate:
		lea		(Ani_BShot).l,a1
		jsr		AnimateSprite
		jmp		DisplaySprite

.explode:
		move.b	#1,obAnim(a0)
		clr.w	obVelX(a0)

BShot_Delete:
		subq.b	#1,(v_bulletsonscreen).w
		jmp		(DeleteObject).l

Ani_BShot:
    	dc.w .normal-Ani_BShot
    	dc.w .explode-Ani_BShot

.normal:	dc.b 2, 0, afEnd
		even
.explode:	dc.b 2, 1, 2, 3, afRoutine
		even