"
I describe an entity
"
Class {
	#name : #MaEntity,
	#superclass : #Object,
	#instVars : [
		'position',
		'sprite'
	],
	#category : #'Mario-Core'
}

{ #category : #accessing }
MaEntity >> position [
	^ position
]

{ #category : #accessing }
MaEntity >> position: aPoint [
	position := aPoint
]

{ #category : #rendering }
MaEntity >> renderOn: canvas [
	sprite renderOn: canvas position: position
]

{ #category : #accessing }
MaEntity >> sprite [
	^ sprite
]

{ #category : #accessing }
MaEntity >> sprite: aMaSprite [
	sprite := aMaSprite
]
