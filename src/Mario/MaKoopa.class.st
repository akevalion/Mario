"
I am an enemy
"
Class {
	#name : #MaKoopa,
	#superclass : #MaEnemy,
	#category : #'Mario-Core'
}

{ #category : #'update cycle' }
MaKoopa >> checkCollisions [
]

{ #category : #initialization }
MaKoopa >> initialize [
	super initialize.
	code := 2.
]

{ #category : #'update cycle' }
MaKoopa >> update: dt time: gameTime vx: vx [
]
