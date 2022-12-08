; ---------------------------------------------------------------------------
; Animation script - Mega Man
; ---------------------------------------------------------------------------
Ani_MegaMan:

ptr_Tiptoe:			dc.w MegaAni_Tiptoe-Ani_MegaMan
ptr_TiptoeShoot:	dc.w MegaAni_TiptoeShoot-Ani_MegaMan
ptr_Walking:		dc.w MegaAni_Walking-Ani_MegaMan
ptr_WalkingShoot:	dc.w MegaAni_WalkingShoot-Ani_MegaMan
ptr_Roll:			dc.w MegaAni_Roll-Ani_MegaMan
ptr_Roll2:			dc.w MegaAni_Roll2-Ani_MegaMan
ptr_Wait:			dc.w MegaAni_Wait-Ani_MegaMan
ptr_Shoot:			dc.w MegaAni_Shoot-Ani_MegaMan
ptr_Float1:			dc.w MegaAni_Float1-Ani_MegaMan
ptr_Float2:			dc.w MegaAni_Float2-Ani_MegaMan
ptr_Hang:			dc.w MegaAni_Hang-Ani_MegaMan
ptr_Death:			dc.w MegaAni_Death-Ani_MegaMan
ptr_Hurt:			dc.w MegaAni_Hurt-Ani_MegaMan
ptr_WaterSlide:		dc.w MegaAni_WaterSlide-Ani_MegaMan
ptr_Null:			dc.w MegaAni_Null-Ani_MegaMan
ptr_Float3:			dc.w MegaAni_Float3-Ani_MegaMan
ptr_Float4:			dc.w MegaAni_Float4-Ani_MegaMan
ptr_Jump:			dc.w MegaAni_Jump-Ani_MegaMan
ptr_JumpShoot:		dc.w MegaAni_JumpShoot-Ani_MegaMan
ptr_Fall:			dc.w MegaAni_Fall-Ani_MegaMan
ptr_FallShoot:		dc.w MegaAni_FallShoot-Ani_MegaMan
ptr_Land:			dc.w MegaAni_Land-Ani_MegaMan
ptr_LandShoot:		dc.w MegaAni_LandShoot-Ani_MegaMan
ptr_SlideStart:		dc.w MegaAni_SlideStart-Ani_MegaMan
ptr_Slide:			dc.w MegaAni_Slide-Ani_MegaMan
ptr_SlideStop:		dc.w MegaAni_SlideStop-Ani_MegaMan

MegaAni_Tiptoe:	dc.b $FF, fr_Step1, fr_Step2, afChange, id_Walking
		even
MegaAni_TiptoeShoot:	dc.b $FF, fr_Step1S, fr_Step2S, afChange, id_WalkingShoot
		even
MegaAni_Walking:	dc.b $FF,	fr_Walk1,	fr_Walk2,	fr_Walk3,	fr_Walk4,	fr_Walk5,	fr_Walk6,	fr_Walk7,	fr_Walk8,	fr_Walk9,	fr_WalkA, afEnd
		even
MegaAni_WalkingShoot:	dc.b $FF,	fr_Walk1S,	fr_Walk2S,	fr_Walk3S,	fr_Walk4S,	fr_Walk5S,	fr_Walk6S,	fr_Walk7S,	fr_Walk8S,	fr_Walk9S,	fr_WalkAS, afEnd
		even
MegaAni_Roll:	dc.b $FE,  fr_Roll1,  fr_Roll2,  fr_Roll3,  fr_Roll4,  fr_Roll5,     afEnd, afEnd
		even
MegaAni_Roll2:	dc.b $FE,  fr_Roll1,  fr_Roll2,  fr_Roll5,  fr_Roll3,  fr_Roll4,  fr_Roll5, afEnd
		even
; wow super weird hacky garbage?? lesgooo
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
MegaAni_Float1:	dc.b 7,	fr_Float1, fr_Float4, afEnd
		even
MegaAni_Float2:	dc.b 7,	fr_Float1, fr_Float2, fr_Float5, fr_Float3, fr_Float6, afEnd
		even
MegaAni_Hang:	dc.b 4,	fr_Hang1, fr_Hang2, afEnd
		even
MegaAni_Death:	dc.b 3,	fr_Death, afEnd
		even
MegaAni_Hurt:	dc.b 3,	fr_Injury, afEnd
		even
MegaAni_WaterSlide:	dc.b 7, fr_Injury, fr_WaterSlide, afEnd
		even
