"
I am a flag item
"
Class {
	#name : #MaFlag,
	#superclass : #MaEntity,
	#instVars : [
		'hit',
		'done'
	],
	#category : #'Mario-Core'
}

{ #category : #'update cycle' }
MaFlag >> checkCollisions [
	| player |
	hit ifTrue: [ ^ self ].
	player := self player.
	player position x < position x ifTrue: [ ^ self ].
	hit := true.
	player flag.
	vel := 0@2/16.
]

{ #category : #initialization }
MaFlag >> initialize [
	super initialize.
	hit := false.
	done := false.
	vel := 0@0.
	code := 0.
]

{ #category : #'update cycle' }
MaFlag >> update: dt time: gameTime vx: vx [
	( done not and: [ position y >= (170/16)] ) ifTrue: [ 
		vel := 0@0. 
		position := position x@ (170/16).
		self player exit.
		done := true.
		].
	position := position + vel.
	sprite updateEntity: self dt: dt.
]
