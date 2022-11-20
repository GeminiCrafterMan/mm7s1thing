MegaMan_Slide:
		btst	#2,obStatus(a0)
		bne.s	.slideTimeTest ; keep sliding
		btst	#bitDn,(v_jpadhold2).w ; is down being pressed?
		beq.s	.ret	; if not, branch
		andi.b	#btnABC,(v_jpadpress2).w	; is A, B or C pressed? ; change later when you add shooting and the rush coil button