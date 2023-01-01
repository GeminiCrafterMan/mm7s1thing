MegaMan_Teleport:
		tst.b	(f_victory).w
		bne.w	.exit
		tst.b	(v_act).w
		bne.w	.doneIntro
		cmpi.b	#id_Wait,obAnim(a0)
		beq.s	.doneIntro
		cmpi.b	#id_Intro,obAnim(a0)	; is animation intro finish?
		beq.s	.dontRepeatIntro		; if so, do not repeat
		cmpi.b	#id_TeleportBeam,obAnim(a0)
		beq.s	.dontSetPos
		move.b	#id_TeleportBeam,obAnim(a0)
		clr.w	obY(a0)
	.dontSetPos:
		move.w	obY(a0),d1
		move.w	(v_startposy).w,d2
		cmp.w	d2,d1
		blt.s	.introLoop	; hasn't touched the start position yet
	.dontRepeatIntro:
		move.w	(v_startposy).w,d2
		move.w	d2,obY(a0)	; in case he missed it
		move.b	#id_Intro,obAnim(a0)
		bsr.w	Sonic_Display
		bsr.w	Sonic_Animate
		bsr.w	Sonic_LoadGfx
		clr.w	obVelY(a0)
		rts
	.introLoop:
		move.w	#$A00,obVelY(a0)
		bsr.w	Sonic_Display
		bsr.w	Sonic_Animate
		bsr.w	Sonic_LoadGfx
		jmp		SpeedToPos
	.doneIntro:
		subq.b	#8,obRoutine(a0)
		rts
	.exit:
		cmpi.b	#id_TeleportBeam,obAnim(a0)
		beq.s	.dontRepeatExit
		move.b	#id_Exit,obAnim(a0)
		bsr.w	Sonic_Display
		bsr.w	Sonic_Animate
		bsr.w	Sonic_LoadGfx
		rts
	.dontRepeatExit:
		cmpi.b	#id_TeleportBeam,obAnim(a0)
		bne.s	.ret
		move.w	obY(a0),d1
		move.w	(v_exitlevely).w,d2
		cmp.w	d1,d2
		blt.s	.notYet
		move.w	(v_exitlevely).w,obY(a0)
		clr.w	obVelY(a0)
		rts
	.notYet:
		move.w	#-$A00,obVelY(a0)
		bsr.w	Sonic_Display
		bsr.w	Sonic_Animate
		bsr.w	Sonic_LoadGfx
		jmp		SpeedToPos
	.ret:
		rts