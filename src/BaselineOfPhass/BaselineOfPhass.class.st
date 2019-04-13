Class {
	#name : #BaselineOfPhass,
	#superclass : #BaselineOf,
	#category : #BaselineOfPhass
}

{ #category : #baselines }
BaselineOfPhass >> baseline: spec [ 
<baseline>

	spec for: #common do: [
		self petitParser: spec.
		spec package: #'Phass' with: [ spec requires: #(#'PetitParser') ]
	]
]

{ #category : #baselines }
BaselineOfPhass >> petitParser: spec [
	spec
		baseline: 'PetitParser' with: [ spec
		repository: 'github://moosetechnology/PetitParser/src';
		loads: #('Core') ]
]
