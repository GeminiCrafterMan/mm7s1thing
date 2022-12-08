Snd_Buster_Shot_Header:
	smpsHeaderStartSong 1
	smpsHeaderVoice     Snd_Buster_Shot_Voices
	smpsHeaderTempoSFX  $01
	smpsHeaderChanSFX   $01

;	smpsHeaderSFXChannel cFM4, Snd_Buster_Shot_FM4,	$00+$0C+$0C+$0C, $03
	smpsHeaderSFXChannel cPSG2, Snd_Buster_Shot_PSG2,	$00-$0C-$0B, $00

; PSG2 Data
Snd_Buster_Shot_PSG2:
	smpsPSGvoice        $00
	dc.b	nD4, $01, nB3, $01, nG3, $01, nAb3, $01
	dc.b	nEb4, $01, nBb4, $01, nE5, $01, nC6, $01
	dc.b	nEb6, $01, nC6, $01, nRst, $01
	smpsStop

; sorry nothing
Snd_Buster_Shot_Voices: