	Weapon_Test:
		cmpi.b	#3,(v_bulletsonscreen).w
		bge.s	.noShoot
		addq.b	#1,(v_bulletsonscreen).w

		jsr		FindFreeObj
		move.b	#id_BusterShot,0(a1)	; load missile object
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)
		move.w	#$700,obVelX(a1)
		btst	#0,obStatus(a0)
		beq.s	.notFlipped
		neg.w	obVelX(a1)
		bset	#0,obStatus(a1)
		subi.w	#15,obX(a1)
		bra.s	.doneFlipChk

	.notFlipped:
		addi.w	#15,obX(a1)
	.doneFlipChk:
		bset	#7,obStatus(a0)		; set 'shooting' flag in status
		move.b	#13,shoottimer(a0)
		cmpi.b	#id_Wait,obAnim(a0)
		beq.s	.shootAnim
		cmpi.b	#id_Shoot,obAnim(a0)
		beq.s	.shootAnim
		bra.s	.skipShootAnim
	.shootAnim:
		clr.b	obAniFrame(a0)
		clr.b	obTimeFrame(a0)
		clr.b	obDelayAni(a0)
		move.b	#id_Shoot,obAnim(a0)
	.skipShootAnim:
		move.w	#sfx_BusterShot,d0
		jsr	(PlaySound_Special).l	; play shooting sound
    .noShoot:
		rts 
