SndA0_Jump_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     SndA0_Jump_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cPSG3, SndA0_Jump_PSG3,	$00, $00

; PSG3 Data
SndA0_Jump_PSG3:
	smpsModSet          $01, $01, $F0, $08
	smpsPSGform         $E7
	dc.b	nF6, $02
;	dc.b	smpsNoAttack, $01
	dc.b	nE6, $01
	dc.b	nEb6, $04
;
;SndA0_Jump_Loop00:
;	dc.b	nG6, $01
;	smpsPSGAlterVol     $01
;	smpsLoop            $00, $0C, SndA0_Jump_Loop00
	smpsStop

; Song seems to not use any FM voices
SndA0_Jump_Voices:
