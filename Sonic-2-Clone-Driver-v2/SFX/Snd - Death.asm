Snd_Death_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     Snd_Death_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cPSG1, Snd_Death_PSG1,	$00-$0C, $00
	smpsHeaderSFXChannel cPSG2, Snd_Death_PSG2,	$00-$0C, $02

; PSG1 Data
Snd_Death_PSG1:
	dc.b	nCs4, $01, nB3, $01, nG3, $01, nE3, $01, nD3, $01, nC3, $01, nA2, $01, nFs2, $01, nEb2, $01, nCs2, $01, nB1, $01, nG1, $01, nF1, $01, nD1, $01
	smpsPSGAlterVol     $02
	smpsLoop            $00, $06, Snd_Death_PSG1
	smpsStop

; PSG2 Data
Snd_Death_PSG2:
	dc.b	nCs5, $01, nB4, $01, nG4, $01, nE4, $01, nD4, $01, nC4, $01, nA3, $01, nFs3, $01, nEb3, $01, nCs3, $01, nB2, $01, nG2, $01, nF2, $01, nD2, $01
	smpsPSGAlterVol     $02
	smpsLoop            $00, $06, Snd_Death_PSG2
	smpsStop

; sorry nothing
Snd_Death_Voices: