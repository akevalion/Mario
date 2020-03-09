"
I have the information about all the levels
"
Class {
	#name : #MaWorlds,
	#superclass : #Object,
	#category : #'Mario-Core'
}

{ #category : #levels }
MaWorlds class >> level11 [
	^ MaLevel new
		playerPosition: 56@192;
		background: '#7974FF';
		scrolling: true;
		floorSprite: (MaSprite new src: 'tiles.png'; position: 0@0; extent: 16@16);
		cloudSprite: (MaSprite new src: 'tiles.png'; position: 0@320; extent: 48@32);
		bushSprite: (MaSprite new src: 'tiles.png'; position: 176@144; extent: 48@16);
		brickSprite: (MaSprite new src: 'tiles.png'; position: 16@0; extent: 16@16);
		qblockSprite: (MaSprite new src: 'tiles.png'; position: 384@0; extent: 16@16);
		
		cloudSprites: { 
			(MaSprite new src: 'tiles.png'; position: 0@322; extent: 16@28).
			(MaSprite new src: 'tiles.png'; position: 16@322; extent: 16@28).
			(MaSprite new src: 'tiles.png'; position: 32@322; extent: 16@28). };
		hillSprites: { 
			(MaSprite new src: 'tiles.png'; position: 128@128; extent: 16@16).
			(MaSprite new src: 'tiles.png'; position: 144@128; extent: 16@16).
			(MaSprite new src: 'tiles.png'; position: 160@128; extent: 16@16).
			(MaSprite new src: 'tiles.png'; position: 128@144; extent: 16@16).
			(MaSprite new src: 'tiles.png'; position: 144@144; extent: 16@16).
			(MaSprite new src: 'tiles.png'; position: 160@144; extent: 16@16). };
		bushSprites: { 
			(MaSprite new src: 'tiles.png'; position: 176@143.5; extent: 16@16).
			(MaSprite new src: 'tiles.png'; position: 192@144; extent: 16@16).
			(MaSprite new src: 'tiles.png'; position: 208@144; extent: 16@16). };
		"scene"
		putFloor: {0->69. 71->86. 89->153. 155->212};
		putClouds: { 7@3. 19@2. 56@3. 67@2. 87@2. 103@2. 152@3. 163@2. 200@3 };
		putTwoClouds: { 36@2. 132@2. 180@2 };
		putThreeClouds: { 27@3. 75@3. 123@3. 171@3 };
		putBigHills: { 0@12. 48@12. 96@12. 144@12. 192@12 };
		putSmallHills: { 16@12. 64@12. 111@12. 160@12 };
		putBushes: { 23@12. 72@12. 118@12. 167@12 };
		putTwoBushes: { 11@12. 59@12. 106@12 };
		putThreeBushes: { 11@12. 59@12. 106@12 };
		"interactive terrain"
		putBricks: { 20@9. 22@9. 24@9. 77@9. 79@9. 80@5. 81@5. 82@5. 83@5. 84@5. 85@5. 86@5. 87@5.
			91@5. 92@5. 93@5. 94@9. 101@9. 117@9. 120@5. 121@5. 122@5. 123@5. 128@5. 129@9.
			130@9. 131@5. 168@9. 169@9. 171@9 };
		yourself
]
