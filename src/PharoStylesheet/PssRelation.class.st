Class {
	#name : #PssRelation,
	#superclass : #Object,
	#instVars : [
		'type'
	],
	#category : #'PharoStylesheet-Core'
}

{ #category : #'as yet unclassified' }
PssRelation class >> CHILD [
	^ PssChildRelation
]

{ #category : #'as yet unclassified' }
PssRelation class >> DESCENDANT [
	^ PssDescendantRelation
]

{ #category : #'as yet unclassified' }
PssRelation class >> isChild [
	^ false
]

{ #category : #'as yet unclassified' }
PssRelation class >> isDescendant [
	^ false
]
