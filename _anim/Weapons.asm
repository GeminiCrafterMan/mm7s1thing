Ani_BusterLemon:
    	dc.w .normal-Ani_BusterLemon
    	dc.w .explode-Ani_BusterLemon

.normal:	dc.b 2, 0, afEnd
		even
.explode:	dc.b 0, 1, 2, 2, 3, 3, afRoutine
		even

Ani_BusterMid:
    	dc.w .normal-Ani_BusterMid
    	dc.w .explode-Ani_BusterMid

.normal:	dc.b 0, 1, 2, 2, 3, 3, 3, afEnd
		even
.explode:	dc.b 1, 4, 5, 6, 6, afRoutine
		even

Ani_BusterFull:
    	dc.w .normal-Ani_BusterFull
    	dc.w .explode-Ani_BusterFull

.normal:	dc.b 0, 7, 7, 8, 8, 8, 9, afEnd
		even
.explode:	dc.b 1, $A, $B, $C, $C, afRoutine
		even

Ani_SpecialWeapons:
		dc.w .gwChain-Ani_SpecialWeapons	; probably won't be using this, but who cares
		dc.w .gwBall-Ani_SpecialWeapons		; bleh
		dc.w .mbAir-Ani_SpecialWeapons	    ; marble blazer air
		dc.w .mbGround-Ani_SpecialWeapons   ; marble blazer ground
		dc.w .syzPHolder-Ani_SpecialWeapons ; spring yard weapon placeholder
		dc.w .lsSpike-Ani_SpecialWeapons	; labyrinth spear spike
		dc.w .osSpikeBall-Ani_SpecialWeapons	; orbit shield spikeball
		dc.w .sbzPHolder-Ani_SpecialWeapons	; scrap brain weapon placeholder

	.gwChain:	dc.b 0, 1, afEnd
		even
	.gwBall:	dc.b 0, 2, 3, 2, 4, 2, 5, 2, 4, afEnd
		even
	.mbAir:	dc.b 0, 6, 7, 8, afEnd
		even
	.mbGround:	dc.b 2, 9, 10, 11, 12, 13, 12, 13, 12, 11, 10, 9, 0, afRoutine
		even
	.syzPHolder:	dc.b 0, 14, afEnd
		even
	.lsSpike:	dc.b 0, 15, afEnd
		even
	.osSpikeBall:	dc.b 0, 16, afEnd
		even
	.sbzPHolder:	dc.b 0, 17, afEnd
		even