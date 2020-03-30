"
a basic player, could be Mario or Luigi
"
Class {
	#name : #MaPlayer,
	#superclass : #MaUnit,
	#instVars : [
		'noInput',
		'bounce',
		'canJump',
		'crouching',
		'runHeld',
		'maxSpeed',
		'moveAcc',
		'jumping',
		'left',
		'power',
		'dying',
		'flagging',
		'targetPos',
		'level',
		'loader',
		'waiting',
		'exiting'
	],
	#category : #'Mario-Core'
}

{ #category : #update }
MaPlayer >> animationStanding [
	standing ifFalse: [ ^ self ].
	vel x abs > 0 ifTrue: [ 
		vel x * acc x >= 0 ifTrue: [ 
			sprite positionX: 96.
			sprite frames: #(0 1 2).
			sprite speed: (vel x < 0.2 
				ifTrue: [5]
				ifFalse: [ vel x abs * 8])
		] ifFalse: [ 
			((vel x > 0 and: [ left ])
			or: [ vel x < 0 and: [ left not ] ]) 
				ifTrue: [  sprite positionX: 144; speed: 0 ] ].
	] ifFalse: [
		sprite positionX: 80; speed: 0
	].
]

{ #category : #accessing }
MaPlayer >> bounce: aBool [
	bounce := aBool
]

{ #category : #'update cycle' }
MaPlayer >> checkCollisions [
	| extent base |
	self isDying ifTrue: [ ^ self ].
	extent := 1@1.
	base := position floor.
	0 to: extent y do: [ :i |
		0 to: extent x do: [:j | | p |
			p :=i@j + base.
			level
				staticsAt: p collideWith: self;
				blocksAt: p collideWith: self
			] ].

]

{ #category : #public }
MaPlayer >> crouch [
	power isZero ifTrue: [ ^ crouching := false ].
	standing ifTrue: [ crouching := true ].
]

{ #category : #public }
MaPlayer >> damage [
	self die
]

{ #category : #public }
MaPlayer >> die [
	noInput := true.
	self noWalk; noRun; noJump.
	acc := 0@ acc y.
	sprite position: 176@32.
	sprite speed: 0.
	dying := 40.
	position y < 15 ifTrue: [ 
		targetPos := position + (0@ -8).
		vel := 0@ -5/8 ]
	ifFalse: [ 
		targetPos := position + (0@ -1).
		vel := 0@0 ].
	
]

{ #category : #accessing }
MaPlayer >> dying [
	^ dying
]

{ #category : #public }
MaPlayer >> exit [
	position := position + (1@0).
	targetPos := level playerExit@position y.
	left := true.
	self setSpriteAnimation.
	waiting := 1.
	exiting := true.
]

{ #category : #public }
MaPlayer >> flag [
	noInput := true.
	flagging := true.
	vel := 0@2 /16.
	acc := 0@0.
]

{ #category : #initialization }
MaPlayer >> initialize [
	super initialize.
	jumping := 0.
	vel := acc := 0@0.
	power := 0.
	dying := 0.
	left := false.
	bounce := false.
	standing := true.
	canJump := true.
	exiting := false.
	crouching := false.
	runHeld := false.
	flagging := false.
	noInput := false.
	waiting := 0.
	self noRun.
]

{ #category : #accessing }
MaPlayer >> isDying [
	^ dying isZero not
]

{ #category : #public }
MaPlayer >> jump [
	vel y > 0 ifTrue: [ ^ self ].
	jumping isZero not
		ifTrue: [ jumping := jumping - 1 ]
		ifFalse: [ standing & canJump ifTrue: [ 
			jumping := 20.
			canJump := false.
			standing := false.
			vel := vel x@ -0.7.
			 ] ].
]

{ #category : #accessing }
MaPlayer >> jumping: anInteger [ 
	jumping := anInteger
]

{ #category : #accessing }
MaPlayer >> level [
	^ level
]

{ #category : #accessing }
MaPlayer >> level: aMaLevel [ 
	level := aMaLevel
]

{ #category : #accessing }
MaPlayer >> loader: aMaLoader [ 
	loader := aMaLoader
]

{ #category : #public }
MaPlayer >> moveLeft [
	(vel y isZero & standing) ifTrue: [ 
		crouching ifTrue: [ ^ self noWalk ].
		
		acc := moveAcc negated@acc y.
		left := true.
	] ifFalse: [ acc := moveAcc negated @ acc y ]
]

{ #category : #public }
MaPlayer >> moveRight [
	(vel y isZero & standing) ifTrue: [ 
		crouching ifTrue: [ ^ self noWalk ].
		acc := moveAcc@acc y.
		left := false.
	] ifFalse: [ acc := moveAcc @ acc y ]
]

{ #category : #public }
MaPlayer >> noCrouch [
	crouching := false
]

{ #category : #accessing }
MaPlayer >> noInput [
	^ noInput
]

{ #category : #public }
MaPlayer >> noJump [
	canJump := true.
	jumping isZero ifFalse: [ 
		jumping <= 16 ifTrue: [ 
			vel := vel x @ 0.
			jumping := 0 ]
		ifFalse: [ jumping := jumping - 1 ] 
	]
]

{ #category : #public }
MaPlayer >> noRun [
	maxSpeed := 1.5/8.
	moveAcc := 0.07/2.
	runHeld := false.
]

{ #category : #public }
MaPlayer >> noWalk [
	maxSpeed := 0.
	vel x isZero ifTrue: [ ^ self ].
	vel x abs <= 0.1 ifFalse: [ ^ self ].
	vel := 0 @ vel y.
	acc := 0 @ acc y
]

{ #category : #accessing }
MaPlayer >> power [
	^ power
]

{ #category : #public }
MaPlayer >> run [
	maxSpeed := 2.5/8
]

{ #category : #update }
MaPlayer >> setSpriteAnimation [
	self isDying ifTrue: [ ^ self ].
	crouching ifTrue: [ 
		sprite positionX: 176.
		^ sprite speed: 0 ].
	jumping isZero not ifTrue: [
		sprite positionX: 160.
		sprite speed: 0
	] ifFalse: [
		self animationStanding ].
	flagging ifTrue: [ 
		sprite 
			positionX: 192;
			frames: #(0 1);
			speed: 10.
			vel y isZero 
				ifTrue: [ sprite frames: #(0) ].
		 ].
	sprite src: (left 
		ifTrue: ['playerl.png'] 
		ifFalse: ['player.png']).
]

{ #category : #update }
MaPlayer >> update: dt vx: vX [
	self updatePosition: vX dt: dt.
	self setSpriteAnimation.
	sprite updateEntity: self dt: dt.
]

{ #category : #update }
MaPlayer >> updatePosition: vX dt: dt [
	position x <= vX ifTrue: [ 
		position := vX @ position y.
		vel := (vel x max: 0) @ vel y ].
	waiting > 0 ifTrue: [ 
		waiting := waiting - 1.
		waiting <= 0 
			ifTrue: [ waiting := 0 ]
			ifFalse: [ ^ self ]  ].
	bounce ifTrue: [ 
		bounce := false.
		standing := false.
		vel := vel x @ (-3 / 8) ].
	vel x abs > maxSpeed ifTrue: [ 
		vel := (vel x - (0.05 * vel x / vel x abs)) @ vel y.
		acc := 0 @ acc y ].
	
	self isDying ifTrue: [ 
		position y < targetPos y 
			ifTrue: [ vel := vel x @ 1 ].
		dying := dying -1.
		dying <= 0 
			ifTrue: [ loader reload ].
		
	] ifFalse: [ 
		acc := acc x @ 0.05.
		position y > 15 ifTrue: [ self die ].
	].
	flagging ifTrue: [ acc := 0@0 ].
	
	exiting ifTrue: [ 
		left := false.
		flagging := false.
		vel := 1.5/ 8 @ vel y.
		position x >= targetPos x
			ifTrue: [ loader reload ] ].
	vel := vel + acc.
	position := position + vel.
]
