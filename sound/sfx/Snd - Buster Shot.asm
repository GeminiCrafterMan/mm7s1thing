Snd_Buster_Shot_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     Snd_Buster_Shot_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $02

;	smpsHeaderSFXChannel cFM4, Snd_Buster_Shot_FM4,	$00+$0C+$0C+$0C, $03
	smpsHeaderSFXChannel cPSG1, Snd_Buster_Shot_PSG1,	$00-$0C-$0B, $00
	smpsHeaderSFXChannel cPSG2, Snd_Buster_Shot_PSG2,	$00-$0C-$0B, $00

; PSG1 Data
Snd_Buster_Shot_PSG1:
	smpsPSGvoice        $00
	dc.b	nCs4, $01, nBb3, $01, nFs3, $01, nG2, $01
	dc.b	nD4, $01, nA4, $01, nEb5, $01, nB5, $01
	dc.b	nD6, $01, nB5, $01, nRst, $01
	smpsStop

; PSG2 Data
Snd_Buster_Shot_PSG2:
	smpsPSGvoice        $00
	smpsPSGAlterVol     $02
	dc.b	nCs5, $01, nBb4, $01, nFs4, $01, nG3, $01
	dc.b	nD5, $01, nA5, $01, nEb6, $01, nB6, $01
	dc.b	nD7, $01, nB6, $01, nRst, $01
	smpsStop

; original:
;	smpsPSGvoice        $00
;	dc.b	nD4, $01, nB3, $01, nG3, $01, nAb3, $01
;	dc.b	nEb4, $01, nBb4, $01, nE5, $01, nC6, $01
;	dc.b	nEb6, $01, nC6, $01, nRst, $01
;	smpsStop

; sorry nothing
Snd_Buster_Shot_Voices: