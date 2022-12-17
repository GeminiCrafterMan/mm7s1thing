Map_c186:
Map_c186_0: 	dc.w Map_c186_8-Map_c186
Map_c186_2: 	dc.w Map_c186_E-Map_c186
Map_c186_4: 	dc.w Map_c186_19-Map_c186
Map_c186_6: 	dc.w Map_c186_24-Map_c186
Map_c186_8: 	dc.b $1
	dc.b $FC, $0, $20, $0, $FC
Map_c186_E: 	dc.b $2
	dc.b $F8, $0, $20, $1, $FC
	dc.b $FF, $0, $38, $1, $FD
Map_c186_19: 	dc.b $2
	dc.b $F8, $1, $20, $2, $F8
	dc.b $F8, $1, $38, $2, $0
Map_c186_24: 	dc.b $2
	dc.b $F8, $1, $20, $4, $F8
	dc.b $F8, $1, $38, $4, $0
	even