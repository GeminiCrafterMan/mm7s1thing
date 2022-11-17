; ---------------------------------------------------------------------------
; Animation script - Sonic
; ---------------------------------------------------------------------------
Ani_Sonic:

ptr_Walk:	dc.w SonAni_Walk-Ani_Sonic
ptr_Run:	dc.w SonAni_Run-Ani_Sonic
ptr_Roll:	dc.w SonAni_Roll-Ani_Sonic
ptr_Roll2:	dc.w SonAni_Roll2-Ani_Sonic
ptr_Push:	dc.w SonAni_Push-Ani_Sonic
ptr_Wait:	dc.w SonAni_Wait-Ani_Sonic
ptr_Balance:	dc.w SonAni_Balance-Ani_Sonic
ptr_LookUp:	dc.w SonAni_LookUp-Ani_Sonic
ptr_Duck:	dc.w SonAni_Duck-Ani_Sonic
ptr_Warp1:	dc.w SonAni_Warp1-Ani_Sonic
ptr_Warp2:	dc.w SonAni_Warp2-Ani_Sonic
ptr_Warp3:	dc.w SonAni_Warp3-Ani_Sonic
ptr_Warp4:	dc.w SonAni_Warp4-Ani_Sonic
ptr_Stop:	dc.w SonAni_Stop-Ani_Sonic
ptr_Float1:	dc.w SonAni_Float1-Ani_Sonic
ptr_Float2:	dc.w SonAni_Float2-Ani_Sonic
ptr_Spring:	dc.w SonAni_Spring-Ani_Sonic
ptr_Hang:	dc.w SonAni_Hang-Ani_Sonic
ptr_Leap1:	dc.w SonAni_Leap1-Ani_Sonic
ptr_Leap2:	dc.w SonAni_Leap2-Ani_Sonic
ptr_Surf:	dc.w SonAni_Surf-Ani_Sonic
ptr_GetAir:	dc.w SonAni_GetAir-Ani_Sonic
ptr_Burnt:	dc.w SonAni_Burnt-Ani_Sonic
ptr_Drown:	dc.w SonAni_Drown-Ani_Sonic
ptr_Death:	dc.w SonAni_Death-Ani_Sonic
ptr_Shrink:	dc.w SonAni_Shrink-Ani_Sonic
ptr_Hurt:	dc.w SonAni_Hurt-Ani_Sonic
ptr_WaterSlide:	dc.w SonAni_WaterSlide-Ani_Sonic
ptr_Null:	dc.w SonAni_Null-Ani_Sonic
ptr_Float3:	dc.w SonAni_Float3-Ani_Sonic
ptr_Float4:	dc.w SonAni_Float4-Ani_Sonic

SonAni_Walk:	dc.b $FF, fr_Walk13, fr_Walk14,	fr_Walk15, fr_Walk16, fr_Walk11, fr_Walk12, afEnd
		even
SonAni_Run:	dc.b $FF,  fr_Run11,  fr_Run12,  fr_Run13,  fr_Run14,     afEnd,     afEnd, afEnd
		even
SonAni_Roll:	dc.b $FE,  fr_Roll1,  fr_Roll2,  fr_Roll3,  fr_Roll4,  fr_Roll5,     afEnd, afEnd
		even
SonAni_Roll2:	dc.b $FE,  fr_Roll1,  fr_Roll2,  fr_Roll5,  fr_Roll3,  fr_Roll4,  fr_Roll5, afEnd
		even
SonAni_Push:	dc.b $FD,  fr_Push1,  fr_Push2,  fr_Push3,  fr_Push4,     afEnd,     afEnd, afEnd
		even
; wow super weird hacky garbage?? lesgooo
SonAni_Wait:	dc.b 3 ; speed of 3 so i don't have to type everything out so many times (it's only ever in increments of 2 anyway)
		rept 37
			dc.b fr_Stand
		endm
		dc.b fr_Blink1, fr_Blink2, fr_Blink2, fr_Blink1, fr_Stand, fr_Stand, fr_Blink2, fr_Blink2
		rept 27
			dc.b fr_Stand
		endm
		dc.b fr_Blink1, fr_Blink2, fr_Blink2, fr_Blink1, afEnd
		even
