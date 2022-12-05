; ---------------------------------------------------------------------------
; Subroutine to	reset Sonic's mode when he lands on the floor
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


Sonic_ResetOnFloor:
		btst	#4,obStatus(a0)
		beq.s	loc_137AE
		nop	
		nop	
		nop	

loc_137AE:
		bclr	#5,obStatus(a0)
		bclr	#1,obStatus(a0)
		bclr	#4,obStatus(a0)
		btst	#2,obStatus(a0)
		beq.s	loc_137E4
		bclr	#2,obStatus(a0)
		move.b	#$13,obHeight(a0)
		move.b	#9,obWidth(a0)
		tst.b	obVelX(a0)
		bne.s	.walkAnim
		move.b	#id_Land,obAnim(a0)
		bra.s	.cont
	.walkAnim:
		move.b	#id_Walking,obAnim(a0)
	.cont:
		subq.w	#5,obY(a0)

loc_137E4:
		move.b	#0,$3C(a0)
		move.w	#0,(v_itembonus).w
		move.w	#sfx_JumpLand,d0
		jsr	(PlaySound_Special).l	; play jumping sound
		rts	
; End of function Sonic_ResetOnFloor