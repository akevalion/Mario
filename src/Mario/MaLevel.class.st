"
The entire level of Mario
"
Class {
	#name : #MaLevel,
	#superclass : #Object,
	#instVars : [
		'playerPosition',
		'background',
		'scrolling',
		'floorSprite',
		'statics',
		'cloudSprite',
		'scenery',
		'blocks',
		'enemies',
		'items',
		'pipes'
	],
	#category : #'Mario-Core'
}

{ #category : #accessing }
MaLevel >> background: aColor [
	background := aColor 
	
]

{ #category : #accessing }
MaLevel >> cloudSprite: aMaSprite [ 
	cloudSprite := aMaSprite
]

{ #category : #accessing }
MaLevel >> floorSprite: aMaSprite [ 
	floorSprite := aMaSprite
]

{ #category : #initialization }
MaLevel >> initialize [
	super initialize.
	statics := OrderedCollection new.
	scenery := OrderedCollection new.
	blocks := OrderedCollection new.
	enemies := OrderedCollection new.
	items := OrderedCollection new.
	pipes := OrderedCollection new.
]

{ #category : #accessing }
MaLevel >> playerPosition: aPoint [ 
	playerPosition := aPoint
]

{ #category : #scene }
MaLevel >> putClouds: aCollection [ 
	aCollection do: [ :p | 
		scenery add: (MaProp new
			sprite: cloudSprite;
			position: p * 16) ].
]

{ #category : #private }
MaLevel >> putFloor [
	| floor |
	floor := MaFloor new
		sprite: floorSprite.
	statics add: floor.
	^ floor
]

{ #category : #scene }
MaLevel >> putFloor: aCollection [ 
	aCollection do: [ :asso |
		asso key to: asso value do: [ :i |
			self putFloor position: i@13.
			self putFloor position: i@14 ] ].
]

{ #category : #rendering }
MaLevel >> renderOn: canvas [
	| player |
	canvas color: background.
	player := canvas attributeAt: #player.
	player position: playerPosition.
	"
	scenery do: [ :s | s renderOn: canvas ]."
	statics do: [ :s | s renderOn: canvas ].
]

{ #category : #accessing }
MaLevel >> scrolling: aBool [ 
	scrolling := aBool
]

{ #category : #stepping }
MaLevel >> step [
	"this is the updating process"
]
