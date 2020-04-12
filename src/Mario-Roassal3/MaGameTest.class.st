Class {
	#name : #MaGameTest,
	#superclass : #TestCase,
	#instVars : [
		'game',
		'entity'
	],
	#category : #'Mario-Roassal3-Test'
}

{ #category : #running }
MaGameTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	super setUp.
	game := MaGame new.
	entity := MaEntity new.
	

]

{ #category : #'as yet unclassified' }
MaGameTest >> testgetEntityFlatPos [
	
	entity positionInMatrix: (16@16).
	self assert: (game getEntityFlatPos: entity) equals: 256.
	
	entity positionInMatrix: (0@0).
	self assert: (game getEntityFlatPos: entity) equals: 1.
	
	entity positionInMatrix: (3@12).
	self assert: (game getEntityFlatPos: entity) equals: 196.
	
	entity positionInMatrix: (3.5@12.05).
	self assert: (game getEntityFlatPos: entity) equals: 197.
	
]
