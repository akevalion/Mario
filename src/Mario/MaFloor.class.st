"
I represent a floor block
"
Class {
	#name : #MaFloor,
	#superclass : #MaEntity,
	#category : #'Mario-Core'
}

{ #category : #public }
MaFloor >> bonk: ent [
]

{ #category : #public }
MaFloor >> collideWith: ent [
	| com1 com2 c1 c2 signal |
	com1 := self box encompassingRectangle.
	com2 := ent box encompassingRectangle.
	(com1 intersects: com2) ifFalse: [ ^ self ].
	standing ifFalse: [ ent bump ]. 
	c1 := com1 rsCenter.
	c2 := com2 rsCenter.
	signal := ent vel y < 0 ifTrue: -1 ifFalse: 1.
	(com2 bottom - com1 top) abs <= (16 * signal) ifTrue: [ 
		(self level
			hasStaticAt: position + (0@ -1)) 
				ifTrue: [ ^ self ].
		ent
			velY: 0;
			positionY: position y - 1;
			standing: true.
		ent class == MaPlayer ifTrue: [ 
			ent jumping: 0 ] ]
	ifFalse: [
		((c2 y > c1 y) and: [ 
			c2 x + 2 >= com1 left and: [ c2 x -2 <= com1 right ] ]) ifTrue: [ 
			ent 
				velY: 0;
				positionY: position y + 1.
			self bonk: ent power.
			ent jumping: 0. ]
		ifFalse: [ ent collideWall: self ] ]
]

{ #category : #initialization }
MaFloor >> initialize [
	super initialize.
	code := 4.
]
