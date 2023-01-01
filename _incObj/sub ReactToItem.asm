; ---------------------------------------------------------------------------
; Subroutine to react to obColType(a0)
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


ReactToItem:
		nop
		move.w	obX(a0),d2	; load Sonic's x-axis position
		move.w	obY(a0),d3	; load Sonic's y-axis position
		subq.w	#8,d2
		moveq	#0,d5
		move.b	obHeight(a0),d5	; load Sonic's height
		subq.b	#3,d5
		sub.w	d5,d3
		cmpi.b	#fr_Slide1,obFrame(a0) ; is Mega Man sliding?
		blt.s	.notsliding	; if not, branch
		cmpi.b	#fr_Slide2,obFrame(a0) ; is Mega Man sliding?
		bgt.s	.notsliding	; if not, branch
		addi.w	#$C,d3
		moveq	#$A,d5

.notsliding:
		move.w	#$10,d4
		add.w	d5,d5
		lea	(v_lvlobjspace).w,a1 ; set object RAM start address
		move.w	#$5F,d6

.loop:
		tst.b	obRender(a1)
		bpl.s	.next
		move.b	obColType(a1),d0 ; load collision type
		bne.s	.proximity	; if nonzero, branch

.next:
		lea	$40(a1),a1	; next object RAM
		dbf	d6,.loop	; repeat $5F more times

		moveq	#0,d0
		rts
; ===========================================================================
.sizes:		;   width, height
		dc.b  $14, $14		; $01
		dc.b   $C, $14		; $02
		dc.b  $14,  $C		; $03
		dc.b	4, $10		; $04
		dc.b   $C, $12		; $05
		dc.b  $10, $10		; $06
		dc.b	6,   6		; $07
		dc.b  $18,  $C		; $08
		dc.b   $C, $10		; $09
		dc.b  $10,  $C		; $0A
		dc.b	8,   8		; $0B
		dc.b  $14, $10		; $0C
		dc.b  $14,   8		; $0D
		dc.b   $E,  $E		; $0E
		dc.b  $18, $18		; $0F
		dc.b  $28, $10		; $10
		dc.b  $10, $18		; $11
		dc.b	8, $10		; $12
		dc.b  $20, $70		; $13
		dc.b  $40, $20		; $14
		dc.b  $80, $20		; $15
		dc.b  $20, $20		; $16
		dc.b	8,   8		; $17
		dc.b	4,   4		; $18
		dc.b  $20,   8		; $19
		dc.b   $C,  $C		; $1A
		dc.b	8,   4		; $1B
		dc.b  $18,   4		; $1C
		dc.b  $28,   4		; $1D
		dc.b	4,   8		; $1E
		dc.b	4, $18		; $1F
		dc.b	4, $28		; $20
		dc.b	4, $20		; $21
		dc.b  $18, $18		; $22
		dc.b   $C, $18		; $23
		dc.b  $48,   8		; $24
; ===========================================================================

.proximity:
		andi.w	#$3F,d0
		add.w	d0,d0
		lea	.sizes-2(pc,d0.w),a2
		moveq	#0,d1
		move.b	(a2)+,d1
		move.w	obX(a1),d0
		sub.w	d1,d0
		sub.w	d2,d0
		bcc.s	.outsidex	; branch if not touching
		add.w	d1,d1
		add.w	d1,d0
		bcs.s	.withinx	; branch if touching
		bra.w	.next
; ===========================================================================

.outsidex:
		cmp.w	d4,d0
		bhi.w	.next

.withinx:
		moveq	#0,d1
		move.b	(a2)+,d1
		move.w	obY(a1),d0
		sub.w	d1,d0
		sub.w	d3,d0
		bcc.s	.outsidey	; branch if not touching
		add.w	d1,d1
		add.w	d0,d1
		bcs.s	.withiny	; branch if touching
		bra.w	.next
; ===========================================================================

.outsidey:
		cmp.w	d5,d0
		bhi.w	.next

.withiny:
.chktype:
		move.b	obColType(a1),d1 ; load collision type
		andi.b	#$C0,d1		; is obColType $40 or higher?
		beq.w	React_Enemy	; if not, branch
		cmpi.b	#$C0,d1		; is obColType $C0 or higher?
		beq.w	React_Special	; if yes, branch
		tst.b	d1		; is obColType $80-$BF?
		bmi.w	React_ChkHurt	; if yes, branch

