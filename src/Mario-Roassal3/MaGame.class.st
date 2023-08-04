"
The main class to run this example
"
Class {
	#name : #MaGame,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'level',
		'player',
		'pressedKeys',
		'dt',
		'gameTime',
		'lastTime',
		'vX',
		'AiIndividual',
		'flatPosScalingFactor',
		'gameIter',
		'gameIterLabel',
		'hasIter'
	],
	#category : #'Mario-Roassal3'
}

{ #category : #'as yet unclassified' }
MaGame >> activateIter [
	hasIter := true.
	gameIter := 0.
	gameIterLabel := RSLabel new.
	canvas addFixedShape: gameIterLabel.
	
]

{ #category : #accessing }
MaGame >> canvas [
	^ canvas
]

{ #category : #'update cycle' }
MaGame >> checkCollisions [
	player isDying ifTrue: [ ^ self ].
	
	level items, level enemies, level pipes, { player } do: [ :ent | ent checkCollisions ].
]

{ #category : #'accessing matrices' }
MaGame >> getEntitiesMatrix [
	<script: 'self new getEntitiesMatrix inspect'>
	^ level get2DMatrix: canvas
]

{ #category : #'as yet unclassified' }
MaGame >> getEntityFlatPos: aMaEntity [
	| windowSize pos|
	windowSize := 16.
	pos := aMaEntity positionInMatrix.
	
	"saturation effect"
	pos y > (windowSize - 1) ifTrue: [ pos setX: pos x setY: 15].
	pos x > (windowSize - 1) ifTrue: [ pos setX: 15 setY: pos y ].
	^ ((pos y*windowSize*flatPosScalingFactor) + (pos x*flatPosScalingFactor) + 1) rounded.
]

{ #category : #'as yet unclassified' }
MaGame >> getRandomBinaryAction [
	| r p|
	r := Random new.
	p := OrderedCollection new.
	5 timesRepeat: [ p add: 0 ].
	(r nextInt: 5) timesRepeat: [ p at: (r nextInt: 5) put: 1 ].
	^ p
]

{ #category : #'transformation matrices' }
MaGame >> getSimpleEntitiesMatrix [
	| entitiesMatrix shallowMatrix c |
	entitiesMatrix := self getEntitiesMatrix.
	shallowMatrix := entitiesMatrix asArray.
	c := OrderedCollection new.
	shallowMatrix do: [ :ent | ent ifNil: [ c add: 0 ] ifNotNil: [c add: ent code] ].
	^ c.
]

{ #category : #'accessing matrices' }
MaGame >> getVisibleEntities [
	 ^ level getVisibleEntities: canvas
]

{ #category : #'as yet unclassified' }
MaGame >> getVisibleEntitiesAsFixedArray [
	| result |
	result := OrderedCollection new.
	256 timesRepeat: [ result add: 0 ].
	self getVisibleEntities do: [ :ent |
		result at: (self getEntityFlatPos: ent) put: (ent code / 7.0)
		 ].
	^ result
]

{ #category : #'update cycle' }
MaGame >> handleInput [
	player noInput ifTrue: [ ^ self ].
	(self isDown: #run) 
		ifTrue: [ player run ]
		ifFalse: [ player noRun ].
	(self isDown: #jump)
		ifTrue: [ player jump ]
		ifFalse: [ player noJump ].
	(self isDown: #down)
		ifTrue: [ player crouch ]
		ifFalse: [ player noCrouch ].
	(self isDown: #left)
		ifTrue: [ player moveLeft ]
		ifFalse: [(self isDown: #right) 
			ifTrue: [ player moveRight ]
			ifFalse: [ player noWalk ] ] 
]

{ #category : #initialization }
MaGame >> initialize [
	| loader |
	super initialize.
	canvas := RSCanvas new.
	loader := MaLoader new game: self.
	loader load: #level11.
	self registerEvents.
	canvas propertyAt: #vx put: vX.
	hasIter := false.
	flatPosScalingFactor := 1.
]

{ #category : #events }
MaGame >> isDown: key [ 
	^ self pressedKeys at: key ifAbsent: [ ^ false ]
]

{ #category : #accessing }
MaGame >> level: aMaLevel [ 
	level := aMaLevel
]

{ #category : #'as yet unclassified' }
MaGame >> playBinaryInput: aCollection [ 
	"Reads a binary input and saves the input in the pressedKeys variable."
    self setBinaryInput: aCollection.
    10 timesRepeat: [ self update ].
    self setBinaryInput: #(0 0 0 0 0).

]

{ #category : #accessing }
MaGame >> player [
	^ player
]

{ #category : #accessing }
MaGame >> player: aMaPlayer [ 
	player := aMaPlayer
]

{ #category : #events }
MaGame >> pressedKeys [
	^ pressedKeys ifNil: [ pressedKeys := Dictionary new ]
]

{ #category : #events }
MaGame >> registerEvents [

	canvas newAnimation
		repeat;
		onStepDo: [ :t | self update ].
	canvas
		when: RSKeyDown
		do: [ :evt | self setInput: evt with: true ]
		for: self;
		when: RSKeyUp
		do: [ :evt | self setInput: evt with: false ]
		for: self;
		when: RSExtentChangedEvent do: [ :evt |
			canvas camera
				zoomToFit: canvas extent
				rectangle: (-8 asPoint corner: 16 @ 14 * 16).
			canvas signalUpdate ]
		for: self
]

{ #category : #public }
MaGame >> reset [
	gameTime := 0.
	vX := 0.
	gameIter := 0.
	lastTime := Time microsecondClockValue.
]

{ #category : #running }
MaGame >> run [

	<script: 'self new run'>
	| w |
	canvas @ RSSimpleCanvasMonitorInteraction.
	w := canvas open setLabel: 'Mario'.
	w announcer
		when: WindowClosed
		do: [ :evt | MaSprite reset ]
		for: self
]

{ #category : #initialization }
MaGame >> setBinaryInput: aCollection [
	"Reads a binary input and saves the input in the pressedKeys variable."
	
	"first position: left button"
	(aCollection at: 1) = 1 
		ifTrue: [ 
			self pressedKeys at: #left put: true ]
		ifFalse: [ 
			self pressedKeys at: #left put: false ].
	"second position: right button"
	(aCollection at: 2) = 1 
		ifTrue: [ 
			self pressedKeys at: #right put: true ]
		ifFalse: [
			self pressedKeys at: #right put: false ].
		"first position: left button"
	(aCollection at: 3) = 1 
		ifTrue: [ 
			self pressedKeys at: #down put: true ]
		ifFalse: [ 
			self pressedKeys at: #down put: false ].
	"third position: down button"
	(aCollection at: 4) = 1 
		ifTrue: [ 
			self pressedKeys at: #jump put: true ]
		ifFalse: [ 
			self pressedKeys at: #jump put: false ].
	"first position: left button"
	(aCollection at: 5) = 1 
		ifTrue: [ 
			self pressedKeys at: #run put: true ]
		ifFalse: [ 
			self pressedKeys at: #run put: false ].
]

{ #category : #events }
MaGame >> setInput: evt with: status [
	| name key |
	name := evt keyName.
	name traceCr.
	key := nil.
	name = #LEFT ifTrue: [ key := #left ].
	name = #RIGHT ifTrue: [ key := #right ].
	name = #DOWN ifTrue: [ key := #down ].
	name = #Z ifTrue: [ key := #run ]. "z"
	name = #X ifTrue: [ key := #jump ]."x"
	key ifNil: [ ^ self "evt keyValue traceCr" ].
	self pressedKeys at: key put: status.
	"self pressedKeys traceCr."
]

{ #category : #'update cycle' }
MaGame >> update [
	| now |
	now := Time microsecondClockValue.
	dt := (now - lastTime) / 1000.
	self handleInput.
	self updateEntities.
	self checkCollisions.
	canvas signalUpdate.
	lastTime := now.
]

{ #category : #'update cycle' }
MaGame >> updateEntities [
	player update: dt vx: vX.
	player isDying ifTrue: [ ^ self ].
	
	canvas propertyAt: #vx put: vX.
	
	"updates the iteration number"
	hasIter ifTrue: [ 
		gameIterLabel text: gameIter ; position: (32 @ 16).
		gameIter := gameIter + 1. 
	].
	
	level updatables do: [ :ent | ent update: dt time: gameTime vx: vX ].
	player position x > (vX + 5 )
		ifTrue: [ vX := player position x - 5 ].
	canvas camera 
		zoomToFit: canvas extent 
		rectangle: (Rectangle origin: -9 + (vX * 16@ 0) extent: 16@14 *16)
]
