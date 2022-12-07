Snd_Slide_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     Snd_Slide_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

	smpsHeaderSFXChannel cFM4, Snd_Slide_FM4,	$00, $10

; FM4 Data
Snd_Slide_FM4:
	smpsSetvoice        $00
	dc.b	nG6, $02

Snd_Slide_Loop00:
	dc.b	smpsNoAttack, $01
	smpsAlterVol        $01
	smpsLoop            $00, $22, Snd_Slide_Loop00
	dc.b	nRst, $01
	smpsStop

Snd_Slide_Voices:
;	Voice $00
;	$38
;	$0F, $0F, $0F, $0F, 	$1F, $1F, $1F, $0E, 	$00, $00, $00, $00
;	$00, $00, $00, $00, 	$0F, $0F, $0F, $1F, 	$00, $00, $00, $80
	smpsVcAlgorithm     $00
	smpsVcFeedback      $07
	smpsVcUnusedBits    $00
	smpsVcDetune        $00, $00, $00, $00
	smpsVcCoarseFreq    $0F, $0F, $0F, $0F
	smpsVcRateScale     $00, $00, $00, $00
	smpsVcAttackRate    $0E, $1F, $1F, $1F
	smpsVcAmpMod        $00, $00, $00, $00
	smpsVcDecayRate1    $00, $00, $00, $00
	smpsVcDecayRate2    $00, $00, $00, $00
	smpsVcDecayLevel    $01, $00, $00, $00
	smpsVcReleaseRate   $0F, $0F, $0F, $0F
	smpsVcTotalLevel    $00, $00, $00, $00

