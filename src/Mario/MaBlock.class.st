"
I am a block class for blocks in Mario
"
Class {
	#name : #MaBlock,
	#superclass : #MaFloor,
	#instVars : [
		'item',
		'usedSprite',
		'bounceSprite',
		'breakable',
		'osprite',
		'opos',
		'level'
	],
	#category : #'Mario-Core'
}

{ #category : #'as yet unclassified' }
MaBlock >> bonk: power [
	(power > 0) & breakable ifTrue: [ ^ self breakB ].
	standing ifFalse: [ ^ self ].
	
	standing := false.
	item ifNotNil: [ item spawn. item := nil ].
	opos := position.
	bounceSprite ifNotNil: [ 
		osprite := sprite.
		sprite := bounceSprite ]
	ifNil: [ sprite := usedSprite ].
	vel := vel x @ -0.2.
]

{ #category : #accessing }
MaBlock >> bounceSprite: aMaSprite [ 
	bounceSprite := aMaSprite
]

{ #category : #accessing }
MaBlock >> breakable: aBool [ 
	breakable := aBool
]

{ #category : #initialization }
MaBlock >> initialize [
	super initialize.
	standing := true.
	vel := 0@0.
]

{ #category : #accessing }
MaBlock >> item: aMaItem [
	item := aMaItem 
	
]

{ #category : #accessing }
MaBlock >> level: aMaLevel [ 
	level := aMaLevel
]

{ #category : #'update cycle' }
MaBlock >> update: dt time: gameTime vx: vx [
	standing not ifTrue: [ 
		position y < (opos y - 0.5)
			ifTrue: [ vel := vel x @ 0.2 ].
		position y > opos y ifTrue: [ 
			vel := vel x@ 0.
			position := opos.
			osprite ifNotNil: [ sprite := osprite ].
			standing := true ]
	] ifFalse: [ 
		sprite == usedSprite ifTrue: [
			level putFloor
				position: position;
				sprite: usedSprite;
				renderOn: box canvas.
			
			level removeBlock: self ].
	].
	position := position + vel.
	sprite updateEntity: self dt: dt
]

{ #category : #accessing }
MaBlock >> usedSprite: aMaSprite [
	usedSprite := aMaSprite
]
