	Weapon_LabyrinthSpear:	; rapid-fire alternating spear
		cmpi.b	#id_Slide,obAnim(a0)
		beq.w	.ret
		tst.b	(v_weapon4energy).w
		beq.w	.outofenergy
		btst	#bitB,(v_jpadhold2).w	; holding B?
		beq.w	.ret	; if not, return
		cmpi.b	#8,(v_bulletsonscreen).w
		bge.w	.ret
		cmpi.b	#7,shoottimer(a0)
		bgt.w	.ret
	.fireSpear:
		addq.b	#1,(v_bulletsonscreen).w
		subq.b	#1,(v_weapon4energy).w
		bchg	#4,obStatus(a0)	; status bit for this specifically
		move.w	#sfx_A2,d0	; spikeyish sound
		jsr		(PlaySound_Special).l	; play shooting sound
		jsr		FindFreeObj
		move.b	#id_BusterShot,0(a1)	; load missile object
		move.b	#3,obSubtype(a1)
		move.w	#$7C0,obVelX(a1)
		move.w	#$40,d0
		moveq	#0,d1	; blue
		btst	#4,obStatus(a0)
		beq.s	.contSpear
		neg.w	d0
		moveq	#3,d1	; pink
	.contSpear:
		move.w	d0,obVelY(a1)
		lea		.palLUT(pc,d1.w),a2	; load appropriate color into a2
		lea		(v_pal_dry+14).w,a3	; first blue
		move.l	(a2,d1.w),(a3)+ ; write first two palette entries
		move.w	4(a2,d1.w),(a3)+ ; write last palette entry
		move.b	#2,(v_busterfx+obAnim).w
		bra.s	.objectLoadedJumpPoint
	.fireLemon:
		addq.b	#1,(v_bulletsonscreen).w
		move.w	#sfx_BusterShot,d0
		jsr		(PlaySound_Special).l	; play shooting sound
		jsr		FindFreeObj
		move.b	#id_BusterShot,0(a1)	; load missile object
		move.w	#$700,obVelX(a1)
		move.b	#1,(v_busterfx+obAnim).w
;		bra.s	.objectLoadedJumpPoint
	.objectLoadedJumpPoint:
		jsr		FireWeapon
	.ret:
		rts
	.outofenergy:
		cmpi.b	#3,(v_bulletsonscreen).w
		bge.s	.ret
		btst	#bitB,(v_jpadpress2).w
		bne.s	.fireLemon
		rts
	
	.palLUT:
		dc.w	$EEE,$EAA,$A66	; blue
		dc.w	$EEE,$A8E,$64A	; pink
		even