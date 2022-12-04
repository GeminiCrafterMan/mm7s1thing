SndD1_Jump_Land_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     SndD1_Jump_Land_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM4, SndD1_Jump_Land_FM4,	$00, $06

; FM4 Data
SndD1_Jump_Land_FM4:
	smpsSetvoice        $00
	dc.b	nD1, $07, nRst, $02, nD1, $06, nRst, $10
	smpsClearPush
	smpsStop

SndD1_Jump_Land_Voices:
;	Voice $00
;	$1C
;	$2E, $02, $0F, $02, 	$1F, $1F, $1F, $1F, 	$18, $0F, $14, $0E
;	$00, $00, $00, $00, 	$FF, $FF, $FF, $FF, 	$20, $80, $1B, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $03
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $02
	smpsVcCoarseFreq    $02, $0F, $02, $0E
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $1F, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $0E, $14, $0F, $18
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $0F, $0F, $0F, $0F
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $1B, $00, $20