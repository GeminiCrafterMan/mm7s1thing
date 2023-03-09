Snd_Jump_Land_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     Snd_Jump_Land_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM4, Snd_Jump_Land_FM4,	$00+$0C+$0C+$0C, $03
;	smpsHeaderSFXChannel cPSG2, Snd_Jump_Land_PSG2,	$00-$0C, $00

; PSG2 Data
;Snd_Jump_Land_PSG2:
; FM4 Data
Snd_Jump_Land_FM4:
	smpsSetvoice        $00
;	smpsPSGvoice        $00
	dc.b	nD4, $01, nA3, $03
	dc.b	nD4, $01, nA3, $03, nRst, $01
	smpsStop

Snd_Jump_Land_Voices:
; Shield sound one - add $0C to the pitch up there to make it not sound like Big Eye
;	$30
;	$30, $30, $30, $30, 	$9E, $A8, $AC, $DC, 	$0E, $0A, $04, $05
;	$08, $08, $08, $08, 	$BF, $BF, $BF, $BF, 	$04, $2C, $14, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $06
	smpsVcUnusedBits    $00
	smpsVcDetune        $03, $03, $03, $03
	smpsVcCoarseFreq    $00, $00, $00, $00
	smpsVcRateScale     $03, $02, $02, $02
	smpsVcAttackRate    $1C, $2C, $28, $1E
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $05, $04, $0A, $0E
	smpsVcDecayRate2    $08, $08, $08, $08
	smpsVcDecayLevel    $0B, $0B, $0B, $0B
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $14, $2C, $04

; another kinda okay one
;	$3C
;	$05, $01, $0A, $01, 	$56, $5C, $5C, $5C, 	$0E, $11, $11, $11
;	$09, $0A, $06, $0A, 	$4F, $3F, $3F, $3F, 	$1F, $80, $2B, $80
	smpsVcAlgorithm     $04
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $01, $0A, $01, $05
	smpsVcRateScale     $01, $01, $01, $01
	smpsVcAttackRate    $1C, $1C, $1C, $16
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $11, $11, $11, $0E
	smpsVcDecayRate2    $0A, $06, $0A, $09
	smpsVcDecayLevel    $03, $03, $03, $04
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $2B, $00, $1F