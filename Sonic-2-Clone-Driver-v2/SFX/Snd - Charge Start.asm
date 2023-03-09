Snd_Charge_Start_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     Snd_Charge_Start_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

	smpsHeaderSFXChannel cPSG1, Snd_Charge_Start_PSG1,	$00-$0C, $00
	smpsHeaderSFXChannel cPSG2, Snd_Charge_Start_PSG2,	$00-$0C, $02

; PSG1 Data
Snd_Charge_Start_PSG1:
	dc.b	nB1, $01, nBb1, $02, nC2, $01, nD2, $01, nE2, $01, smpsNoAttack, nFs2, $03
	dc.b	nC2, $02, nB1, $01, nCs2, $01, nEb2, $01, nF2, $01, smpsNoAttack, nAb2, $02
	dc.b	nCs2, $02, nC2, $01, nD2, $01, nE2, $01, nG2, $01, smpsNoAttack, nA2, $02
	dc.b	nD2, $02, nCs2, $01, nEb2, $01, nFs2, $01, nAb2, $01, smpsNoAttack, nB2, $02
	dc.b	nEb2, $02, nD2, $01, nE2, $01, nG2, $01, nBb2, $01, smpsNoAttack, nC3, $02
	dc.b	nE2, $02, nEb2, $01, nF2, $01, nAb2, $01, nB2, $01, smpsNoAttack, nCs3, $02
	dc.b	nF2, $02, nE2, $01, nG2, $01, nA2, $01, nC3, $01, smpsNoAttack, nD3, $02
	dc.b	nFs2, $02, nF2, $01, nAb2, $01, nB2, $01, nCs3, $01, smpsNoAttack, nD3, $02
	smpsAlterVol        $02
	dc.b	nG2, $02, nFs2, $01, nA2, $01, nC3, $01, nCs3, $01, smpsNoAttack, nEb3, $02
	smpsStop

; PSG2 Data
Snd_Charge_Start_PSG2:
	dc.b	nB2, $01, nBb2, $02, nC3, $01, nD3, $01, nE3, $01, smpsNoAttack, nFs3, $03
	dc.b	nC3, $02, nB2, $01, nCs3, $01, nEb3, $01, nF3, $01, smpsNoAttack, nAb3, $02
	dc.b	nCs3, $02, nC3, $01, nD3, $01, nE3, $01, nG3, $01, smpsNoAttack, nA3, $02
	dc.b	nD3, $02, nCs3, $01, nEb3, $01, nFs3, $01, nAb3, $01, smpsNoAttack, nB3, $02
	dc.b	nEb3, $02, nD3, $01, nE3, $01, nG3, $01, nBb3, $01, smpsNoAttack, nC4, $02
	dc.b	nE3, $02, nEb3, $01, nF3, $01, nAb3, $01, nB3, $01, smpsNoAttack, nCs4, $02
	dc.b	nF3, $02, nE3, $01, nG3, $01, nA3, $01, nC4, $01, smpsNoAttack, nD4, $02
	dc.b	nFs3, $02, nF3, $01, nAb3, $01, nB3, $01, nCs4, $01, smpsNoAttack, nD4, $02
	smpsAlterVol        $02
	dc.b	nG3, $02, nFs3, $01, nA3, $01, nC4, $01, nCs4, $01, smpsNoAttack, nEb4, $02
	smpsStop

Snd_Charge_Start_Voices: