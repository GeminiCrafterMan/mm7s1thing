	Weapon_MegaBuster:
		btst	#bitB,(v_jpadhold2).w	; holding B?
		beq.w	FireMegaBuster	; if not, go do the charge shot thing
	.charging:
	; play the sounds and do stuff with adding
		cmpi.b	#$64,(v_charge).w
		beq.s	.maxChrgSnd	; if 64, hit that loop
	; under 64
		cmpi.b	#$32,(v_charge).w
		bne.s	.contAdding	; if not 32, continue adding
	.midChrgSnd:
		move.w	#sfx_ChargeStart,d0
		jsr		(PlaySound_Special).l	; play charge start sound
		bra.s	.contAdding
	.maxChrgSnd:
		move.b	#$5C,(v_charge).w	; set to $5C to restart this loop
		move.w	#sfx_ChargeLoop,d0
		jsr		(PlaySound_Special).l	; play fully charged sound
		bra.s	.ret
	.contAdding:
		addq.b	#1,(v_charge).w
	.ret:
		rts

	FireMegaBuster:
		cmpi.b	#id_Slide,obAnim(a0)
		beq.w	.dontFire
		cmpi.b	#3,(v_bulletsonscreen).w
		bge.w	.dontFire
		btst	#bitB,(v_jpadpress2).w	; pressing B?
		bne.s	.fireLemon	; fire lemon if so
		tst.b	(v_charge).w	; don't fire if not charging
		beq.w	.dontFire
		cmpi.b	#$20,(v_charge).w
		blt.s	.fireLemon	; not charged enough to care
		cmpi.b	#$40,(v_charge).w
		blt.s	.fireMediumCharge	; medium charge
		cmpi.b	#$5C,(v_charge).w
		blt.s	.fireMediumCharge	; medium charge
		bra.s	.fireFullCharge	; full charge
	.fireLemon:
		addq.b	#1,(v_bulletsonscreen).w
		move.w	#sfx_BusterShot,d0
		jsr		(PlaySound_Special).l	; play shooting sound
		jsr		FindFreeObj
		move.b	#id_BusterShot,0(a1)	; load missile object
		move.w	#$700,obVelX(a1)
		move.b	#1,(v_busterfx+obAnim).w
		bra.w	.objectLoadedJumpPoint
	.fireMediumCharge:
		addq.b	#1,(v_bulletsonscreen).w
		move.w	#sfx_BusterShot,d0
		jsr		(PlaySound_Special).l	; play shooting sound
		jsr		FindFreeObj
		move.b	#id_BusterShot,0(a1)	; load missile object
		move.b	#1,obSubtype(a1)
		move.b	#2,(v_busterfx+obAnim).w
		move.w	#$740,obVelX(a1)
		bra.s	.objectLoadedJumpPoint
	.fireFullCharge:
		addq.b	#3,(v_bulletsonscreen).w
		move.w	#sfx_BusterShot,d0
		jsr		(PlaySound_Special).l	; play shooting sound
		jsr		FindFreeObj
		move.b	#id_BusterShot,0(a1)	; load missile object
		move.b	#2,obSubtype(a1)
		move.b	#3,(v_busterfx+obAnim).w
		move.w	#$780,obVelX(a1)
	; god damn this is nasty
		move.w	#$222,d0
		move.w	d0,(v_pal_dry+2)
		move.w	d0,(v_pal_dry+4)
		move.w	d0,(v_pal_dry+6)
		move.w	d0,(v_pal_dry+8)
		move.w	d0,(v_pal_dry+10)
		move.w	d0,(v_pal_dry+14)
		move.w	d0,(v_pal_dry+16)
		move.w	d0,(v_pal_dry+18)
		move.b	#$C,(v_vbla_routine).w
		jsr		WaitForVBla
;		bra.s	.objectLoadedJumpPoint
	.objectLoadedJumpPoint:
		jsr		FireWeapon
	.dontFire:
	; ugghhh i hate this lmaooo
		moveq	#0,d0
		lea	(Pal_MegaMan).l,a2
		lea	(v_pal_dry).w,a3
		move.l	(a2,d0.w),(a3)+
		move.l	4(a2,d0.w),(a3)+
		move.l	8(a2,d0.w),(a3)+
		move.l	12(a2,d0.w),(a3)+
		move.l	16(a2,d0.w),(a3)+
		move.l	20(a2,d0.w),(a3)+
		move.l	24(a2,d0.w),(a3)+
		move.l	28(a2,d0.w),(a3)+
		clr.b	(v_charge).w	; clear charge
		clr.b	(v_chargecyctimer).w	; clear charge
		clr.b	(v_chargecycnum).w	; clear charge
		rts