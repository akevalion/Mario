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
		'brickBounceSprite',
		'pipeLEndSprite',
		'pipeREndSprite',
		'pipeLMidSprite',
		'pipeRMidSprite',
		'wallSprite',
		'flagPoleSprites',
		'goombaSprite',
		'koopaSprite',
		'playerExit',
		'loader'
	],
	#category : #'Mario-Core'
}

{ #category : #accessing }
MaLevel >> background: aColor [
	background := aColor 
	
]

{ #category : #'public - collide' }
MaLevel >> blocksAt: aPoint collideWith: aMaPlayer [ 
	blocks
		detect: [ :ent | ent position = aPoint ]
		ifFound: [ :ent | ent collideWith: aMaPlayer ].
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
MaLevel >> enemies [
	^ enemies
]

{ #category : #accessing }
MaLevel >> flagPoleSprites: aCollection [ 
	flagPoleSprites := aCollection
]

{ #category : #accessing }
MaLevel >> floorSprite: aMaSprite [ 
	floorSprite := aMaSprite
]

{ #category : #'accessing matrices' }
MaLevel >> get2DMatrix: canvas [
	| matrix extent |
	extent := (canvas encompassingRectangle extent / 16) asIntegerPoint.
	matrix := Array2D 
		rows: extent x
		columns: extent y + 2.
	enemies, blocks, statics, { canvas attributeAt: #player } do: [ :ent | 
		| pos |
		pos := ent position + 1.
		matrix 
			at: pos x asInteger
			at: pos y asInteger
			put: ent
		 ].
	^ matrix
]

{ #category : #enemies }
MaLevel >> goombaSprite: aMaSprite [ 
	goombaSprite := aMaSprite
]

{ #category : #testing }
MaLevel >> hasStaticAt: aPoint [ 
	^ statics 
		detect: [ :ent| ent position = aPoint ]
		ifFound: [ true ]
		ifNone: [ false ].
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
MaLevel >> items [
	^ items
]

{ #category : #enemies }
MaLevel >> koopaSprite: aMaSprite [ 
	koopaSprite := aMaSprite
]

{ #category : #accessing }
MaLevel >> pipeLEndSprite: aMaSprite [ 
	pipeLEndSprite := aMaSprite
]

{ #category : #accessing }
MaLevel >> pipeLMidSprite: aMaSprite [ 
	pipeLMidSprite := aMaSprite
]

{ #category : #accessing }
MaLevel >> pipeREndSprite: aMaSprite [ 
	pipeREndSprite := aMaSprite
]

{ #category : #accessing }
MaLevel >> pipeRMidSprite: aMaSprite [ 
	pipeRMidSprite := aMaSprite
]

{ #category : #accessing }
MaLevel >> pipes [
	^ pipes
]

{ #category : #accessing }
MaLevel >> playerExit [
	^ playerExit
]

{ #category : #accessing }
MaLevel >> playerExit: anInteger [ 
	playerExit := anInteger
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
			level: self;
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

{ #category : #'scene - interactive' }
MaLevel >> putFlagpole: x [ 
	statics add: (MaFloor new position: x@12; sprite: wallSprite).
	3 to: 11 do: [ :i|
		scenery add: (MaProp new position: x@i; sprite: flagPoleSprites second) ].
	scenery add: (MaProp new position: x@2; sprite: flagPoleSprites first).
	items add: (MaFlag new position: (x-0.5)@3; sprite:flagPoleSprites third ).
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
		asso key to: asso value -1 do: [ :i |
			self putFloor position: i@13.
			self putFloor position: i@14 ] ].
]

{ #category : #enemies }
MaLevel >> putGoombas: aCollection [ 
	aCollection do: [ :pos | 
		enemies add: (MaGoomba new 
			position: pos; 
			sprite: goombaSprite copy)  ]
]

{ #category : #enemies }
MaLevel >> putKoopas: aCollection [ 
	aCollection do: [ :p | enemies add: (MaKoopa new position: p; sprite: koopaSprite) ]
]

{ #category : #scene }
MaLevel >> putPipes: aCollection [ 
	aCollection do: [ :asso| | x y height |
		x := asso key x.
		y := asso key y.
		height := asso value.
		(y - height) to: y-1 do: [ :i | 
			i = (y - height)
				ifTrue: [
					statics 
						add: (MaFloor new position:x@i; sprite: pipeLEndSprite);
						add: (MaFloor new position: (x+1)@i; sprite: pipeREndSprite). ]
				ifFalse: [ 
					statics 
						add: (MaFloor new position:x@i; sprite: pipeLMidSprite);
						add: (MaFloor new position: (x+1)@i; sprite: pipeRMidSprite).
					 ]
			].
		 ].
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
			level: self;
			item: item;
			sprite: qblockSprite;
			usedSprite: ublockSprite)
		 ]
]

{ #category : #'scene - interactive' }
MaLevel >> putQCoinBlocks: aCollection [ 
	self putQBlocks: (aCollection collect: [ :p | p -> MaCoin new ]).
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

{ #category : #scene }
MaLevel >> putWalls: aCollection [ 
	aCollection do: [ :asso | | x y height |
		x := asso key x.
		y := asso key y.
		height := asso value.
		y - height to: y -1 do: [ :i | 
			statics add: (MaFloor new position: x@i; sprite: wallSprite) ].
		 ]
]

{ #category : #accessing }
MaLevel >> qblockSprite: aMaSprite [ 
	qblockSprite := aMaSprite
]

{ #category : #removing }
MaLevel >> removeBlock: aMaBlock [ 
	blocks remove: aMaBlock.
	aMaBlock box remove.
]

{ #category : #'add/remove' }
MaLevel >> removeEnemy: enemy [
	enemies remove: enemy.
	enemy box remove. 
	
]

{ #category : #rendering }
MaLevel >> renderOn: canvas [
	| player |
	canvas color: background.
	player := canvas attributeAt: #player.
	player position: playerPosition.
	scenery, blocks, items, enemies,{player}, statics do: [ :s | s renderOn: canvas ].
]

{ #category : #accessing }
MaLevel >> scrolling: aBool [ 
	scrolling := aBool
]

{ #category : #'public - collide' }
MaLevel >> staticsAt: aPoint collideWith: aMaPlayer [ 
	statics
		detect: [ :ent | ent position = aPoint ]
		ifFound: [ :ent | ent collideWith: aMaPlayer ].
]

{ #category : #accessing }
MaLevel >> ublockSprite: aMaSprite [ 
	ublockSprite := aMaSprite
]

{ #category : #accessing }
MaLevel >> updatables [
	^ blocks, items, enemies
]

{ #category : #accessing }
MaLevel >> wallSprite: aMaSprite [ 
	wallSprite := aMaSprite
]
