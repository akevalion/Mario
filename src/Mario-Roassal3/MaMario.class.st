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
MaMario >> processKeyDown: evt [
	| char delta |
	char := evt keyCharacter.
	delta := -20@0.
	char == Character arrowLeft ifTrue: [ canvas camera translateBy: delta  ].
	char == Character arrowRight ifTrue: [ canvas camera translateBy: delta negated ].
	canvas signalUpdate.
]

{ #category : #running }
MaMario >> processKeyUp: evt [
]

{ #category : #running }
MaMario >> registerEvents [
	canvas newAnimation repeat; onStepDo: [ :t | self update ].
	canvas 
		when: RSKeyDown do: [ :evt | self processKeyDown: evt ];
		when: RSKeyDown do: [ :evt | self processKeyUp: evt ];
		when: RSExtentChangedEvent do: [ :evt | 
			canvas camera 
				zoomToFit: canvas extent 
				rectangle: (-8 asPoint corner: 16@14 *16).
			canvas signalUpdate  ].
]

{ #category : #running }
MaMario >> run [
	<script: 'self new run'>
	| w |
	canvas := RSCanvas new.
	canvas attributeAt: #player put: self createMario.
	self createWorld.
	self registerEvents.
	w := canvas open setLabel: 'Mario'.
	w announcer when: WindowClosed do: [:evt | MaSprite reset ].
]

{ #category : #running }
MaMario >> update [
	level step.
]
