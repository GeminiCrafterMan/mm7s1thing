; ---------------------------------------------------------------------------
; Animation script - Mega Man
; ---------------------------------------------------------------------------
Ani_MegaMan:

ptr_Null:			dc.w MegaAni_Null-Ani_MegaMan
; Walking
ptr_Tiptoe:			dc.w MegaAni_Tiptoe-Ani_MegaMan
ptr_TiptoeShoot:	dc.w MegaAni_TiptoeShoot-Ani_MegaMan
ptr_TiptoeHold:		dc.w MegaAni_TiptoeHold-Ani_MegaMan
ptr_Walking:		dc.w MegaAni_Walking-Ani_MegaMan
ptr_WalkingShoot:	dc.w MegaAni_WalkingShoot-Ani_MegaMan
ptr_WalkingHold:	dc.w MegaAni_WalkingHold-Ani_MegaMan
; Idle animations
ptr_Wait:			dc.w MegaAni_Wait-Ani_MegaMan
ptr_Shoot:			dc.w MegaAni_Shoot-Ani_MegaMan
ptr_ChargeShot:		dc.w MegaAni_ChargeShot-Ani_MegaMan
ptr_PickUpStanding:	dc.w MegaAni_PickUpStanding-Ani_MegaMan
ptr_HoldStanding:	dc.w MegaAni_HoldStanding-Ani_MegaMan
ptr_ThrowStanding:	dc.w MegaAni_ThrowStanding-Ani_MegaMan
ptr_ShieldUseStanding:	dc.w MegaAni_ShieldUseStanding-Ani_MegaMan
ptr_ShieldStanding:	dc.w MegaAni_ShieldStanding-Ani_MegaMan
ptr_PainIdle:		dc.w MegaAni_PainIdle-Ani_MegaMan
; Leftover Sonic 1 animations to make the engine happy, replace/remove later
ptr_Roll:			dc.w MegaAni_Roll-Ani_MegaMan
ptr_Roll2:			dc.w MegaAni_Roll2-Ani_MegaMan
ptr_Float1:			dc.w MegaAni_Float1-Ani_MegaMan
ptr_Float2:			dc.w MegaAni_Float2-Ani_MegaMan
ptr_Hang:			dc.w MegaAni_Hang-Ani_MegaMan
ptr_Hurt:			dc.w MegaAni_Hurt-Ani_MegaMan
ptr_WaterSlide:		dc.w MegaAni_WaterSlide-Ani_MegaMan
ptr_Float3:			dc.w MegaAni_Float3-Ani_MegaMan
ptr_Float4:			dc.w MegaAni_Float4-Ani_MegaMan
; Explodey balls
ptr_Death:			dc.w MegaAni_Death-Ani_MegaMan
; Airborne
ptr_PickUpAir:		dc.w MegaAni_PickUpAir-Ani_MegaMan
ptr_ThrowAir:		dc.w MegaAni_ThrowAir-Ani_MegaMan
ptr_ShieldUseAir:	dc.w MegaAni_ShieldUseAir-Ani_MegaMan
ptr_ShieldAir:		dc.w MegaAni_ShieldAir-Ani_MegaMan
ptr_Jump:			dc.w MegaAni_Jump-Ani_MegaMan
ptr_JumpShoot:		dc.w MegaAni_JumpShoot-Ani_MegaMan
ptr_JumpHold:		dc.w MegaAni_JumpHold-Ani_MegaMan
ptr_Fall:			dc.w MegaAni_Fall-Ani_MegaMan
ptr_FallShoot:		dc.w MegaAni_FallShoot-Ani_MegaMan
ptr_FallHold:		dc.w MegaAni_FallHold-Ani_MegaMan
ptr_Land:			dc.w MegaAni_Land-Ani_MegaMan
ptr_LandShoot:		dc.w MegaAni_LandShoot-Ani_MegaMan
ptr_LandHold:		dc.w MegaAni_LandHold-Ani_MegaMan
ptr_SlideStart:		dc.w MegaAni_SlideStart-Ani_MegaMan
ptr_Slide:			dc.w MegaAni_Slide-Ani_MegaMan
ptr_SlideStop:		dc.w MegaAni_SlideStop-Ani_MegaMan
ptr_Victory:		dc.w MegaAni_Victory-Ani_MegaMan
ptr_Intro:			dc.w MegaAni_Intro-Ani_MegaMan
ptr_TeleportBeam:		dc.w MegaAni_TeleportBeam-Ani_MegaMan
ptr_Exit:			dc.w MegaAni_Exit-Ani_MegaMan

MegaAni_Null:	dc.b $77, fr_Null, afChange, id_Tiptoe
		even
; Walking
MegaAni_Tiptoe:	dc.b $FF, fr_Step1, fr_Step2, afChange, id_Walking
		even
MegaAni_TiptoeShoot:	dc.b $FF, fr_Step1S, fr_Step2S, afChange, id_WalkingShoot
		even
MegaAni_TiptoeHold:	dc.b $FF, fr_Step1H, fr_Step2H, afChange, id_WalkingHold
		even
MegaAni_Walking:	dc.b $FF,	fr_Walk1,	fr_Walk2,	fr_Walk3,	fr_Walk4,	fr_Walk5,	fr_Walk6,	fr_Walk7,	fr_Walk8,	fr_Walk9,	fr_WalkA, afEnd
		even
MegaAni_WalkingShoot:	dc.b $FF,	fr_Walk1S,	fr_Walk2S,	fr_Walk3S,	fr_Walk4S,	fr_Walk5S,	fr_Walk6S,	fr_Walk7S,	fr_Walk8S,	fr_Walk9S,	fr_WalkAS, afEnd
		even
MegaAni_WalkingHold:	dc.b $FF,	fr_Walk1H,	fr_Walk2H,	fr_Walk3H,	fr_Walk4H,	fr_Walk5H,	fr_Walk6H,	fr_Walk7H,	fr_Walk8H,	fr_Walk9H,	fr_WalkAH, afEnd
		even
; Idle animations
MegaAni_Wait:	dc.b 3 ; speed of 3 so i don't have to type everything out so many times (it's only ever in increments of 2 anyway)
		rept 37
			dc.b fr_Stand
		endm
		dc.b fr_Blink1, fr_Blink2, fr_Blink2, fr_Blink1, fr_Stand, fr_Stand, fr_Blink2, fr_Blink2
		rept 27
			dc.b fr_Stand
		endm
		dc.b fr_Blink1, fr_Blink2, fr_Blink2, fr_Blink1, afEnd
		even
MegaAni_Shoot:	dc.b 0, fr_Shoot1, fr_Shoot2, fr_Shoot3, fr_Shoot2, fr_Shoot1, afBack, 1
		even
MegaAni_ChargeShot:	dc.b 7, fr_ChargeShot1, fr_ChargeShot2, fr_ChargeShot3, fr_ChargeShot4, afChange, id_Wait
		even
MegaAni_PickUpStanding:	dc.b 5, fr_PickUp1S, fr_PickUp1S, fr_PickUp2S, fr_PickUp3S, afChange, id_HoldStanding
		even
MegaAni_HoldStanding:	dc.b 3 ; speed of 3 so i don't have to type everything out so many times (it's only ever in increments of 2 anyway)
		rept 37
			dc.b fr_Hold1S
		endm
		dc.b fr_Hold2S, fr_Hold3S, fr_Hold3S, fr_Hold2S, fr_Hold1S, fr_Hold1S, fr_Hold3S, fr_Hold3S
		rept 27
			dc.b fr_Hold1S
		endm
		dc.b fr_Hold2S, fr_Hold3S, fr_Hold3S, fr_Hold2S, afEnd
		even
MegaAni_ThrowStanding:	dc.b 5, fr_PickUp3S, fr_Throw1S, fr_Throw2S, fr_Throw3S, fr_Throw3S, afChange, id_Wait
		even
MegaAni_ShieldUseStanding:	dc.b 5, fr_ShieldU1S, fr_ShieldU2S, fr_ShieldU3S, fr_ShieldU4S, fr_ShieldU4S, afChange, id_Wait
		even
MegaAni_ShieldStanding:	dc.b 5, fr_Shield1S, fr_Shield2S, fr_Shield2S, fr_Shield3S, fr_Shield3S, fr_Throw3S, afChange, id_Wait
		even
MegaAni_PainIdle:	dc.b 9
		rept 3
			dc.b fr_PainI1, fr_PainI2, fr_PainI3, fr_PainI3, fr_PainI2, fr_PainI1, fr_PainI1
		endm
			dc.b fr_PainI1, fr_PainI4, fr_PainI5, fr_PainI4, fr_PainI1, fr_PainI1, fr_PainI1, afEnd
		even
; Leftover Sonic 1 animations to make the engine happy, replace/remove later
MegaAni_Roll:	dc.b $FE,  fr_Roll1,  fr_Roll2,  fr_Roll3,  fr_Roll4,  fr_Roll5,     afEnd, afEnd
		even
MegaAni_Roll2:	dc.b $FE,  fr_Roll1,  fr_Roll2,  fr_Roll5,  fr_Roll3,  fr_Roll4,  fr_Roll5, afEnd
		even
MegaAni_Float1:	dc.b 7,	fr_Float1, fr_Float4, afEnd
		even
MegaAni_Float2:	dc.b 7,	fr_Float1, fr_Float2, fr_Float5, fr_Float3, fr_Float6, afEnd
		even
MegaAni_Hang:	dc.b 4,	fr_Hang1, fr_Hang2, afEnd
		even
MegaAni_Hurt:	dc.b 3,	fr_Injury, afEnd
		even
MegaAni_WaterSlide:	dc.b 7, fr_Injury, fr_WaterSlide, afEnd
		even
MegaAni_Float3:	dc.b 3,	fr_Float1, fr_Float2, fr_Float5, fr_Float3, fr_Float6, afEnd
		even
MegaAni_Float4:	dc.b 3,	fr_Float1, afChange, id_Walking
		even
; The explodey balls
MegaAni_Death:	dc.b 1
		rept 6
			dc.b fr_Death1, fr_Death2, fr_Death3, fr_Death4, fr_Death5, fr_Death6, fr_Death7, fr_Death8, fr_Death9, fr_Null
		endm
			dc.b afEnd
		even
; Airborne
MegaAni_PickUpAir:	dc.b 3, fr_PickUp1A, fr_PickUp2A, afChange, id_JumpHold
		even
MegaAni_ThrowAir:	dc.b 3, fr_Throw1A, fr_Throw2A, afChange, id_Fall
		even
MegaAni_ShieldUseAir:	dc.b 1, fr_ShieldU1A, fr_ShieldU2A, fr_ShieldU3A, fr_ShieldU4A, fr_ShieldU4A, afChange, id_Fall
		even
MegaAni_ShieldAir:	dc.b 1, fr_Shield1A, fr_Shield2A, afChange, id_Fall
		even
MegaAni_Jump:	dc.b 1, fr_Jump1, fr_Jump2, fr_Jump2, fr_Jump3, fr_Jump3, fr_Jump4, afBack, 1
		even
MegaAni_JumpShoot:	dc.b 1, fr_Jump1S, fr_Jump2S, fr_Jump2S, fr_Jump3S, fr_Jump3S, fr_Jump4S, afBack, 1
		even
MegaAni_JumpHold:	dc.b 1, fr_Jump1H, fr_Jump2H, fr_Jump2H, fr_Jump3H, fr_Jump3H, fr_Jump4H, afBack, 1
		even
MegaAni_Fall:	dc.b 9, fr_Jump3, afEnd, afEnd, afEnd, afEnd, afEnd, afEnd
		even
MegaAni_FallShoot:	dc.b 9, fr_Jump3S, afEnd, afEnd, afEnd, afEnd, afEnd, afEnd
		even
MegaAni_FallHold:	dc.b 9, fr_Jump3H, afEnd, afEnd, afEnd, afEnd, afEnd, afEnd
		even
MegaAni_Land:	dc.b 1, fr_Jump2, fr_Jump1, afChange, id_Wait
		even
MegaAni_LandShoot:	dc.b 1, fr_Jump2S, fr_Jump1S, afChange, id_Shoot
		even
MegaAni_LandHold:	dc.b 1, fr_Jump2H, fr_Jump1H, afChange, id_Shoot
		even
MegaAni_SlideStart:	dc.b 1, fr_SlideT, afChange, id_Slide
		even
MegaAni_Slide:	dc.b 1, fr_Slide1, fr_Slide2, afEnd
		even
MegaAni_SlideStop:	dc.b 1, fr_SlideT, fr_SlideT, fr_SlideT, fr_SlideT, afChange, id_Wait
		even
MegaAni_Victory:	dc.b 3, fr_Victory1, fr_Victory2, fr_Victory2, fr_Victory3, fr_Victory4, fr_Victory5, afBack, 1
		even
MegaAni_Intro:		dc.b 3, fr_Tele2, fr_Tele3, fr_Tele4, fr_Tele5, fr_Intro1, fr_Intro2, fr_Intro3, fr_Intro4, fr_Intro5, fr_Intro6, fr_Intro7, afChange, id_Wait
		even
MegaAni_TeleportBeam:	dc.b $77, fr_Tele1, afEnd
		even
MegaAni_Exit:		dc.b 3, fr_Exit1, fr_Exit2, fr_Exit3, fr_Exit4, fr_Exit5, fr_Exit6, fr_Exit7, afChange, id_TeleportBeam
		even

; Animation IDs
id_Null:		equ (ptr_Null-Ani_MegaMan)/2	; $1C
; Walking
id_Tiptoe:		equ (ptr_Tiptoe-Ani_MegaMan)/2	; 0
id_TiptoeShoot:	equ (ptr_TiptoeShoot-Ani_MegaMan)/2	; 0
id_TiptoeHold:	equ (ptr_TiptoeHold-Ani_MegaMan)/2	; 0
id_Walking:		equ (ptr_Walking-Ani_MegaMan)/2	; 1
id_WalkingShoot:equ (ptr_WalkingShoot-Ani_MegaMan)/2	; 1
id_WalkingHold:equ (ptr_WalkingHold-Ani_MegaMan)/2	; 1
; Idle animations
id_Wait:		equ (ptr_Wait-Ani_MegaMan)/2	; 5
id_Shoot:		equ (ptr_Shoot-Ani_MegaMan)/2	; 5
id_ChargeShot:	equ (ptr_ChargeShot-Ani_MegaMan)/2
id_PickUpStanding:	equ (ptr_PickUpStanding-Ani_MegaMan)/2
id_HoldStanding:	equ (ptr_HoldStanding-Ani_MegaMan)/2
id_ThrowStanding:	equ (ptr_ThrowStanding-Ani_MegaMan)/2
id_ShieldUseStanding:	equ (ptr_ShieldUseStanding-Ani_MegaMan)/2
id_ShieldStanding:	equ (ptr_ShieldStanding-Ani_MegaMan)/2
id_PainIdle:	equ (ptr_PainIdle-Ani_MegaMan)/2
; Leftover Sonic 1 animations to make the engine happy
id_Roll:		equ (ptr_Roll-Ani_MegaMan)/2	; 2
id_Roll2:		equ (ptr_Roll2-Ani_MegaMan)/2	; 3
id_Float1:		equ (ptr_Float1-Ani_MegaMan)/2	; $E
id_Float2:		equ (ptr_Float2-Ani_MegaMan)/2	; $F
id_Hang:		equ (ptr_Hang-Ani_MegaMan)/2	; $11
id_Hurt:		equ (ptr_Hurt-Ani_MegaMan)/2	; $1A
id_WaterSlide:	equ (ptr_WaterSlide-Ani_MegaMan)/2 ; $1B
id_Float3:		equ (ptr_Float3-Ani_MegaMan)/2	; $1D
id_Float4:		equ (ptr_Float4-Ani_MegaMan)/2	; $1E
; Explodey balls
id_Death:		equ (ptr_Death-Ani_MegaMan)/2	; $18
; Airborne
id_PickUpAir:	equ (ptr_PickUpAir-Ani_MegaMan)/2
id_ThrowAir:	equ (ptr_ThrowAir-Ani_MegaMan)/2
id_ShieldUseAir:	equ (ptr_ShieldUseAir-Ani_MegaMan)/2
id_ShieldAir:	equ (ptr_ShieldAir-Ani_MegaMan)/2
id_Jump:		equ (ptr_Jump-Ani_MegaMan)/2	; $1D
id_JumpShoot:	equ (ptr_JumpShoot-Ani_MegaMan)/2	; $1D
id_JumpHold:	equ (ptr_JumpHold-Ani_MegaMan)/2	; $1D
id_Fall:		equ (ptr_Fall-Ani_MegaMan)/2	; $1E
id_FallShoot:	equ (ptr_FallShoot-Ani_MegaMan)/2	; $1E
id_FallHold:	equ (ptr_FallHold-Ani_MegaMan)/2	; $1E
id_Land:		equ (ptr_Land-Ani_MegaMan)/2
id_LandShoot:	equ (ptr_LandShoot-Ani_MegaMan)/2
id_LandHold:	equ (ptr_LandHold-Ani_MegaMan)/2
id_SlideStart:	equ (ptr_SlideStart-Ani_MegaMan)/2
id_Slide:		equ (ptr_Slide-Ani_MegaMan)/2
id_SlideStop:	equ (ptr_SlideStop-Ani_MegaMan)/2
id_Victory:		equ (ptr_Victory-Ani_MegaMan)/2
id_Intro:		equ (ptr_Intro-Ani_MegaMan)/2
id_TeleportBeam:	equ	(ptr_TeleportBeam-Ani_MegaMan)/2
id_Exit:		equ	(ptr_Exit-Ani_MegaMan)/2

