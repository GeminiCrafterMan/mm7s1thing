; ---------------------------------------------------------------------------
; Object 38 - shield and invincibility stars
; ---------------------------------------------------------------------------

ShieldItem:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Shi_Index(pc,d0.w),d1
		jmp	Shi_Index(pc,d1.w)
; ===========================================================================
Shi_Index:	dc.w Shi_Main-Shi_Index
		dc.w Shi_Shield-Shi_Index
		dc.w Shi_Stars-Shi_Index

stars_prevframe = $29
stars_trackdata = $30
; ===========================================================================

Shi_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_ShieldAndStars,obMap(a0)
		move.b	#4,obRender(a0)
		move.b	#1,obPriority(a0)
		move.b	#$10,obActWid(a0)
		move.w	#$541,obGfx(a0)	; shield specific code
		tst.b	obAnim(a0)	; is object a shield?
		bne.s	.stars		; if not, branch
		rts
; ===========================================================================

.stars:
		addq.b	#2,obRoutine(a0) ; goto Shi_Stars next
		rts
; ===========================================================================

Shi_Shield:	; Routine 2
		tst.b	(v_invinc).w	; does Sonic have invincibility?
		bne.s	.remove		; if yes, branch
		tst.b	(v_shield).w	; does Sonic have shield?
		beq.s	.delete		; if not, branch
		move.w	(o_player+obX).w,obX(a0)
		move.w	(o_player+obY).w,obY(a0)
		bra.s	Shi_Display

.remove:
		rts

.delete:
		jmp	(DeleteObject).l
; ===========================================================================

Shi_Stars:	; Routine 4
		tst.b	(v_invinc).w	; does Sonic have invincibility?
		beq.s	Shi_Start_Delete		; if not, branch
		move.w	(v_trackpos).w,d0 ; get index value for tracking data
		move.b	obAnim(a0),d1
		subq.b	#1,d1

.trail:
		lsl.b	#3,d1		; multiply animation number by 8
		move.b	d1,d2
		add.b	d1,d1
		add.b	d2,d1		; multiply by 3
		addq.b	#4,d1
		sub.b	d1,d0
		move.b	stars_trackdata(a0),d1	; store
		sub.b	d1,d0		; use earlier tracking data to create trail
		addq.b	#4,d1
		cmpi.b	#$18,d1
		bcs.s	.a
		moveq	#0,d1

.a:
		move.b	d1,stars_trackdata(a0)	; restore
		lea	(v_tracksonic).w,a1
		lea	(a1,d0.w),a1
		move.w	(a1)+,obX(a0)
		move.w	(a1)+,obY(a0)
		bra.s	Shi_Display
; ===========================================================================

Shi_Start_Delete:
		jmp	(DeleteObject).l

Shi_Display:
		move.b	(o_player+obStatus).w,obStatus(a0)
		lea	(Ani_Shield).l,a1
		jsr	(AnimateSprite).l
		bsr.s	Shi_LoadGfx
		jmp	(DisplaySprite).l

Shi_LoadGfx:
		moveq	#0,d0
		move.b	obFrame(a0),d0	; load frame number
		cmp.b	stars_prevframe(a0),d0
		beq.s	.nochange
		move.b	d0,stars_prevframe(a0)
		lea	(ShieldAndStarsDynPLC).l,a2

		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		moveq	#0,d5
		move.b	(a2)+,d5
		subq.w	#1,d5
		bmi.s	.nochange
		move.w	obGfx(a0),d4    ; get art tile
		andi.w  #$7FF,d4	; clear art flags
		lsl.w   #5,d4	   ; get VRAM address
		move.l	#Art_ShieldAndStars,d6

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
		add.l	d6,d1
		move.w	d4,d2
		add.w	d3,d4
		add.w	d3,d4
		jsr	(QueueDMATransfer).l
		dbf	d5,.readentry	; repeat for number of entries

    .nochange:
		rts	
; End of function Signpost_LoadGfx