SonAni_Balance:	dc.b $1F, fr_Balance1, fr_Balance2, afEnd
		even
SonAni_LookUp:	dc.b $3F, fr_LookUp, afEnd
		even
SonAni_Duck:	dc.b $3F, fr_Duck, afEnd
		even
SonAni_Warp1:	dc.b $3F, fr_Warp1, afEnd
		even
SonAni_Warp2:	dc.b $3F, fr_Warp2, afEnd
		even
SonAni_Warp3:	dc.b $3F, fr_Warp3, afEnd
		even
SonAni_Warp4:	dc.b $3F, fr_Warp4, afEnd
		even
SonAni_Stop:	dc.b 7,	fr_Stop1, fr_Stop2, afEnd
		even
SonAni_Float1:	dc.b 7,	fr_Float1, fr_Float4, afEnd
		even
SonAni_Float2:	dc.b 7,	fr_Float1, fr_Float2, fr_Float5, fr_Float3, fr_Float6, afEnd
		even
SonAni_Spring:	dc.b $2F, fr_Spring, afChange, id_Walk
		even
SonAni_Hang:	dc.b 4,	fr_Hang1, fr_Hang2, afEnd
		even
SonAni_Leap1:	dc.b $F, fr_Leap1, fr_Leap1, fr_Leap1,	afBack, 1
		even
SonAni_Leap2:	dc.b $F, fr_Leap1, fr_Leap2, afBack, 1
		even
SonAni_Surf:	dc.b $3F, fr_Surf, afEnd
		even
SonAni_GetAir:	dc.b $B, fr_GetAir, fr_GetAir, fr_Walk15, fr_Walk16, afChange, id_Walk
		even
SonAni_Burnt:	dc.b $20, fr_Burnt, afEnd
		even
SonAni_Drown:	dc.b $2F, fr_Drown, afEnd
		even
SonAni_Death:	dc.b 3,	fr_Death, afEnd
		even
SonAni_Shrink:	dc.b 3,	fr_Shrink1, fr_Shrink2, fr_Shrink3, fr_Shrink4, fr_Shrink5, fr_Null, afBack, 1
		even
SonAni_Hurt:	dc.b 3,	fr_Injury, afEnd
		even
SonAni_WaterSlide:
		dc.b 7, fr_Injury, fr_WaterSlide, afEnd
		even
SonAni_Null:	dc.b $77, fr_Null, afChange, id_Walk
		even
SonAni_Float3:	dc.b 3,	fr_Float1, fr_Float2, fr_Float5, fr_Float3, fr_Float6, afEnd
		even
SonAni_Float4:	dc.b 3,	fr_Float1, afChange, id_Walk
		even

