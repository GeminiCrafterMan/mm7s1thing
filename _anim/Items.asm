Ani_Items:
		dc.w	.extraLife-Ani_Items
		dc.w	.energyTank-Ani_Items
		dc.w	.weaponTank-Ani_Items
		dc.w	.mysteryTank-Ani_Items
		dc.w	.largeHealth-Ani_Items
		dc.w	.smallHealth-Ani_Items
		dc.w	.largeEnergy-Ani_Items
		dc.w	.smallEnergy-Ani_Items
		dc.w	.scoreBall-Ani_Items
	
	.extraLife:	dc.b 0, 1, afEnd
		even
	.energyTank:	dc.b 8, 3, 2, afEnd
		even
	.weaponTank:	dc.b 8, 4, 2, afEnd
		even
	.mysteryTank:	dc.b 8, 5, 2, afEnd
		even
	.largeHealth:	dc.b 6, 6, 7, afEnd
		even
	.smallHealth:	dc.b 6, 8, 9, afEnd
		even
	.largeEnergy:	dc.b 6, 10, 11, afEnd
		even
	.smallEnergy:	dc.b 6, 12, 13, afEnd
		even
	.scoreBall:		dc.b 0, 14, afEnd
		even