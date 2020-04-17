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
		at: aPoint
		ifPresent: [ :ent | ent collideWith: aMaPlayer ]
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
		rows: extent y + 2
		columns: extent x.
	enemies, blocks, statics, { canvas propertyAt: #player } do: [ :ent | 
		| pos |
		pos := ent position + 1.
		matrix 
			at: pos x asInteger
			at: pos y asInteger
			put: ent
		 ].
	^ matrix
]

{ #category : #'accessing matrices' }
MaLevel >> getVisibleEntities: canvas [
	| canvasRect |
	canvasRect := Rectangle 
		floatCenter: canvas camera position 
		extent: canvas extent / canvas camera scale.
	^ enemies, blocks, statics, { canvas propertyAt: #player } select: [ :ent |
		ent box encompassingRectangle intersects: canvasRect.
		 ] thenCollect: [ :ent | ent positionInMatrix: ent position - (ent vx @ 0)].
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
	scenery := OrderedCollection new.
	items := OrderedCollection new.
	enemies := OrderedCollection new.
	
	statics := Dictionary new.
	blocks := Dictionary new.
	pipes := Dictionary new.
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
		self sceneryAdd:  (MaProp new sprite: hillSprites first; position: p).
		self sceneryAdd:  (MaProp new sprite: hillSprites fourth; position: 1@0+p).	
		self sceneryAdd:  (MaProp new sprite: hillSprites first; position: 1@ -1 +p).	
		self sceneryAdd:  (MaProp new sprite: hillSprites fifth; position: 2@0 +p).
		self sceneryAdd:  (MaProp new sprite: hillSprites fourth; position: 2@ -1+p).
		self sceneryAdd:  (MaProp new sprite: hillSprites second; position: 2@ -2+p).
		self sceneryAdd:  (MaProp new sprite: hillSprites sixth; position: 3@0+p).
		self sceneryAdd:  (MaProp new sprite: hillSprites third; position: 3@ -1+p).
		self sceneryAdd:  (MaProp new sprite: hillSprites third; position: 4@ 0+p).
		 ].
]

{ #category : #'scene - interactive' }
MaLevel >> putBricks: aCollection [
	aCollection do: [ :p |
		| pos item |
		p isPoint
			ifTrue: [ pos := p. item := nil ]
			ifFalse: [ pos := p key. item := p value ].
		blocks at: pos put: (MaBlock new
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
	statics at: x@12 put: (MaFloor new position: x@12; sprite: wallSprite).
	3 to: 11 do: [ :i|
		scenery add: (MaProp new position: x@i; sprite: flagPoleSprites second) ].
	scenery add: (MaProp new position: x@2; sprite: flagPoleSprites first).
	items add: (MaFlag new position: (x-0.5)@3; sprite:flagPoleSprites third ).
]

{ #category : #scene }
MaLevel >> putFloor: aCollection [ 
	aCollection do: [ :asso |
		asso key to: asso value -1 do: [ :i |
			self putFloorIn: i@13.
			self putFloorIn: i@14 ] ].
]

{ #category : #private }
MaLevel >> putFloorIn: position [
	| floor |
	floor := MaFloor new
		sprite: floorSprite;
		position: position;
		yourself.
	statics at: position put: floor.
	^ floor
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
						at: x@i put:(MaFloor new position:x@i; sprite: pipeLEndSprite);
						at: (x+1)@i put: (MaFloor new position: (x+1)@i; sprite: pipeREndSprite) ]
				ifFalse: [ 
					statics 
						at: x@i put: (MaFloor new position:x@i; sprite: pipeLMidSprite);
						at: (x+1)@i put: (MaFloor new position: (x+1)@i; sprite: pipeRMidSprite).
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
		blocks at: pos put: (MaBlock new
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
		self sceneryAdd: (MaProp new sprite: hillSprites first; position: p).
		self sceneryAdd: (MaProp new sprite: hillSprites fourth; position: 1@0+p).	
		self sceneryAdd: (MaProp new sprite: hillSprites second; position: 1@ -1 +p).	
		self sceneryAdd: (MaProp new sprite: hillSprites third; position: 2@0 +p).
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
		self sceneryAdd: (MaProp new
			sprite: cloudSprites first;
			position: p;
			yourself).
		self sceneryAdd: (MaProp new
			sprite: cloudSprites second;
			position: 1@0 + p;
			yourself).
		self sceneryAdd: (MaProp new
			sprite: cloudSprites second;
			position: 2@0 + p;
			yourself).
		self sceneryAdd: (MaProp new
			sprite: cloudSprites second;
			position: 3@0 + p;
			yourself).
		self sceneryAdd: (MaProp new
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
		self sceneryAdd: (MaProp new
			sprite: cloudSprites first;
			position: p;
			yourself).
		self sceneryAdd: (MaProp new
			sprite: cloudSprites second;
			position: 1@0 + p;
			yourself).
		self sceneryAdd: (MaProp new
			sprite: cloudSprites second;
			position: 2@0 + p;
			yourself).
		self sceneryAdd: (MaProp new
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
			statics at: x@i put: (MaFloor new position: x@i; sprite: wallSprite) ].
		 ]
]

{ #category : #accessing }
MaLevel >> qblockSprite: aMaSprite [ 
	qblockSprite := aMaSprite
]

{ #category : #removing }
MaLevel >> removeBlock: aMaBlock [ 
	blocks removeKey: aMaBlock position.
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
	player := canvas propertyAt: #player.
	player position: playerPosition.
	scenery, blocks values, statics values, items, enemies,{player}
		do: [ :s | s renderOn: canvas ].
]

{ #category : #private }
MaLevel >> sceneryAdd: entity [ 
	scenery add: entity
]

{ #category : #accessing }
MaLevel >> scrolling: aBool [ 
	scrolling := aBool
]

{ #category : #'public - collide' }
MaLevel >> staticsAt: aPoint collideWith: aMaPlayer [ 
	statics
		at: aPoint
		ifPresent: [ :ent | ent collideWith: aMaPlayer ].

]

{ #category : #accessing }
MaLevel >> ublockSprite: aMaSprite [ 
	ublockSprite := aMaSprite
]

{ #category : #accessing }
MaLevel >> updatables [
	^ blocks values, items, enemies
]

{ #category : #accessing }
MaLevel >> wallSprite: aMaSprite [ 
	wallSprite := aMaSprite
]
