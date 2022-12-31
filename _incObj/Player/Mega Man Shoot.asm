MegaMan_Shoot:
	; okay so there was a B button check here, but i think it may be better if i did that in the weapon for the sake of hold checks
		moveq	#0,d0
		move.b	(v_weapon).w,d0
		add.w	d0,d0
		add.w	d0,d0
		movea.l	.weaponLUT(pc,d0.w),a1
		jmp		(a1)
	.weaponLUT:
		dc.l	Weapon_MegaBuster, Weapon_Test, Weapon_MarbleBlazer, Weapon_Test, Weapon_LabyrinthSpear, Weapon_OrbitShield, Weapon_Test, Weapon_Test, Weapon_Test
	.ret:
		rts
	
	FireWeapon:
		move.w	(o_busterfx+obX).w,obX(a1)
		move.w	(o_busterfx+obY).w,obY(a1)
		btst	#0,(o_busterfx+obStatus).w
		beq.s	.notFlipped
		neg.w	obVelX(a1)
		bset	#0,obStatus(a1)
	.notFlipped:
		bset	#7,obStatus(a0)		; set 'shooting' flag in status
		bsr.s	SetShootingAnim
		cmpi.b	#id_Shoot,obAnim(a0)
		beq.s	.shootAnim
		bra.s	.ret
	.shootAnim:
		clr.b	obAniFrame(a0)
		clr.b	obTimeFrame(a0)
		clr.b	obDelayAni(a0)
		move.b	#id_Shoot,obAnim(a0)
    .ret:
		rts

SetShootingAnim:
		moveq	#0,d0
		move.b	(v_shottype).w,d0
		mulu.w	#6,d0
		cmpi.b	#id_TiptoeHold,obAnim(a0)
		bgt.s	.notTiptoe
		bra.s	.notLanding
	.notTiptoe:
		cmpi.b	#id_WalkingHold,obAnim(a0)
		bgt.s	.notWalking
		addq.b	#1,d0
		bra.s	.notLanding
	.notWalking:
		cmpi.b	#id_PainIdle,obAnim(a0)
		bgt.s	.notIdle
		addq.b	#2,d0
		bra.s	.notLanding
	.notIdle:
		cmpi.b	#id_JumpHold,obAnim(a0)
		bgt.s	.notJumping
		addq.b	#3,d0
		move.b	.animLUT(pc,d0.w),obNextAni(a0)
		bra.s	.notLanding
	.notJumping:
		cmpi.b	#id_FallHold,obAnim(a0)
		bgt.s	.notFalling
		addq.b	#4,d0
		move.b	.animLUT(pc,d0.w),obNextAni(a0)
		bra.s	.notLanding
	.notFalling:
		cmpi.b	#id_LandHold,obAnim(a0)
		bgt.s	.notLanding
		addq.b	#5,d0
		move.b	.animLUT(pc,d0.w),obNextAni(a0)
	.notLanding:
		move.b	.animLUT(pc,d0.w),obAnim(a0)
		rts
	.animLUT:	; tiptoe, walking, standing, jumping, falling, landing
		dc.b	id_TiptoeShoot,			id_WalkingShoot,		id_Shoot,				id_JumpShoot,		id_FallShoot,		id_LandShoot			; Normal shots
		dc.b	id_TiptoeShoot,			id_WalkingShoot,		id_ChargeShot,			id_JumpShoot,		id_FallShoot,		id_LandShoot			; Charge shot
		dc.b	id_PickUpStanding,		id_PickUpStanding,		id_PickUpStanding,		id_PickUpAir,		id_PickUpAir,		id_PickUpStanding		; Pick up
		dc.b	id_ThrowStanding,		id_ThrowStanding,		id_ThrowStanding,		id_ThrowAir,		id_ThrowAir,		id_ThrowStanding		; Throw
		dc.b	id_ShieldUseStanding,	id_ShieldUseStanding,	id_ShieldUseStanding,	id_ShieldUseAir,	id_ShieldUseAir,	id_ShieldUseStanding	; Use shield (mostly throwing)
		dc.b	id_ShieldStanding,		id_ShieldStanding,		id_ShieldStanding,		id_ShieldAir,		id_ShieldAir,		id_ShieldStanding		; Activate shield

; Weapon includes
	include	"_incObj/Player/Weapons/Mega Buster.asm"
	include	"_incObj/Player/Weapons/Test.asm"
	include "_incObj/Player/Weapons/Marble Blazer.asm"
	include "_incObj/Player/Weapons/Labyrinth Spear.asm"
	include	"_incObj/Player/Weapons/Orbit Shield.asm"