id_Walk:	equ (ptr_Walk-Ani_Sonic)/2	; 0
id_Run:		equ (ptr_Run-Ani_Sonic)/2	; 1
id_Roll:	equ (ptr_Roll-Ani_Sonic)/2	; 2
id_Roll2:	equ (ptr_Roll2-Ani_Sonic)/2	; 3
id_Push:	equ (ptr_Push-Ani_Sonic)/2	; 4
id_Wait:	equ (ptr_Wait-Ani_Sonic)/2	; 5
id_Balance:	equ (ptr_Balance-Ani_Sonic)/2	; 6
id_LookUp:	equ (ptr_LookUp-Ani_Sonic)/2	; 7
id_Duck:	equ (ptr_Duck-Ani_Sonic)/2	; 8
id_Warp1:	equ (ptr_Warp1-Ani_Sonic)/2	; 9
id_Warp2:	equ (ptr_Warp2-Ani_Sonic)/2	; $A
id_Warp3:	equ (ptr_Warp3-Ani_Sonic)/2	; $B
id_Warp4:	equ (ptr_Warp4-Ani_Sonic)/2	; $C
id_Stop:	equ (ptr_Stop-Ani_Sonic)/2	; $D
id_Float1:	equ (ptr_Float1-Ani_Sonic)/2	; $E
id_Float2:	equ (ptr_Float2-Ani_Sonic)/2	; $F
id_Spring:	equ (ptr_Spring-Ani_Sonic)/2	; $10
id_Hang:	equ (ptr_Hang-Ani_Sonic)/2	; $11
id_Leap1:	equ (ptr_Leap1-Ani_Sonic)/2	; $12
id_Leap2:	equ (ptr_Leap2-Ani_Sonic)/2	; $13
id_Surf:	equ (ptr_Surf-Ani_Sonic)/2	; $14
id_GetAir:	equ (ptr_GetAir-Ani_Sonic)/2	; $15
id_Burnt:	equ (ptr_Burnt-Ani_Sonic)/2	; $16
id_Drown:	equ (ptr_Drown-Ani_Sonic)/2	; $17
id_Death:	equ (ptr_Death-Ani_Sonic)/2	; $18
id_Shrink:	equ (ptr_Shrink-Ani_Sonic)/2	; $19
id_Hurt:	equ (ptr_Hurt-Ani_Sonic)/2	; $1A
id_WaterSlide:	equ (ptr_WaterSlide-Ani_Sonic)/2 ; $1B
id_Null:	equ (ptr_Null-Ani_Sonic)/2	; $1C
id_Float3:	equ (ptr_Float3-Ani_Sonic)/2	; $1D
id_Float4:	equ (ptr_Float4-Ani_Sonic)/2	; $1E

; Sonic frame IDs
	phase 0 ; Reset ds.b value to 0

fr_Null:	ds.b 1
fr_Stand:	ds.b 1
fr_Blink1:	ds.b 1
fr_Blink2:	ds.b 1
fr_LookUp:	ds.b 1
fr_Walk11:	ds.b 1
fr_Walk12:	ds.b 1
fr_Walk13:	ds.b 1
fr_Walk14:	ds.b 1
fr_Walk15:	ds.b 1
fr_Walk16:	ds.b 1
fr_Walk2X:	ds.b 6
fr_Walk3X:	ds.b 6
fr_Walk4X:	ds.b 6
fr_Run11:	ds.b 1
fr_Run12:	ds.b 1
fr_Run13:	ds.b 1
fr_Run14:	ds.b 1
fr_Run2X:	ds.b 4
fr_Run3X:	ds.b 4
fr_Run4X:	ds.b 4
fr_Roll1:	ds.b 1
fr_Roll2:	ds.b 1
fr_Roll3:	ds.b 1
fr_Roll4:	ds.b 1
fr_Roll5:	ds.b 1
fr_Warp1:	ds.b 1
fr_Warp2:	ds.b 1
fr_Warp3:	ds.b 1
fr_Warp4:	ds.b 1
fr_Stop1:	ds.b 1
fr_Stop2:	ds.b 1
fr_Duck:	ds.b 1
fr_Balance1:ds.b 1
fr_Balance2:ds.b 1
fr_Float1:	ds.b 1
fr_Float2:	ds.b 1
fr_Float3:	ds.b 1
fr_Float4:	ds.b 1
fr_Spring:	ds.b 1
fr_Hang1:	ds.b 1
fr_Hang2:	ds.b 1
fr_Leap1:	ds.b 1
fr_Leap2:	ds.b 1
fr_Push1:	ds.b 1
fr_Push2:	ds.b 1
fr_Push3:	ds.b 1
fr_Push4:	ds.b 1
fr_Surf:	ds.b 1
fr_BubStand:ds.b 1
fr_Burnt:	ds.b 1
fr_Drown:	ds.b 1
fr_Death:	ds.b 1
fr_Shrink1:	ds.b 1
fr_Shrink2:	ds.b 1
fr_Shrink3:	ds.b 1
fr_Shrink4:	ds.b 1
fr_Shrink5:	ds.b 1
fr_Float5:	ds.b 1
fr_Float6:	ds.b 1
fr_Injury:	ds.b 1
fr_GetAir:	ds.b 1
fr_WaterSlide:	ds.b 1
	even
	dephase