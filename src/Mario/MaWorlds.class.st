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
		putFloor: {0->69. 71->86. 89->153. 155->212};
		yourself
]
