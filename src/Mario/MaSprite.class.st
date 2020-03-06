"
I am a basic representation of one sprite
"
Class {
	#name : #MaSprite,
	#superclass : #Object,
	#instVars : [
		'source',
		'position',
		'extent',
		'paint'
	],
	#category : #'Mario-Core'
}

{ #category : #accessing }
MaSprite >> extent: aPoint [ 
	extent := aPoint
]

{ #category : #accessing }
MaSprite >> position: aPoint [ 
	position := aPoint
]

{ #category : #rendering }
MaSprite >> renderOn: canvas position: point [ 
	canvas add: (RSBox new
		paint: paint;
		position: point;
		yourself)
]

{ #category : #accessing }
MaSprite >> src: aString [ 
	source := aString.
	self halt.
	paint :=  1
]
