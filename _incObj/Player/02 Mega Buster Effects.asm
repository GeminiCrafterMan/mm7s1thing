; ---------------------------------------------------------------------------
; Object 02 - Mega Buster effect (always present)
; ---------------------------------------------------------------------------
; uses bshot_lastLoaded's definition from Object 8D - BusterShot

BusterEffects:
	; frankly so simple i don't need routines for it
		ori.b	#4,obRender(a0)
		move.b	#1,obPriority(a0)
		move.w	#$799,obGfx(a0)
		move.l	#Map_MegaBusterFX,obMap(a0)
		move.w	(o_player+obX).w,obX(a0)
		move.w	(o_player+obY).w,obY(a0)
	; maybe add custom x/y offsets per frame of Mega's sprites...?
		btst	#0,(o_player+obStatus).w
		beq.s	.notFlipped
		bset	#0,obStatus(a0)
		subi.w	#25,obX(a0)
		bra.s	.doneFlipChk

	.notFlipped:
		bclr	#0,obStatus(a0)
		addi.w	#25,obX(a0)
	.doneFlipChk:
		btst	#1,(o_player+obStatus).w
		beq.s	.onGround
		subq.w	#4,obY(a0)
	.onGround:
		lea		(Ani_MegaBusterFX).l,a1
		jsr		AnimateSprite
		bsr.s	.loadGfx
		jmp		DisplaySprite

	.loadGfx:
		moveq	#0,d0
		move.b	obFrame(a0),d0	; load frame number
		cmp.b	bshot_lastLoaded(a0),d0
		beq.s	.nochange
		move.b	d0,bshot_lastLoaded(a0)
		lea	(MegaBusterFXDynPLC).l,a2

		add.w	d0,d0
		adda.w	(a2,d0.w),a2
		moveq	#0,d5
		move.b	(a2)+,d5
		subq.w	#1,d5
		bmi.s	.nochange
		move.w	obGfx(a0),d4    ; get art tile
		andi.w  #$7FF,d4	; clear art flags
		lsl.w   #5,d4	   ; get VRAM address
		move.l	#Art_MegaBusterFX,d6

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
	
Ani_MegaBusterFX:
		dc.w	.none-Ani_MegaBusterFX
		dc.w	.lemon-Ani_MegaBusterFX
		dc.w	.medium-Ani_MegaBusterFX
		dc.w	.full-Ani_MegaBusterFX
	.none:		dc.b 0, 0, afEnd
		even
	.lemon:		dc.b 0, 1, 2, 3, afChange, 0
		even
	.medium:	dc.b 0, 4, 5, 5, 5, 5, afChange, 0
		even
	.full:		dc.b 0, 0, 0, 4, 6, 7, afChange, 0
		even