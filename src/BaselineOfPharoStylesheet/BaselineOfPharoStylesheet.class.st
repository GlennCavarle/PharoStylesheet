Class {
	#name : #BaselineOfPharoStylesheet,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharoStylesheet
}

{ #category : #baselines }
BaselineOfPharoStylesheet >> baseline: spec [ 
<baseline>

	spec for: #common do: [
		self petitParser: spec.
		spec 
			package: #'PharoStylesheet' with: [ spec requires: #(#'PetitParser') ];
			package: #'PharoStylesheet-Tests' with: [ spec requires: #(#'PharoStylesheet') ]
	]
]

{ #category : #baselines }
BaselineOfPharoStylesheet >> petitParser: spec [
	spec
		baseline: 'PetitParser' with: [ spec
		repository: 'github://moosetechnology/PetitParser/src';
		loads: #('Core') ]
]
