"
I describes a mobile unit
"
Class {
	#name : #MaUnit,
	#superclass : #MaEntity,
	#category : #'Mario-Core'
}

{ #category : #'as yet unclassified' }
MaUnit >> collideWall: wall [
	| wx |
	wx := wall position x.
	position x >  wx ifTrue: [ 
		position := (wx + 1) @ position y.
		vel := (0 max: vel x) @ vel y.
		acc := (0 max: acc x) @ acc y.
	] ifFalse: [ 
		position := (wx - 1) @ position y.
		vel := (0 min: vel x) @ vel y.
		acc := (0 min: acc x) @ acc y.
	]
]
