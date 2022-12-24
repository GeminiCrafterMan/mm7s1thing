MegaMan_Shoot:
	; okay so there was a B button check here, but i think it may be better if i did that in the weapon for the sake of hold checks
		moveq	#0,d0
		move.b	(v_weapon).w,d0
		add.w	d0,d0
		add.w	d0,d0
		movea.l	.weaponLUT(pc,d0.w),a1
		jmp		(a1)
	.weaponLUT:
		dc.l	Weapon_MegaBuster, Weapon_Test, Weapon_Test, Weapon_Test, Weapon_LabyrinthSpear, Weapon_Test, Weapon_Test, Weapon_Test, Weapon_Test
	.ret:
		rts
	
	FireWeapon:
		move.w	(v_busterfx+obX).w,obX(a1)
		move.w	(v_busterfx+obY).w,obY(a1)
		btst	#0,(v_busterfx+obStatus).w
		beq.s	.notFlipped
		neg.w	obVelX(a1)
		bset	#0,obStatus(a1)
	;	subi.w	#15,obX(a1)
;		bra.s	.doneFlipChk
;
	.notFlipped:
	;	addi.w	#15,obX(a1)
	;.doneFlipChk:
		bset	#7,obStatus(a0)		; set 'shooting' flag in status
		move.b	#13,shoottimer(a0)
		cmpi.b	#id_Wait,obAnim(a0)
		beq.s	.shootAnim
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

; Weapon includes
	include	"_incObj/Player/Weapons/Mega Buster.asm"
	include	"_incObj/Player/Weapons/Test.asm"
	include "_incObj/Player/Weapons/Labyrinth Spear.asm"