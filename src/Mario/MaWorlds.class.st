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
		floorSprite: (MaSprite new
			src: 'tiles.png';
			position: 0@0;
			extent: 16@16);
		cloudSprite: (MaSprite new
			src: 'tiles.png';
			position: 0@320;
			extent: 48@3);
		putFloor: {0->69. 71->86. 89->153. 155->212};
		putClouds: { 7@3. 19@2. 56@3. 67@2. 87@2. 103@2. 152@3. 163@2. 200@3  };
		yourself
]
