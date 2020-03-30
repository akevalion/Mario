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
			spec baseline: 'Roassal3'with: [ 
				spec repository: 'github://ObjectProfile/Roassal3' ].
			
			spec 
				package: #'Mario' with: [spec requires: #'Roassal3' ];
				package: #'Mario-Roassal3'.
			spec group: 'default' with: #('Mario' 'Mario-Roassal3') ].

		
	







]
