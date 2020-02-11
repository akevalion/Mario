Class {
	#name : #BaselineOfMario,
	#superclass : #BaselineOf,
	#category : #BaselineOfMario
}

{ #category : #baselines }
BaselineOfMario >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec package: 'Roassal3'with: [ 
				spec repository: 'github://ObjectProfile/Roassal3/src' ].
			
			spec package: #'Mario' with: [spec requires: #'Roassal3' ].
			spec group: 'default' with: #('Mario') ].

		
	







]
