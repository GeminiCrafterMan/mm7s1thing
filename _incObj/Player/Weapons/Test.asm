	Weapon_Test:	; rapid-fire buster shot
		btst	#bitB,(v_jpadhold2).w	; holding B?
		beq.w	.ret	; if not, return
		cmpi.b	#id_Slide,obAnim(a0)
		beq.w	.ret
		cmpi.b	#2,(v_bulletsonscreen).w
		bge.w	.ret
		cmpi.b	#7,shoottimer(a0)
		bgt.w	.ret
	.fireLemon:
		addq.b	#1,(v_bulletsonscreen).w
		move.w	#sfx_BusterShot,d0
		jsr		(PlaySound_Special).l	; play shooting sound
		jsr		FindFreeObj
		move.b	#id_BusterShot,0(a1)	; load missile object
		clr.b	(v_shottype).w
		move.b	#13,shoottimer(a0)
		move.w	#$700,obVelX(a1)
;		bra.w	.objectLoadedJumpPoint
	.objectLoadedJumpPoint:
		jsr		FireWeapon
	.ret:
		rts