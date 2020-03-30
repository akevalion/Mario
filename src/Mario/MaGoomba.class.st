"
I am an enemy
"
Class {
	#name : #MaGoomba,
	#superclass : #MaEnemy,
	#instVars : [
		'dying',
		'flipping'
	],
	#category : #'Mario-Core'
}

{ #category : #'update cycle' }
MaGoomba >> checkCollisions [
	| base level extent player vx |
	flipping
		ifTrue: [ ^ self ].
	player := self player.
	level := player level.
	extent := 1 @ 1.
	base := position floor.
	base y > 15
		ifTrue: [ ^ level removeEnemy: self ].
	0 to: extent y do: [ :i | 
		0 to: extent x do: [ :j | 
			| p |
			p := i @ j + base.
			level
				staticsAt: p collideWith: self;
				blocksAt: p collideWith: self ] ].
	vx := self vx.
	level enemies do: [ :e | self collideWithEnemy: e vX: vx  ].
	self collideWith: player.
]

{ #category : #'as yet unclassified' }
MaGoomba >> collideWall: wall [
	vel := vel x negated @ vel y.
]

{ #category : #public }
MaGoomba >> collideWith: ent [ 
	| com1 com2 |
	ent class == MaPlayer & (dying>0) ifTrue: [ ^ self ].
	com1 := self box encompassingRectangle.
	com2 := ent box encompassingRectangle.
	(com1 intersects: com2) ifFalse: [ ^ self ].
	ent class == MaPlayer ifFalse: [ ^ self collideWall: ent ].
	ent vel y > 0.1
		ifTrue: [ self stomp ]
		ifFalse: [ ent damage ]
]

{ #category : #'update cycle' }
MaGoomba >> collideWithEnemy: e vX: vx [
	e = self ifTrue: [ ^ self ].
	e position x - vx > 21 ifTrue: [ ^ self ].
	self collideWith: e
]

{ #category : #'update cycle' }
MaGoomba >> initialize [
	super initialize.
	dying := 0.
	flipping := false.
	vel := -0.5@0/8.
]

{ #category : #public }
MaGoomba >> stomp [
	self player bounce: true.
	sprite positionX: 32.
	sprite speed: 0.
	vel := 0@vel y.
	dying := 10.
]

{ #category : #'update cycle' }
MaGoomba >> update: dt time: gameTime vx: vx [
	| level |
	position x - vx > 21 ifTrue: [ ^ self ].
	level := self level.
	position x - vx < -5 ifTrue: [ 
		level removeEnemy: self ].
	dying > 0 ifTrue: [
		dying := dying -1.
		dying isZero ifTrue: [ level removeEnemy: self ] ].
	acc := acc x@ (0.2/ 16).
	vel := vel + acc.
	position := position + vel.
	sprite updateEntity: self dt: dt.
]
