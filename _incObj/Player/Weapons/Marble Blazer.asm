	Weapon_MarbleBlazer:	; arcing fireball that turns into a slow-moving pillar upon hitting the ground
		cmpi.b	#id_Slide,obAnim(a0)
		beq.w	.ret
		btst	#bitB,(v_jpadpress2).w
		beq.w	.ret
		tst.b	(v_weapon2energy).w
		beq.w	.outofenergy
		cmpi.b	#2,(v_bulletsonscreen).w
		bge.w	.ret
	.fireFlame:
		addq.b	#1,(v_bulletsonscreen).w
		subq.b	#1,(v_weapon2energy).w
		move.w	#sfx_Fireball,d0	; fireyish sound
		jsr		(PlaySound_Special).l	; play shooting sound
		jsr		FindFreeObj
		move.b	#id_BusterShot,0(a1)	; load missile object
		move.b	#3,obSubtype(a1)
		clr.b	(v_shottype).w
		move.b	#13,shoottimer(a0)
		move.w	#$500,obVelX(a1)
		bra.s	.objectLoadedJumpPoint
	.outofenergy:
		cmpi.b	#3,(v_bulletsonscreen).w
		bge.s	.ret
	.fireLemon:
		addq.b	#1,(v_bulletsonscreen).w
		move.w	#sfx_BusterShot,d0
		jsr		(PlaySound_Special).l	; play shooting sound
		jsr		FindFreeObj
		move.b	#id_BusterShot,0(a1)	; load missile object
		move.w	#$700,obVelX(a1)
		clr.b	(v_shottype).w
		move.b	#13,shoottimer(a0)
;		bra.s	.objectLoadedJumpPoint
	.objectLoadedJumpPoint:
		jsr		FireWeapon
	.ret:
		rts