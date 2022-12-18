DeathOrbs:
        move.l  #Map_MegaMan,obMap(a0)
        move.w  #$780,obGfx(a0)
		move.b	#2,obPriority(a0)
		move.b	#4,obRender(a0)
        jsr     SpeedToPos
		move.b	(v_player+obFrame).w,obFrame(a0)
        jmp     DisplaySprite