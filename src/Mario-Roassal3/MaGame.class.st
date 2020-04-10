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
		'AiIndividual'
	],
	#category : #'Mario-Roassal3'
}

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

{ #category : #'transformation matrices' }
MaGame >> getSimpleEntitiesMatrix [
	| entitiesMatrix shallowMatrix c |
	entitiesMatrix := self getEntitiesMatrix.
	shallowMatrix := entitiesMatrix asArray.
	c := OrderedCollection new.
	shallowMatrix do: [ :ent | ent ifNil: [ c add: 0 ] ifNotNil: [c add: ent code] ].
	^ c.
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
]

{ #category : #events }
MaGame >> isDown: key [ 
	^ self pressedKeys at: key ifAbsent: [ ^ false ]
]

{ #category : #accessing }
MaGame >> level: aMaLevel [ 
	level := aMaLevel
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
	canvas newAnimation repeat; onStepDo: [ :t | self update ].
	canvas 
		when: RSKeyDown do: [ :evt | self setInput: evt with: true ];
		when: RSKeyUp do: [ :evt | self setInput: evt  with: false ];
		when: RSExtentChangedEvent do: [ :evt | 
			canvas camera 
				zoomToFit: canvas extent 
				rectangle: (-8 asPoint corner: 16@14 *16).
			canvas signalUpdate  ].
]

{ #category : #public }
MaGame >> reset [
	gameTime := 0.
	vX := 0.
	lastTime := Time microsecondClockValue.
	
]

{ #category : #running }
MaGame >> run [
	<script: 'self new run'>
	| w |
	w := canvas open setLabel: 'Mario'.
	w announcer when: WindowClosed do: [:evt | MaSprite reset ].
]

{ #category : #initialization }
MaGame >> setBinaryInput: aCollection [
	"Reads a binary input and saves the input in the pressedKeys variable."
	self assert: (aCollection size) equals: 5.
	
	"first position: left button"
	(aCollection at: 1) = 1 
		ifTrue: [ 
			self pressedKeys at: #left put: true ]
		ifFalse: [ 
			self pressedKeys at: #left put: false ].
		"first position: left button"
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
		"first position: left button"
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
	| value key |
	value := evt keyValue.
	key := nil.
	(value = 28 or: [value = 123]) ifTrue: [ key := #left ].
	(value = 29 or: [ value = 124 ]) ifTrue: [ key := #right ].
	(value = 31 or: [ value = 125 ]) ifTrue: [ key := #down ].
	(value = 122 or: [ value = 6 ]) ifTrue: [ key := #run ]. "z"
	(value = 120 or: [ value = 7 ])  ifTrue: [ key := #jump ]."x"
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
	player position x traceCr.
]

{ #category : #'update cycle' }
MaGame >> updateEntities [
	player update: dt vx: vX.
	player isDying ifTrue: [ ^ self ].
	
	canvas attributeAt: #vx put: vX.
	
	level updatables do: [ :ent | ent update: dt time: gameTime vx: vX ].
	player position x > (vX + 5 )
		ifTrue: [ vX := player position x - 5 ].
	canvas camera 
		zoomToFit: canvas extent 
		rectangle: (Rectangle origin: -9 + (vX * 16@ 0) extent: 16@14 *16)
]
