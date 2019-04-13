Class {
	#name : #PssPseudoClassStates,
	#superclass : #OrderedCollection,
	#instVars : [
		'styleable'
	],
	#category : #'PharoStylesheet-Utils'
}

{ #category : #'as yet unclassified' }
PssPseudoClassStates class >> on: aStyleable [
	^ self new
		styleable: aStyleable;
		yourself
]

{ #category : #accessing }
PssPseudoClassStates >> styleable [
	^ styleable
]

{ #category : #accessing }
PssPseudoClassStates >> styleable: anObject [
	styleable := anObject
]
