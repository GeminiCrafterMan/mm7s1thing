; ---------------------------------------------------------------------------
; Object 3C - smashable	wall (GHZ, SLZ)
; ---------------------------------------------------------------------------

SmashWall:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	Smash_Index(pc,d0.w),d1
		jsr	Smash_Index(pc,d1.w)
		bra.w	RememberState
; ===========================================================================
Smash_Index:	dc.w Smash_Main-Smash_Index
		dc.w Smash_Solid-Smash_Index
		dc.w Smash_FragMove-Smash_Index

smash_speed = $30		; Sonic's horizontal speed
; ===========================================================================

Smash_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_Smash,obMap(a0)
		move.w	#$450F,obGfx(a0)
		move.b	#4,obRender(a0)
		move.b	#$10,obActWid(a0)
		move.b	#4,obPriority(a0)
		move.b	obSubtype(a0),obFrame(a0)

Smash_Solid:	; Routine 2
		move.w	(o_objectsmashingshot+obVelX).w,smash_speed(a0) ; load the shot's horizontal speed
		move.w	#$1B,d1
		move.w	#$20,d2
		move.w	#$20,d3
		move.w	obX(a0),d4
		bsr.w	SolidObject
;		btst	#5,obStatus(a0)	; is Sonic pushing against the wall?
;		bne.s	.chkroll	; if yes, branch
		lea		(o_objectsmashingshot).w,a1
		jsr		Obj_GetOrientationToA1
	.testDistance:
		addi.w	#$20,d3
		cmpi.w	#$40,d3	; is the shot too low?
		bhs.s	.donothing
		tst.w	d2
		bge.s	.contTestDistance
		neg.w	d2
	.contTestDistance:
		cmpi.w	#$1B,d2	; is the shot too far away?
		bgt.s	.donothing
		bra.s	.chkroll

.donothing:
		rts
; ===========================================================================

.chkroll:
		cmpi.b	#2,obSubtype(a1) ; is it a charge shot?
		beq.s	.dothing	; if so, branch
;		cmpi.b	#3,obSubtype(a1) ; is it the Green Wrecker ball?
;		beq.s	.dothing	; if so, branch
		bra.s	.donothing
	.dothing:
		move.w	smash_speed(a0),d0
		bpl.s	.chkspeed
		neg.w	d0

.chkspeed:
;		cmpi.w	#$480,d0	; is Sonic's speed $480 or higher?
;		bcs.s	.donothing	; if not, branch
	; doesn't matter, uncle ben, charge shot's stronger than both of em
		move.w	smash_speed(a0),obVelX(a1)
		addq.w	#4,obX(a1)
		lea	(Smash_FragSpd1).l,a4 ;	use fragments that move	right
		move.w	obX(a0),d0
		cmp.w	obX(a1),d0	; is Sonic to the right	of the block?
		bcs.s	.smash		; if yes, branch
		subq.w	#8,obX(a1)
		lea	(Smash_FragSpd2).l,a4 ;	use fragments that move	left

.smash:
		move.w	obVelX(a1),obInertia(a1)
		bclr	#5,obStatus(a0)
		bclr	#5,obStatus(a1)
		moveq	#7,d1		; load 8 fragments
		move.w	#$70,d2
		bsr.s	SmashObject

Smash_FragMove:	; Routine 4
		bsr.w	SpeedToPos
		addi.w	#$70,obVelY(a0)	; make fragment	fall faster
		bsr.w	DisplaySprite
		tst.b	obRender(a0)
		bpl.w	DeleteObject
		rts	
