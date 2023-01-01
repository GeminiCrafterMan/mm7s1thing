MegaMan_WeaponChange:
		tst.b	(v_bulletsonscreen).w
		bne.s	.ret
		tst.b	(f_jpad_6button).w	; is it a 3-button controller?
		beq.s	.3btn				; if so, i ain't havin that shit
		btst	#bitX,(v_jpadpress2_6btn).w	; X check
		bne.s	.upWep
		btst	#bitY,(v_jpadpress2_6btn).w	; Y check
		bne.s	.resetWep
		btst	#bitZ,(v_jpadpress2_6btn).w	; Z check
		bne.s	.downWep
		rts
	.3btn:
	; check for A hold
		btst	#bitA,(v_jpadhold2).w
		beq.s	.ret
	; check for Up press
		btst	#bitUp,(v_jpadpress2).w
		bne.s	.upWep
	; check for Down press
		btst	#bitDn,(v_jpadpress2).w
		bne.s	.downWep
	.ret:
		rts
	.upWep:
		subq.b	#1,(v_weapon).w	; subtract 1
		tst.b	(v_weapon).w	; if above 0
		bge.s	.loadWepPal			; return
		move.b	#8,(v_weapon).w	; wrap back around if above
		bra.s	.loadWepPal
	.downWep:
		addq.b	#1,(v_weapon).w	; add 1
		cmpi.b	#9,(v_weapon).w	; if below 9
		blt.s	.loadWepPal			; return
	.resetWep:
		clr.b	(v_weapon).w	; wrap back around if above
	; continue into .loadWepPal
	.loadWepPal:
		bclr	#4,obStatus(a0)	; used by a couple weapons to determine which shot you're on (LSpear's switching, SYZWep's picking up/throwing)
	; fucking... reload the shit. god. i hate this.
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

		moveq	#0,d0
		move.b	(v_weapon).w,d0
		mulu.w	#6,d0	; multiply by 6
		lea		.palLUT(pc,d0.w),a2	; load appropriate color into a2
		lea		(v_pal_dry+4).w,a3	; first blue
		move.l	(a2,d0.w),(a3)+ ; write first two palette entries
		move.w	4(a2,d0.w),(a3) ; write third palette entry
		move.l	6(a2,d0.w),6(a3) ; write next two palette entries after skipping 2 colors
		move.w	10(a2,d0.w),10(a3) ; write last palette entry

		clr.b	(v_charge).w	; clear charge
		clr.b	(v_chargecyctimer).w	; clear charge
		clr.b	(v_chargecycnum).w	; clear charge
		rts

	.palLUT:
	; BGR instead of RGB
	;	dc.w	  dark parts  ,  light  parts
		dc.w	$620,$C40,$E60, $ECA,$EA6,$E84	; Mega Buster
		dc.w	$004,$026,$048, $0CE,$08E,$06C	; Green Wrecker
		dc.w	$624,$846,$A68, $0AE,$46E,$22C	; Marble Blazer
		dc.w	$004,$028,$24A, $8AE,$66C,$648	; SYZ
		dc.w	$026,$048,$28C, $EEE,$EAA,$A66	; Labyrinth Spear (Blue)
		dc.w	$042,$264,$486, $EEE,$AAA,$666	; Orbit Shield
		dc.w	$620,$C40,$E60, $ECA,$EA6,$E84	; SBZ
		dc.w	$206,$20A,$42E, $ECE,$CAE,$86E	; Rush Coil
		dc.w	$206,$20A,$42E, $ECE,$CAE,$86E	; Rush Jet (same as above)
		even