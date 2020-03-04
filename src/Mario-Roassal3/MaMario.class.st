"
The main class to run this example
"
Class {
	#name : #MaMario,
	#superclass : #Object,
	#instVars : [
		'canvas',
		'level'
	],
	#category : #'Mario-Roassal3'
}

{ #category : #running }
MaMario >> createWorld [
	level := MaWorlds level11.
	
]

{ #category : #running }
MaMario >> run [
	<script: 'self new run'>
	canvas := RSCanvas new.
	self createWorld.
	canvas newAnimation repeat; onStepDo: [ :t | self update ].
	canvas when: RSExtentChangedEvent do: [ :evt | 
		canvas camera 
			zoomToFit: canvas extent
			rectangle: (Rectangle 
				center: canvas camera position 
				extent: 500@500).
		canvas signalUpdate  ].
	canvas open setLabel: 'Mario'.
	
]

{ #category : #running }
MaMario >> update [
]
