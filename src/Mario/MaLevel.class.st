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
		'pipes',
		'cloudSprites',
		'hillSprites',
		'bushSprite',
		'bushSprites',
		'qblockSprite',
		'ublockSprite',
		'brickSprite',
		'brickBounceSprite'
	],
	#category : #'Mario-Core'
}

{ #category : #accessing }
MaLevel >> background: aColor [
	background := aColor 
	
]

{ #category : #accessing }
MaLevel >> brickBounceSprite: aMaSprite [ 
	brickBounceSprite := aMaSprite
]

{ #category : #accessing }
MaLevel >> brickSprite: aMaSprite [ 
	brickSprite := aMaSprite
]

{ #category : #accessing }
MaLevel >> bushSprite: aMaSprite [ 
	bushSprite := aMaSprite
]

{ #category : #accessing }
MaLevel >> bushSprites: aCollection [ 
	bushSprites := aCollection
]

{ #category : #accessing }
MaLevel >> cloudSprite: aMaSprite [ 
	cloudSprite := aMaSprite
]

{ #category : #accessing }
MaLevel >> cloudSprites: aCollection [ 
	cloudSprites := aCollection
]

{ #category : #accessing }
MaLevel >> floorSprite: aMaSprite [ 
	floorSprite := aMaSprite
]

{ #category : #accessing }
MaLevel >> hillSprites: aCollection [ 
	hillSprites := aCollection
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
MaLevel >> putBigHills: aCollection [
	aCollection do: [ :p |
		scenery add: (MaProp new sprite: hillSprites first; position: p).
		scenery add: (MaProp new sprite: hillSprites fourth; position: 1@0+p).	
		scenery add: (MaProp new sprite: hillSprites first; position: 1@ -1 +p).	
		scenery add: (MaProp new sprite: hillSprites fifth; position: 2@0 +p).
		scenery add: (MaProp new sprite: hillSprites fourth; position: 2@ -1+p).
		scenery add: (MaProp new sprite: hillSprites second; position: 2@ -2+p).
		scenery add: (MaProp new sprite: hillSprites sixth; position: 3@0+p).
		scenery add: (MaProp new sprite: hillSprites third; position: 3@ -1+p).
		scenery add: (MaProp new sprite: hillSprites third; position: 4@ 0+p).
		 ].
]

{ #category : #'scene - interactive' }
MaLevel >> putBricks: aCollection [
	aCollection do: [ :p |
		| pos item |
		p isPoint
			ifTrue: [ pos := p. item := nil ]
			ifFalse: [ pos := p key. item := p value ].
		blocks add: (MaBlock new
			position: pos;
			item: item;
			sprite: brickSprite;
			bounceSprite: brickBounceSprite;
			usedSprite: ublockSprite;
			breakable: item notNil)
		 ]
]

{ #category : #scene }
MaLevel >> putBushes: aCollection [
	scenery addAll: (aCollection collect: [ :p| 
		MaProp new sprite: bushSprite; position: p ] )
]

{ #category : #scene }
MaLevel >> putClouds: aCollection [ 
	scenery addAll: (aCollection collect: [ :p |
		MaProp new
			sprite: cloudSprite;
			position: p
		 ]  )
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

{ #category : #'scene - interactive' }
MaLevel >> putQBlocks: aCollection [
	aCollection do: [ :p |
		| pos item |
		p isPoint
			ifTrue: [ pos := p. item := nil ]
			ifFalse: [ pos := p key. item := p value ].
		blocks add: (MaBlock new
			position: pos;
			item: item;
			sprite: qblockSprite;
			usedSprite: ublockSprite)
		 ]
]

{ #category : #scene }
MaLevel >> putSmallHills: aCollection [
	aCollection do: [ :p |
		scenery add: (MaProp new sprite: hillSprites first; position: p).
		scenery add: (MaProp new sprite: hillSprites fourth; position: 1@0+p).	
		scenery add: (MaProp new sprite: hillSprites second; position: 1@ -1 +p).	
		scenery add: (MaProp new sprite: hillSprites third; position: 2@0 +p).
		 ].
]

{ #category : #scene }
MaLevel >> putThreeBushes: aCollection [
	aCollection do: [ :p |
		scenery add: (MaProp new sprite: bushSprites first; position: p).
		scenery add: (MaProp new sprite: bushSprites second; position: 1@0 + p).	
		scenery add: (MaProp new sprite: bushSprites second; position: 2@0 + p).	
		scenery add: (MaProp new sprite: bushSprites second; position: 3@0 + p).
		scenery add: (MaProp new sprite: bushSprites third; position: 4@0 + p).
		 ].
]

{ #category : #scene }
MaLevel >> putThreeClouds: aCollection [ 
	aCollection do: [ :p | 
		scenery add: (MaProp new
			sprite: cloudSprites first;
			position: p;
			yourself).
		scenery add: (MaProp new
			sprite: cloudSprites second;
			position: 1@0 + p;
			yourself).
		scenery add: (MaProp new
			sprite: cloudSprites second;
			position: 2@0 + p;
			yourself).
		scenery add: (MaProp new
			sprite: cloudSprites second;
			position: 3@0 + p;
			yourself).
		scenery add: (MaProp new
			sprite: cloudSprites third;
			position: 4@0 + p;
			yourself). ].
]

{ #category : #scene }
MaLevel >> putTwoBushes: aCollection [
	aCollection do: [ :p |
		scenery add: (MaProp new sprite: bushSprites first; position: p).
		scenery add: (MaProp new sprite: bushSprites second; position: 1@0+p).	
		scenery add: (MaProp new sprite: bushSprites second; position: 2@0 +p).	
		scenery add: (MaProp new sprite: bushSprites third; position: 3@0 +p).
		 ].
]

{ #category : #scene }
MaLevel >> putTwoClouds: aCollection [ 
	aCollection do: [ :p | 
		scenery add: (MaProp new
			sprite: cloudSprites first;
			position: p;
			yourself).
		scenery add: (MaProp new
			sprite: cloudSprites second;
			position: 1@0 + p;
			yourself).
		scenery add: (MaProp new
			sprite: cloudSprites second;
			position: 2@0 + p;
			yourself).
		scenery add: (MaProp new
			sprite: cloudSprites third;
			position: 3@0 + p;
			yourself). ].
]

{ #category : #accessing }
MaLevel >> qblockSprite: aMaSprite [ 
	qblockSprite := aMaSprite
]

{ #category : #rendering }
MaLevel >> renderOn: canvas [
	| player |
	canvas color: background.
	player := canvas attributeAt: #player.
	player position: playerPosition.
	scenery,statics, blocks do: [ :s | s renderOn: canvas ].
]

{ #category : #accessing }
MaLevel >> scrolling: aBool [ 
	scrolling := aBool
]

{ #category : #stepping }
MaLevel >> step [
	"this is the updating process"
]
