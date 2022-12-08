; ---------------------------------------------------------------------------
; Subroutine allowing Sonic to roll when he's moving
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_Roll:
		tst.b	(f_jumponly).w
		bne.s	Sonic_ChkRoll.ret
		btst	#2,obStatus(a0)
		bne.s	Sonic_ChkRoll ; keep sliding
		tst.b	slidetimer(a0)	; cooldown timer
		bne.s	Sonic_ChkRoll.ret
		btst	#bitDn,(v_jpadhold2).w ; is down being pressed?
		beq.s	Sonic_ChkRoll.ret	; if not, branch
		andi.b	#btnC,(v_jpadpress2).w	; is C pressed?
		beq.s	Sonic_ChkRoll.ret
Sonic_ChkRoll:
		btst	#2,obStatus(a0)	; is Mega Man already sliding?
		beq.s	MegaMan_Slide		; if not, branch
		tst.b	slidetimer(a0)
		beq.w	MegaMan_Slide.stopSliding
;		btst	#0,obStatus(a0)
;		beq.s	.notLeft
;		move.w	#-$500,obInertia(a0) ; set inertia
;		bra.s	.ret
;	.notLeft:
;		move.w	#$500,obInertia(a0) ; set inertia
	.ret:
		rts
MegaMan_Slide:
		bset	#2,obStatus(a0)
		move.b	#$E,obHeight(a0)
		move.b	#7,obWidth(a0)
		btst	#0,obStatus(a0)
		beq.s	.notLeft
		move.w	#-$500,obInertia(a0) ; set inertia
		bra.s	.contSlide
	.notLeft:
		move.w	#$500,obInertia(a0) ; set inertia
	.contSlide:
		move.b	#id_SlideStart,obAnim(a0) ; use "rolling" animation
;		addq.w	#5,obY(a0)
		move.b	#30,slidetimer(a0)
		move.w	#sfx_Slide,d0
		jsr	(PlaySound_Special).l	; play slide sound
		tst.w	obInertia(a0)
		beq.s	.stopSliding
		rts
	.stopSliding:
		clr.w	obInertia(a0)
;		clr.b	obAniFrame(a0)
;		clr.w	obTimeFrame(a0) ; also clears obDelayAni
		move.b	#id_SlideStop,obAnim(a0)
		subq.w	#5,obY(a0)
		move.b	#$13,obHeight(a0)
		move.b	#9,obWidth(a0)
		bclr	#2,obStatus(a0)
		move.b	#5,slidetimer(a0)	; cooldown
	.ret:
		rts
; End of function Sonic_Roll