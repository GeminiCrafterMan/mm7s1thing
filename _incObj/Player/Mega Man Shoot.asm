MegaMan_Shoot:
		cmpi.b	#id_Slide,obAnim(a0)    ; sliding? probably replace with status check
		beq.s   .noShoot
		moveq	#0,d0
		btst    #bitB,(v_jpadpress2).w
        bne.s   .shoot
    .noShoot:
        rts
    .shoot: ; please god make this more modular later
        bset    #7,obStatus(a0) ; set 'shooting' flag in status
        move.b  #13,shoottimer(a0)
        cmpi.b  #id_Wait,obAnim(a0)
        beq.s   .shootAnim
        cmpi.b  #id_Shoot,obAnim(a0)
        beq.s   .shootAnim
        bra.s   .skipShootAnim
    .shootAnim:
        clr.b   obAniFrame(a0)
        clr.b   obTimeFrame(a0)
        clr.b   obDelayAni(a0)
        move.b  #id_Shoot,obAnim(a0)
    ; probably won't set the animation here... maybe in Animate?
    .skipShootAnim:
		move.w	#sfx_BusterShot,d0
		jsr	(PlaySound_Special).l	; play shooting sound
        rts