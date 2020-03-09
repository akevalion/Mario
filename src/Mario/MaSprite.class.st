"
I am a basic representation of one sprite
"
Class {
	#name : #MaSprite,
	#superclass : #Object,
	#instVars : [
		'source',
		'position',
		'extent'
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
MaSprite >> position: aPoint [ 
	position := aPoint
]

{ #category : #rendering }
MaSprite >> renderOn: canvas position: point [ 
	| paint |
	paint := self class paintFor: source position: position extent: extent.
	canvas add: (RSBox new
		paint: paint;
		size: extent;
		position: point * 16;
		yourself)
]

{ #category : #accessing }
MaSprite >> src: aString [
	source := aString
]
