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
		'speed',
		'index',
		'frames'
	],
	#classVars : [
		'images',
		'paints'
	],
	#category : #'Mario-Core'
}

{ #category : #'as yet unclassified' }
MaSprite class >> imgFor: aString [
	images ifNil: [ images := Dictionary new ].
	^ images 
		at: aString
		ifAbsentPut: [ | img |
			img := ImageReadWriter 
				formFromFileNamed: 'pharo-local/iceberg/akevalion/Mario/sprites/', aString.
			img := AthensCairoSurface fromForm: img. ]
	
]

{ #category : #'as yet unclassified' }
MaSprite class >> paintFor: source position: position extent: extent [.
	paints ifNil: [ paints := Dictionary new ].
	^ paints 
		at: (source -> position)
		ifAbsentPut: [
			| img paint |
			img := self imgFor: source. 
			paint := AthensCairoPatternSurfacePaint createForSurface: img.
			paint origin: (extent / -2) - position" -(0.5) ".
			paint ].
	
]

{ #category : #'as yet unclassified' }
MaSprite class >> reset [
	images := nil.
	paints := nil.
]

{ #category : #accessing }
MaSprite >> extent: aPoint [ 
	extent := aPoint
]

{ #category : #accessing }
MaSprite >> frames: anArray [
	frames := anArray
]

{ #category : #initialization }
MaSprite >> initialize [
	super initialize.
	speed := 0.
]

{ #category : #accessing }
MaSprite >> position: aPoint [ 
	position := aPoint
]

{ #category : #accessing }
MaSprite >> positionX: int [
	position := int @ position y
]

{ #category : #rendering }
MaSprite >> renderOn: canvas position: point [ 
	| paint box |
	paint := self class paintFor: source position: position extent: extent.
	canvas add: (box := RSBox new
		paint: paint;
		size: extent;
		position: point * 16;
		yourself).
	^ box
]

{ #category : #accessing }
MaSprite >> speed: anInteger [ 
	speed := anInteger
]

{ #category : #accessing }
MaSprite >> src: aString [
	source := aString
]

{ #category : #rendering }
MaSprite >> updateEntity: ent dt: dt [
	| paint frame |
	index := speed * dt.
	speed > 0 ifTrue: [ | max idx |
		max := frames size.
		idx := index floor.
		frame := frames at: (idx % max) + 1.
	] ifFalse: [ frame := 0 ].
	paint := self class paintFor: source position: position+(frame*extent x@0) extent: extent.
	
	ent box
		paint: paint;
		size: extent;
		position: ent position * 16.
]
