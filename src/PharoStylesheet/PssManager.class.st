Class {
	#name : #PssManager,
	#superclass : #Object,
	#instVars : [
		'styleMap'
	],
	#category : #'PharoStylesheet-Utils'
}

{ #category : #'as yet unclassified' }
PssManager >> initialize [
	super initialize.
	styleMap := Dictionary new.
]

{ #category : #'as yet unclassified' }
PssManager >> stylesFor: aStyleable [
	styleMap at: aStyleable
]

{ #category : #'as yet unclassified' }
PssManager >> transitionStatesFor: aNode [
	| parent states |
	states := OrderedCollection new.
	parent := aNode.
	[ parent isNotNil ]
		whileTrue:[ 
			states add: parent pseudoClassStates.
			parent := parent parent].
	^ states  
]