; obColType is $40-$7F (powerups)

		move.b	obColType(a1),d0
		andi.b	#$3F,d0
		cmpi.b	#6,d0		; is collision type $46	?
		beq.s	React_Monitor	; if yes, branch
		cmpi.b	#id_BusterShot,0(a0)
		bne.s	.notBullet
		bra.s	.invincible
	.notBullet:
		cmpi.b	#90,flashtime(a0)	; is Sonic invincible?
		bcc.w	.invincible	; if yes, branch
		addq.b	#2,obRoutine(a1) ; advance the object's routine counter

.invincible:
		rts
; ===========================================================================

React_Monitor:
		cmpi.b	#id_BusterShot,0(a0)
		bne.s	.notBullet
		subq.b	#1,obColProp(a0)
		bne.s	.dontDestroyShot
		bset	#7,obStatus(a0)
	.dontDestroyShot:
		bra.s	.break
	.notBullet:
		tst.w	obVelY(a0)	; is Sonic moving upwards?
		bpl.s	.movingdown	; if not, branch

		move.w	obY(a0),d0
		subi.w	#$10,d0
		cmp.w	obY(a1),d0
		bcs.s	.donothing
		neg.w	obVelY(a0)	; reverse Sonic's vertical speed
		move.w	#-$180,obVelY(a1)
		tst.b	ob2ndRout(a1)
		bne.s	.donothing
		addq.b	#4,ob2ndRout(a1) ; advance the monitor's routine counter
		rts
; ===========================================================================

.movingdown:
		cmpi.b	#id_Roll,obAnim(a0) ; is Sonic rolling/jumping?
		bne.s	.donothing
		neg.w	obVelY(a0)	; reverse Sonic's y-motion
	.break:
		addq.b	#2,obRoutine(a1) ; advance the monitor's routine counter

.donothing:
		rts
; ===========================================================================

React_Enemy:
		cmpi.b	#id_BusterShot,0(a0)
		bne.s	.notBullet
		subq.b	#1,obColProp(a0)
		bne.s	.dontDestroyShot
		bset	#7,obStatus(a0)
	.dontDestroyShot:
		bra.s	.donthurtsonic
	.notBullet:
		tst.b	(v_invinc).w	; is Sonic invincible?
		bne.s	.donthurtsonic	; if yes, branch
		cmpi.b	#id_Roll,obAnim(a0) ; is Sonic rolling/jumping?
		bne.w	React_ChkHurt	; if not, branch

.donthurtsonic:
		tst.b	obColProp(a1)
		beq.s	.breakenemy

		move.b	#0,obColType(a1)
		cmpi.b	#id_BusterShot,0(a0)
		beq.s	.hpChecksDHS
		neg.w	obVelX(a0)	; repel Sonic
		neg.w	obVelY(a0)
		asr	obVelX(a0)
		asr	obVelY(a0)
		subq.b	#1,obColProp(a1)	; subtract 1 from enemy's HP
		bne.s	.flagnotclear		; if it's not 0, return
	.killHPEnemy:
		bset	#7,obStatus(a1)		; if it is, set bit 7

.flagnotclear:
		rts

.hpChecksDHS:
		move.b	obColProp(a0),d0
		subi.b	d0,obColProp(a1)	; subtract buster shot HP from enemy's...
		ble.s	.killHPEnemy		; and break the enemy if it's 0
		bset	#7,obStatus(a0)		; otherwise, destroy the buster shot
		bra.s	.flagnotclear
; ===========================================================================

.breakenemy:
		bset	#7,obStatus(a1)

		move.w	#50,d0
		bsr.w	AddPoints
		_move.b	#id_ExplosionItem,0(a1) ; change object to explosion
		move.b	#0,obRoutine(a1)
		move.w	obX(a1),d1
		move.w	obY(a1),d2
		cmpi.b	#id_BusterShot,0(a0)
		beq.s	.spawnItem
		tst.w	obVelY(a0)
		bmi.w	.bouncedown
		move.w	obY(a0),d0
		cmp.w	obY(a1),d0
		bcc.w	.bounceup
		neg.w	obVelY(a0)
	.spawnItem:
	; Create a random drop!
	; From a disassembly of Mega Man 1, the rates are...
	;
	; Nothing = 24/128
	; 1 Up = 1/128
	; Bonus Ball = 69/128
	; Small Weapon = 15/128
	; Small Health = 15/128
	; Large Weapon = 2/128
	; Large Health = 2/128
	;
	; I don't actually want to work on this at the moment, so it just spawns a score ball instead.
		moveq	#0,d0
		jsr		FindFreeObj
		move.b	#id_Items,0(a1)
		move.w	d1,obX(a1)
		move.w	d2,obY(a1)
		moveq	#0,d0
