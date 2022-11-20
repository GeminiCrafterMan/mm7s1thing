; ---------------------------------------------------------------------------
; Object 0A - drowning countdown numbers and small bubbles that float out of
; Sonic's mouth (LZ)
; ---------------------------------------------------------------------------

DrownCount:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Drown_Index(pc,d0.w),d1
		jmp	Drown_Index(pc,d1.w)
; ===========================================================================
Drown_Index:
ptr_Drown_Main:		dc.w Drown_Main-Drown_Index
ptr_Drown_Animate:	dc.w Drown_Animate-Drown_Index
ptr_Drown_ChkWater:	dc.w Drown_ChkWater-Drown_Index
ptr_Drown_Display:	dc.w Drown_Display-Drown_Index
ptr_Drown_Delete:	dc.w Drown_Delete-Drown_Index
			dc.w Drown_Display-Drown_Index
			dc.w Drown_Delete-Drown_Index

drown_origX = $30		; original x-axis position
drown_time = $38		; time between each number changes

id_Drown_Main = ptr_Drown_Main-Drown_Index		; 0
id_Drown_Animate = ptr_Drown_Animate-Drown_Index		; 2
id_Drown_ChkWater = ptr_Drown_ChkWater-Drown_Index	; 4
id_Drown_Display = ptr_Drown_Display-Drown_Index		; 6
id_Drown_Delete = ptr_Drown_Delete-Drown_Index		; 8
; ===========================================================================

Drown_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Bub,obMap(a0)
		move.w	#$8348,obGfx(a0)
		move.b	#$84,obRender(a0)
		move.b	#$10,obActWid(a0)
		move.b	#1,obPriority(a0)
		move.b	obSubtype(a0),d0 ; get bubble type
; ===========================================================================

.smallbubble:
		move.b	d0,obAnim(a0)
		move.w	obX(a0),drown_origX(a0)
		move.w	#-$88,obVelY(a0)

Drown_Animate:	; Routine 2
		lea	(Ani_Drown).l,a1
		jsr	(AnimateSprite).l

Drown_ChkWater:	; Routine 4
		move.w	(v_waterpos1).w,d0
		cmp.w	obY(a0),d0	; has bubble reached the water surface?
		bcs.s	.wobble		; if not, branch

		move.b	#id_Drown_Display,obRoutine(a0) ; goto Drown_Display next
		addq.b	#7,obAnim(a0)
		cmpi.b	#$D,obAnim(a0)
		beq.s	Drown_Display
		bra.s	Drown_Display
; ===========================================================================

.wobble:
		tst.b	(f_wtunnelmode).w ; is Sonic in a water tunnel?
		beq.s	.notunnel	; if not, branch
		addq.w	#4,drown_origX(a0)

.notunnel:
		move.b	obAngle(a0),d0
		addq.b	#1,obAngle(a0)
		andi.w	#$7F,d0
		lea	(Drown_WobbleData).l,a1
		move.b	(a1,d0.w),d0
		ext.w	d0
		add.w	drown_origX(a0),d0
		move.w	d0,obX(a0)
;		bsr.s	Drown_ShowNumber
		jsr	(SpeedToPos).l
		tst.b	obRender(a0)
		bpl.s	.delete
		jmp	(DisplaySprite).l

.delete:
		jmp	(DeleteObject).l
; ===========================================================================

Drown_Display:	; Routine 6, Routine $E
;		bsr.s	Drown_ShowNumber
		lea	(Ani_Drown).l,a1
		jsr	(AnimateSprite).l
		jmp	(DisplaySprite).l
; ===========================================================================

Drown_Delete:	; Routine 8, Routine $10
		jmp	(DeleteObject).l
; ===========================================================================
Drown_WobbleData:
		dc.b 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2
		dc.b 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
		dc.b 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2
		dc.b 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
		dc.b 0, -1, -1, -1, -1, -1, -2, -2, -2, -2, -2, -3, -3, -3, -3, -3
		dc.b -3, -3, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4
		dc.b -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -3
		dc.b -3, -3, -3, -3, -3, -3, -2, -2, -2, -2, -2, -1, -1, -1, -1, -1
		dc.b 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2
		dc.b 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3
		dc.b 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2
		dc.b 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
		dc.b 0, -1, -1, -1, -1, -1, -2, -2, -2, -2, -2, -3, -3, -3, -3, -3
		dc.b -3, -3, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4
		dc.b -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -4, -3
		dc.b -3, -3, -3, -3, -3, -3, -2, -2, -2, -2, -2, -1, -1, -1, -1, -1
; ===========================================================================