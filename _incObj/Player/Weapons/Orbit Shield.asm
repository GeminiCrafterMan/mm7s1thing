	Weapon_OrbitShield:	; rapid-fire alternating spear
		cmpi.b	#id_Slide,obAnim(a0)
		beq.w	.ret
		btst	#bitB,(v_jpadpress2).w
		beq.w	.ret
		cmpi.b	#1,orbsLeft(a0)
		bge.w	.shootOrb
		tst.b	(v_weapon5energy).w
		beq.w	.outofenergy
	.makeShield:
		addq.b	#4,(v_bulletsonscreen).w
		addq.b	#4,orbsLeft(a0)
		subq.b	#4,(v_weapon5energy).w
		move.w	#sfx_Shield,d0	; fireyish sound
		jsr		(PlaySound_Special).l	; play shooting sound
;		jsr		FindFreeObj
;		move.b	#id_BusterShot,0(a1)	; load missile object
;		move.b	#3,obSubtype(a1)
; i have no clue how this'll work but it'll be really funny nonetheless
		moveq	#0,d2
		moveq	#3,d1

.makesatellites:
		bsr.w	FindNextFreeObj
		bne.s	.fail
		move.b	#id_BusterShot,0(a1)	; load spiked orb object
		move.b	#6,obSubtype(a1)	; Orbit Shield
		move.b	d2,obAngle(a1)
		addi.b	#$40,d2
		move.l	a0,orb_parent(a1)
		dbf	d1,.makesatellites	; repeat sequence 3 more times
.fail:
		move.b	#5,(v_shottype).w
		move.b	#24,shoottimer(a0)
		bra.s	.animate
	.shootOrb:
		move.b	#4,(v_shottype).w
		move.b	#24,shoottimer(a0)
	.animate:
		bra.w	FireWeapon.notFlipped
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