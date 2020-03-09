Class {
	#name : #MaBlock,
	#superclass : #MaEntity,
	#instVars : [
		'item',
		'usedSprite',
		'bounceSprite',
		'breakable'
	],
	#category : #'Mario-Core'
}

{ #category : #accessing }
MaBlock >> bounceSprite: aMaSprite [ 
	bounceSprite := aMaSprite
]

{ #category : #accessing }
MaBlock >> breakable: aBool [ 
	breakable := aBool
]

{ #category : #accessing }
MaBlock >> item: aMaItem [
	item := aMaItem 
	
]

{ #category : #accessing }
MaBlock >> usedSprite: aMaSprite [ 
	usedSprite := aMaSprite
]
