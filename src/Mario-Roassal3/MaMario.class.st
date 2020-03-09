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
MaMario >> createMario [
	^ MaPlayer new
		sprite: (MaSprite new
			src: 'player.png';
			position: 80@32;
			extent: 16@16 ).
]

{ #category : #running }
MaMario >> createWorld [
	level := MaWorlds level11.
	level renderOn: canvas.
	
]

{ #category : #running }
MaMario >> run [
	<script: 'self new run'>
	| w |
	canvas := RSCanvas new.
	canvas @ RSCanvasController.
	canvas attributeAt: #player put: self createMario.
	self createWorld.
	canvas newAnimation repeat; onStepDo: [ :t | self update ].
	canvas when: RSExtentChangedEvent do: [ :evt | 
		canvas camera 
			zoomToFit: canvas extent
			rectangle: (Rectangle 
				center: canvas camera position 
				extent: 500@500).
		canvas signalUpdate  ].
	w := canvas open setLabel: 'Mario'.
	w announcer when: WindowClosed do: [:evt | MaSprite reset ].
]

{ #category : #running }
MaMario >> update [
	level step.
]
