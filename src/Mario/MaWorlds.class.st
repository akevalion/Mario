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
		flagPoleSprites: { 
			(MaSprite new src: 'tiles.png'; position: 256@128; extent: 16@16).
			(MaSprite new src: 'tiles.png'; position: 256@144; extent: 16@16).
			(MaSprite new src: 'items.png'; position: 128@32; extent: 16@16). 
			 };
		pipeLEndSprite: (MaSprite new src: 'tiles.png'; position: 0@128; extent: 16@16);
		pipeREndSprite: (MaSprite new src: 'tiles.png'; position: 16@128; extent: 16@16);
		pipeLMidSprite: (MaSprite new src: 'tiles.png'; position: 0@144; extent: 16@16);
		pipeRMidSprite: (MaSprite new src: 'tiles.png'; position: 16@144; extent: 16@16);
		wallSprite: (MaSprite new src: 'tiles.png'; position: 0@16; extent: 16@16);
		goombaSprite: (MaSprite new src: 'enemy.png'; position: 0@16; extent: 16@16);
		koopaSprite: (MaSprite new src: 'enemy.png'; position: 96@0; extent: 16@32);
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
		putBricks: { 100@9" -> MaStar new position: " };
		putQCoinBlocks: { 16@9. 21@9. 22@5. 23@9. 78@9. 94@5. 105@9. 108@9. 108@5. 111@9. 129@5. 
			130@5. 170@9 };
		putPipes: { 28@13->2. 38@13 -> 3. 57@13->4. 46@13 ->4. 163@13->2. 179@13->2 };
		putWalls: { 134@13->1. 135@13->2. 136@13->3. 137@13->4. 
			140@13->4. 141@13->3. 142@13->2. 143@13->1.
			148@13->1. 149@13->2. 150@13->3. 151@13->4. 152@13->4.
			155@13->4. 156@13->3. 157@13->2. 158@13->1.
			181@13->1. 182@13->2. 183@13->3. 184@13->4. 185@13->5. 186@13->6. 187@13->7. 
			188@13->8. 189@13->8.
			 };
		putFlagpole: 198;
		"enemies"
		putGoombas: { 22@12. 40@12. 50@12. 51@12. 82@4. 84@4. 100@12. 102@12. 114@12. 115@12.
			122@12. 123@12. 125@12. 126@12. 170@12. };
		putKoopas: { 35@11.5 };
		yourself
]
