Snd_Charge_Loop_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     Snd_Charge_Loop_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cPSG1, Snd_Charge_Loop_PSG1,	$00-$0C, $02
	smpsHeaderSFXChannel cPSG2, Snd_Charge_Loop_PSG2,	$00-$0C, $04

; PSG1 Data
Snd_Charge_Loop_PSG1:
	dc.b	nD3, $01, nC3, $01, nBb2, $01, nC3, $01, nCs3, $01, nD3, $01, nEb3, $01, nD3, $01, nCs3, $01, smpsNoAttack, nB2, $01
	smpsStop

; PSG2 Data
Snd_Charge_Loop_PSG2:
	dc.b	nD4, $01, nC4, $01, nBb3, $01, nC4, $01, nCs4, $01, nD4, $01, nEb4, $01, nD4, $01, nCs4, $01, smpsNoAttack, nB3, $01
	smpsStop

Snd_Charge_Loop_Voices: