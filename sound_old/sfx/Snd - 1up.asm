Snd_1up_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     Snd_1up_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cPSG1, Snd_1up_PSG1,	$00-$0C, $00
	smpsHeaderSFXChannel cPSG2, Snd_1up_PSG2,	$00-$0C, $02

; PSG1 Data
Snd_1up_PSG1:
	dc.b	nCs4, $04, nEb4, $04, nF4, $04, nFs4, $04, nAb4, $04, nBb4, $04, nC5, $04, nCs5, $04
	smpsPSGAlterVol     $06
	smpsLoop            $00, $02, Snd_1up_PSG1
	smpsStop

; PSG2 Data
Snd_1up_PSG2:
	dc.b	nCs5, $04, nEb5, $04, nF5, $04, nFs5, $04, nAb5, $04, nBb5, $04, nC6, $04, nCs6, $04
	smpsPSGAlterVol     $06
	smpsLoop            $00, $02, Snd_1up_PSG2
	smpsStop

; sorry nothing
Snd_1up_Voices: