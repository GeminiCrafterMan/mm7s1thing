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
;		dc.w	BShot_JustFired-BShot_Index
		dc.w	BShot_Main-BShot_Index
		dc.w	BShot_Delete-BShot_Index
; ===========================================================================
BShot_Init:	; Routine 0
		addq.b	#2,obRoutine(a0)		; go to the next routine
		move.l	#Map_BusterShot,obMap(a0)	; set mappings
		move.w	#$6BA,obGfx(a0)		; set VRAM tile
		move.b	#4,obRender(a0)		; set render flags
		move.b	#1,obPriority(a0)		; set priority
		move.b	#8,obHeight(a0)		; set horizontal radius
		move.b	#8,obWidth(a0)		; set horizontal radius
		move.b	#8,obActWid(a0)		; set horizontal radius
		move.b	obSubtype(a0),obColProp(a0)	; set shot "health"

; ===========================================================================
BShot_Main:	; Routine 4
		jsr		(ChkObjectVisible).l	; is the projectile off-screen?
		bne.s	BShot_Delete			; if so, branch
		jsr		ObjFloorDist
		tst.w	d1
		ble.s	.explode
		jsr		(ReactToItem).l
		jsr		(SpeedToPos).l
.animate:
		lea		(Ani_Lemon).l,a1
		jsr		AnimateSprite
		jmp		DisplaySprite

.explode:
		move.b	#1,obAnim(a0)
		clr.w	obVelX(a0)

; ===========================================================================
BShot_Delete: ; Routine 6
		cmpi.b	#2,obSubtype(a0)
		bne.s	.onlyOne
		subq.b	#2,(v_bulletsonscreen).w
	.onlyOne:
		subq.b	#1,(v_bulletsonscreen).w
		jmp		(DeleteObject).l

Ani_Lemon:
    	dc.w .normal-Ani_Lemon
    	dc.w .explode-Ani_Lemon

.normal:	dc.b 2, 0, afEnd
		even
.explode:	dc.b 2, 1, 2, 3, afRoutine
		even