;		moveq	#0,d1
		jsr		(RandomNumber).l
		andi.w	#127,d0
		move.b	.itemProbabilityLUT(pc,d0.w),obSubtype(a1)
;		move.b	#8,obSubtype(a1)
	.ret:
		rts

; ===========================================================================

.bouncedown:
		addi.w	#$100,obVelY(a0)
		rts

.bounceup:
		subi.w	#$100,obVelY(a0)
		rts
.itemProbabilityLUT:
	; nothing
		rept 24
			dc.b 9
		endm
	; 1up
		dc.b 0
	; no etanks will probably not be included
	; bonus ball
		rept 69
			dc.b 8
		endm
	; small health & small weapon energy
		rept 15
			dc.b 5
			dc.b 7
		endm
	; large health & weapon energy
		dc.b 4, 4, 6, 6
	even

; ===========================================================================

React_Caterkiller:
		bset	#7,obStatus(a1)

React_ChkHurt:
		cmpi.b	#id_BusterShot,0(a0)
		beq.s	.isflashing
		tst.b	(v_invinc).w	; is Sonic invincible?
		beq.s	.notinvincible	; if not, branch

.isflashing:
		moveq	#-1,d0
		rts
; ===========================================================================

.notinvincible:
		nop
		tst.b	flashtime(a0)		; is Sonic flashing?
		bne.s	.isflashing	; if yes, branch
		movea.l	a1,a2

; End of function ReactToItem
; continue straight to HurtSonic

; ---------------------------------------------------------------------------
; Hurting Sonic	subroutine
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


HurtSonic:
		tst.b	(v_weapon).w
		bne.s	.notMB
		lea	(Pal_MegaMan).l,a2
		jsr		FireMegaBuster.dontFire
	.notMB:
		tst.b	(v_shield).w	; does Sonic have a shield?
		bne.s	.hasshield	; if yes, branch
		tst.w	(v_rings).w	; does Sonic have any rings?
		beq.w	.norings	; if not, branch

		jsr	(FindFreeObj).l
		bne.s	.hasshield
		_move.b	#id_RingLoss,0(a1) ; load bouncing multi rings object
		move.w	obX(a0),obX(a1)
		move.w	obY(a0),obY(a1)

.hasshield:
		move.b	#0,(v_shield).w	; remove shield
		move.b	#4,obRoutine(a0)
		bsr.w	Sonic_ResetOnFloor
		bset	#1,obStatus(a0)
		clr.w	obVelY(a0) ; make Sonic bounce away from the object
		move.w	#-$200,obVelX(a0)
		btst	#6,obStatus(a0)	; is Sonic underwater?
		beq.s	.isdry		; if not, branch

		move.w	#-$100,obVelX(a0)

.isdry:
		move.w	obX(a0),d0
		cmp.w	obX(a2),d0
		bcs.s	.isleft		; if Sonic is left of the object, branch
		neg.w	obVelX(a0)	; if Sonic is right of the object, reverse

.isleft:
		move.w	#0,obInertia(a0)
		move.b	#id_Hurt,obAnim(a0)
		move.b	#60*2,flashtime(a0)	; set temp invincible time to 2 seconds
		move.w	#sfx_Hit,d0	; load normal damage sound
		cmpi.b	#id_Spikes,(a2)	; was damage caused by spikes?
		bne.s	.sound		; if not, branch
		cmpi.b	#id_Harpoon,(a2) ; was damage caused by LZ harpoon?
		bne.s	.sound		; if not, branch
		move.w	#sfx_HitSpikes,d0 ; load spikes damage sound

.sound:
		jsr	(PlaySound_Special).l
		moveq	#-1,d0
		rts
; ===========================================================================

