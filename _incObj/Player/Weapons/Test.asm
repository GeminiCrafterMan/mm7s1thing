	Weapon_Test:	; rapid-fire buster shot
		btst	#bitB,(v_jpadhold2).w	; holding B?
		beq.s	.ret	; if not, return
		cmpi.b	#id_Slide,obAnim(a0)
		beq.s	.ret
		cmpi.b	#2,(v_bulletsonscreen).w
		bge.s	.ret
		cmpi.b	#7,shoottimer(a0)
		bgt.s	.ret
	.fireLemon:
		addq.b	#1,(v_bulletsonscreen).w
		move.w	#sfx_BusterShot,d0
		jsr		(PlaySound_Special).l	; play shooting sound
		jsr		FindFreeObj
		move.b	#id_BusterShot,0(a1)	; load missile object
		move.w	#$700,obVelX(a1)
		move.b	#1,(v_busterfx+obAnim).w
;		bra.w	.objectLoadedJumpPoint
	.objectLoadedJumpPoint:
		jsr		FireWeapon
	.ret:
		rts