; Sonic frame IDs
	phase 0 ; Reset ds.b value to 0

fr_Null:	ds.b 1
fr_Stand:	ds.b 1
fr_Blink1:	ds.b 1
fr_Blink2:	ds.b 1
fr_Shoot1:	ds.b 1
fr_Shoot2:	ds.b 1
fr_Shoot3:	ds.b 1
fr_ChargeShot1:	ds.b 1
fr_ChargeShot2:	ds.b 1
fr_ChargeShot3:	ds.b 1
fr_ChargeShot4:	ds.b 1
fr_PickUp1S:	ds.b 1
fr_PickUp2S:	ds.b 1
fr_PickUp3S:	ds.b 1
fr_Hold1S:	ds.b 1
fr_Hold2S:	ds.b 1
fr_Hold3S:	ds.b 1
fr_Throw1S:	ds.b 1
fr_Throw2S:	ds.b 1
fr_Throw3S:	ds.b 1
fr_ShieldU1S:	ds.b 1
fr_ShieldU2S:	ds.b 1
fr_ShieldU3S:	ds.b 1
fr_ShieldU4S:	ds.b 1
fr_Shield1S:	ds.b 1
fr_Shield2S:	ds.b 1
fr_Shield3S:	ds.b 1
fr_PainI1:	ds.b 1
fr_PainI2:	ds.b 1
fr_PainI3:	ds.b 1
fr_PainI4:	ds.b 1
fr_PainI5:	ds.b 1
fr_Roll1:	ds.b 1
fr_Roll2:	ds.b 1
fr_Roll3:	ds.b 1
fr_Roll4:	ds.b 1
fr_Roll5:	ds.b 1
fr_Float1:	ds.b 1
fr_Float2:	ds.b 1
fr_Float3:	ds.b 1
fr_Float4:	ds.b 1
fr_Hang1:	ds.b 1
fr_Hang2:	ds.b 1
fr_Float5:	ds.b 1
fr_Float6:	ds.b 1
fr_Injury:	ds.b 1
fr_WaterSlide:	ds.b 1
fr_SlideT:	ds.b 1
fr_Slide1:	ds.b 1
fr_Slide2:	ds.b 1
fr_Jump1:	ds.b 1
fr_Jump2:	ds.b 1
fr_Jump3:	ds.b 1
fr_Jump4:	ds.b 1
fr_Jump1S:	ds.b 1
fr_Jump2S:	ds.b 1
fr_Jump3S:	ds.b 1
fr_Jump4S:	ds.b 1
fr_PickUp1A:	ds.b 1
fr_PickUp2A:	ds.b 1
fr_Jump1H:	ds.b 1
fr_Jump2H:	ds.b 1
fr_Jump3H:	ds.b 1
fr_Jump4H:	ds.b 1
fr_Throw1A:	ds.b 1
fr_Throw2A:	ds.b 1
fr_ShieldU1A:	ds.b 1
fr_ShieldU2A:	ds.b 1
fr_ShieldU3A:	ds.b 1
fr_ShieldU4A:	ds.b 1
fr_Shield1A:	ds.b 1
fr_Shield2A:	ds.b 1
fr_Step1:	ds.b 1
fr_Step2:	ds.b 1
fr_Walk1:	ds.b 1
fr_Walk2:	ds.b 1
fr_Walk3:	ds.b 1
fr_Walk4:	ds.b 1
fr_Walk5:	ds.b 1
fr_Walk6:	ds.b 1
fr_Walk7:	ds.b 1
fr_Walk8:	ds.b 1
fr_Walk9:	ds.b 1
fr_WalkA:	ds.b 1
fr_Step1S:	ds.b 1
fr_Step2S:	ds.b 1
fr_Walk1S:	ds.b 1
fr_Walk2S:	ds.b 1
fr_Walk3S:	ds.b 1
fr_Walk4S:	ds.b 1
fr_Walk5S:	ds.b 1
fr_Walk6S:	ds.b 1
fr_Walk7S:	ds.b 1
fr_Walk8S:	ds.b 1
fr_Walk9S:	ds.b 1
fr_WalkAS:	ds.b 1
fr_Step1H:	ds.b 1
fr_Step2H:	ds.b 1
fr_Walk1H:	ds.b 1
fr_Walk2H:	ds.b 1
fr_Walk3H:	ds.b 1
fr_Walk4H:	ds.b 1
fr_Walk5H:	ds.b 1
fr_Walk6H:	ds.b 1
fr_Walk7H:	ds.b 1
fr_Walk8H:	ds.b 1
fr_Walk9H:	ds.b 1
fr_WalkAH:	ds.b 1
fr_Death1:	ds.b 1
fr_Death2:	ds.b 1
fr_Death3:	ds.b 1
fr_Death4:	ds.b 1
fr_Death5:	ds.b 1
fr_Death6:	ds.b 1
fr_Death7:	ds.b 1
fr_Death8:	ds.b 1
fr_Death9:	ds.b 1
fr_Victory1:	ds.b 1
fr_Victory2:	ds.b 1
fr_Victory3:	ds.b 1
fr_Victory4:	ds.b 1
fr_Victory5:	ds.b 1
fr_Tele1:	ds.b 1
fr_Tele2:	ds.b 1
fr_Tele3:	ds.b 1
fr_Tele4:	ds.b 1
fr_Tele5:	ds.b 1
fr_Intro1:	ds.b 1
fr_Intro2:	ds.b 1
fr_Intro3:	ds.b 1
fr_Intro4:	ds.b 1
fr_Intro5:	ds.b 1
fr_Intro6:	ds.b 1
fr_Intro7:	ds.b 1
; after fr_Intro7 just go to MegaAni_Wait
fr_Exit1:	ds.b 1
fr_Exit2:	ds.b 1
fr_Exit3:	ds.b 1
fr_Exit4:	ds.b 1
fr_Exit5:	ds.b 1
fr_Exit6:	ds.b 1
fr_Exit7:	ds.b 1
	even
	dephase