.norings:
		tst.w	(f_debugmode).w	; is debug mode	cheat on?
		bne.w	.hasshield	; if yes, branch
		bra.s	KillSonic

; ---------------------------------------------------------------------------
; Subroutine to	kill Sonic
; ---------------------------------------------------------------------------

; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||

DeathOrbs_VelTbl:	; okay this kind of makes no sense but it also works to help visualize the orbs
		dc.w	-$180, -$180,	$0, -$200,	$180, -$180
		dc.w					$0, -$100
		dc.w	-$200, $0,	-$100, 0,	$100, 0,	$200, 0
		dc.w					$0, $100
		dc.w	-$180, $180,	$0, $200,	$180, $180
	even

KillSonic:
		tst.w	(v_debuguse).w	; is debug mode	active?
		bne.w	.dontdie	; if yes, branch
		move.b	#0,(v_shield).w	; remove shield
		move.b	#0,(v_invinc).w	; remove invincibility
		moveq	#12-1,d1	; 12 total, counting the first
		lea		(DeathOrbs_VelTbl).l,a3
	.spawnOrbs:
		jsr		FindFreeObj	; uses a1
		move.b	#id_DeathOrbs,0(a1)
		move.w	(o_player+obX).w,obX(a1)
		move.w	(o_player+obY).w,obY(a1)
		move.w	(a3)+,obVelX(a1)
		move.w	(a3)+,obVelY(a1)
		dbf		d1,.spawnOrbs
	.done:
		move.b	#6,obRoutine(a0)
;		bsr.w	Sonic_ResetOnFloor
		bset	#1,obStatus(a0)
		move.w	#0,obVelX(a0)
		move.w	#0,obInertia(a0)
		move.w	obY(a0),$38(a0)
		move.b	#id_Death,obAnim(a0)
		bset	#7,obGfx(a0)

.sound:
		move.w	#bgm_Stop,d0
		jsr		PlaySound
		move.b	#1,(f_pause).w
		move.w  #32,d0

	.wait:
		move.b	#$C,(v_vbla_routine).w
		jsr		WaitForVBla
		dbf		d0,.wait
		move.b	#0,(f_pause).w

		move.w	#sfx_Death,d0	; play normal death sound
		jsr	(PlaySound_Special).l

.dontdie:
		moveq	#-1,d0
		rts
; End of function KillSonic


; ||||||||||||||| S U B	R O U T	I N E |||||||||||||||||||||||||||||||||||||||


React_Special:
		move.b	obColType(a1),d1
		andi.b	#$3F,d1
		cmpi.b	#$B,d1		; is collision type $CB	?
		beq.s	.caterkiller	; if yes, branch
		cmpi.b	#$C,d1		; is collision type $CC	?
		beq.s	.yadrin		; if yes, branch
		cmpi.b	#id_BusterShot,0(a0)
		bne.s	.notBullet
		subq.b	#1,obColProp(a0)
		bne.s	.dontDestroyShot
		bset	#7,obStatus(a0)
	.dontDestroyShot:
		bra.s	.return
	.notBullet:
		cmpi.b	#$17,d1		; is collision type $D7	?
		beq.s	.D7orE1		; if yes, branch
		cmpi.b	#$21,d1		; is collision type $E1	?
		beq.s	.D7orE1		; if yes, branch
	.return:
		rts
; ===========================================================================

.caterkiller:
		bra.w	React_Caterkiller
; ===========================================================================

.yadrin:
		sub.w	d0,d5
		cmpi.w	#8,d5
		bcc.s	.normalenemy
		move.w	obX(a1),d0
		subq.w	#4,d0
		btst	#0,obStatus(a1)
		beq.s	.noflip
		subi.w	#$10,d0

.noflip:
		sub.w	d2,d0
		bcc.s	.loc_1B13C
		addi.w	#$18,d0
		bcs.s	.loc_1B140
		bra.s	.normalenemy
; ===========================================================================

.loc_1B13C:
		cmp.w	d4,d0
		bhi.s	.normalenemy

.loc_1B140:
		bra.w	React_ChkHurt
; ===========================================================================

.normalenemy:
		bra.w	React_Enemy
; ===========================================================================

.D7orE1:
		addq.b	#1,obColProp(a1)
		rts
; End of function React_Special
