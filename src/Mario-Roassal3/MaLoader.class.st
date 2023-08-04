"
A loader records game events between worlds
"
Class {
	#name : #MaLoader,
	#superclass : #Object,
	#instVars : [
		'game',
		'currentLevel'
	],
	#category : #'Mario-Roassal3'
}

{ #category : #public }
MaLoader >> createMario [
	^ MaPlayer new
		loader: self;
		sprite: (MaSprite new
			src: 'player.png';
			position: 80@32;
			extent: 16@16;
			speed: 0 ).
]

{ #category : #public }
MaLoader >> createWorld [
	| level |
	level := MaWorlds perform: currentLevel.
	level renderOn: game canvas.
	game reset.
	^ level
]

{ #category : #accessing }
MaLoader >> game: aMaGame [ 
	game := aMaGame
]

{ #category : #public }
MaLoader >> load: aString [
	currentLevel := aString.
	self reload.
]

{ #category : #public }
MaLoader >> reload [
	| player level |
	game canvas shapes copy do: #remove.
	player := self createMario.
	game canvas propertyAt: #player put: player.
	level := self createWorld.
	player level: level.
	game 
		player: player;
		level: level.
]
