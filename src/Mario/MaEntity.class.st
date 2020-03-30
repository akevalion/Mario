"
I describe an entity
"
Class {
	#name : #MaEntity,
	#superclass : #Object,
	#instVars : [
		'position',
		'sprite',
		'box',
		'standing',
		'vel',
		'acc'
	],
	#category : #'Mario-Core'
}

{ #category : #accessing }
MaEntity >> box [
	^ box
]

{ #category : #'as yet unclassified' }
MaEntity >> bump [
]

{ #category : #initialization }
MaEntity >> initialize [
	super initialize.
	standing := true.
	vel := acc := 0@0.
]

{ #category : #accessing }
MaEntity >> level [
	^ self player level
]

{ #category : #accessing }
MaEntity >> player [
	^ box canvas attributeAt: #player
]

{ #category : #accessing }
MaEntity >> position [
	^ position
]

{ #category : #accessing }
MaEntity >> position: aPoint [
	position := aPoint
]

{ #category : #accessing }
MaEntity >> positionY: anInteger [ 
	position := position x @ anInteger
]

{ #category : #rendering }
MaEntity >> renderOn: canvas [
	box := sprite renderOn: canvas position: position
]

{ #category : #accessing }
MaEntity >> sprite [
	^ sprite
]

{ #category : #accessing }
MaEntity >> sprite: aMaSprite [
	aMaSprite ifNil: [ self halt. ].
	sprite := aMaSprite
]

{ #category : #accessing }
MaEntity >> standing: aBool [ 
	standing := aBool
]

{ #category : #accessing }
MaEntity >> vel [
	^ vel
]

{ #category : #accessing }
MaEntity >> velY: anInteger [ 
	vel := vel x @ anInteger
]

{ #category : #accessing }
MaEntity >> vx [
	^ box canvas attributeAt: #vx
]
