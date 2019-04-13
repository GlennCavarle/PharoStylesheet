Class {
	#name : #StyleRelation,
	#superclass : #Object,
	#instVars : [
		'type'
	],
	#category : #'Phass-Core'
}

{ #category : #'as yet unclassified' }
StyleRelation class >> CHILD [
	^ StyleChildRelation
]

{ #category : #'as yet unclassified' }
StyleRelation class >> DESCENDANT [
	^ StyleDescendantRelation
]

{ #category : #'as yet unclassified' }
StyleRelation class >> isChild [
	^ false
]

{ #category : #'as yet unclassified' }
StyleRelation class >> isDescendant [
	^ false
]
