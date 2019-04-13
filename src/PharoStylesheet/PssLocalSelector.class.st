Class {
	#name : #PssLocalSelector,
	#superclass : #PssSimpleSelector,
	#instVars : [
		'target'
	],
	#category : #'PharoStylesheet-Utils'
}

{ #category : #'as yet unclassified' }
PssLocalSelector class >> target: aNode [
	^ self new
		target: aNode;
		yourself
]

{ #category : #'as yet unclassified' }
PssLocalSelector >> matchesPseudoClasseState: aPseudoClassStates [
	^ aPseudoClassStates includesAll: pseudoClasses
]

{ #category : #'as yet unclassified' }
PssLocalSelector >> matchesStyleable: aStyleable [
	^ true
]

{ #category : #'as yet unclassified' }
PssLocalSelector >> origin [
	^ PssOrigin INLINE
]

{ #category : #accessing }
PssLocalSelector >> target [
	^ target
]

{ #category : #accessing }
PssLocalSelector >> target: anObject [
	target := anObject
]

{ #category : #'as yet unclassified' }
PssLocalSelector >> updateSpecificity [
	idCount := 0.
	styleClassCount := self target styleClassProperty size.
	pseudoClassCount := self pseudoClasses size.
	nameCount := 0.
	specificity := idCount << 8 | (pseudoClassCount << 4) | styleClassCount | nameCount
]