MegaAni_Null:	dc.b $77, fr_Null, afChange, id_Tiptoe
		even
MegaAni_Float3:	dc.b 3,	fr_Float1, fr_Float2, fr_Float5, fr_Float3, fr_Float6, afEnd
		even
MegaAni_Float4:	dc.b 3,	fr_Float1, afChange, id_Walking
		even
MegaAni_Jump:	dc.b 1, fr_Jump1, fr_Jump2, fr_Jump2, fr_Jump3, fr_Jump3, fr_Jump4, afBack, 1
		even
MegaAni_JumpShoot:	dc.b 1, fr_Jump1S, fr_Jump2S, fr_Jump2S, fr_Jump3S, fr_Jump3S, fr_Jump4S, afBack, 1
		even
MegaAni_Fall:	dc.b 9, fr_Jump3, afEnd, afEnd, afEnd, afEnd, afEnd, afEnd
		even
MegaAni_FallShoot:	dc.b 9, fr_Jump3S, afEnd, afEnd, afEnd, afEnd, afEnd, afEnd
		even
MegaAni_Land:	dc.b 1, fr_Jump2, fr_Jump1, afChange, id_Wait
		even
MegaAni_LandShoot:	dc.b 1, fr_Jump2S, fr_Jump1S, afChange, id_Shoot
		even
MegaAni_SlideStart:	dc.b 1, fr_SlideT, afChange, id_Slide
		even
MegaAni_Slide:	dc.b 1, fr_Slide1, fr_Slide2, afEnd
		even
MegaAni_SlideStop:	dc.b 1, fr_SlideT, fr_SlideT, fr_SlideT, fr_SlideT, afChange, id_Wait
		even

id_Tiptoe:		equ (ptr_Tiptoe-Ani_MegaMan)/2	; 0
id_TiptoeShoot:	equ (ptr_TiptoeShoot-Ani_MegaMan)/2	; 0
id_Walking:		equ (ptr_Walking-Ani_MegaMan)/2	; 1
id_WalkingShoot:equ (ptr_WalkingShoot-Ani_MegaMan)/2	; 1
id_Roll:		equ (ptr_Roll-Ani_MegaMan)/2	; 2
id_Roll2:		equ (ptr_Roll2-Ani_MegaMan)/2	; 3
id_Wait:		equ (ptr_Wait-Ani_MegaMan)/2	; 5
id_Shoot:		equ (ptr_Shoot-Ani_MegaMan)/2	; 5
id_Float1:		equ (ptr_Float1-Ani_MegaMan)/2	; $E
id_Float2:		equ (ptr_Float2-Ani_MegaMan)/2	; $F
id_Hang:		equ (ptr_Hang-Ani_MegaMan)/2	; $11
id_Death:		equ (ptr_Death-Ani_MegaMan)/2	; $18
id_Hurt:		equ (ptr_Hurt-Ani_MegaMan)/2	; $1A
id_WaterSlide:	equ (ptr_WaterSlide-Ani_MegaMan)/2 ; $1B
id_Null:		equ (ptr_Null-Ani_MegaMan)/2	; $1C
id_Float3:		equ (ptr_Float3-Ani_MegaMan)/2	; $1D
id_Float4:		equ (ptr_Float4-Ani_MegaMan)/2	; $1E
id_Jump:		equ (ptr_Jump-Ani_MegaMan)/2	; $1D
id_JumpShoot:	equ (ptr_JumpShoot-Ani_MegaMan)/2	; $1D
id_Fall:		equ (ptr_Fall-Ani_MegaMan)/2	; $1E
id_FallShoot:	equ (ptr_FallShoot-Ani_MegaMan)/2	; $1E
id_Land:		equ (ptr_Land-Ani_MegaMan)/2
id_LandShoot:	equ (ptr_LandShoot-Ani_MegaMan)/2
id_SlideStart:	equ (ptr_SlideStart-Ani_MegaMan)/2
id_Slide:		equ (ptr_Slide-Ani_MegaMan)/2
id_SlideStop:	equ (ptr_SlideStop-Ani_MegaMan)/2

; Sonic frame IDs
	phase 0 ; Reset ds.b value to 0

fr_Null:	ds.b 1
fr_Stand:	ds.b 1
fr_Blink1:	ds.b 1
fr_Blink2:	ds.b 1
fr_Shoot1:	ds.b 1
fr_Shoot2:	ds.b 1
fr_Shoot3:	ds.b 1
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
fr_Death:	ds.b 1
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
	even
	dephase