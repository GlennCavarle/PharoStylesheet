Class {
	#name : #PssFunctionValue,
	#superclass : #PssValue,
	#instVars : [
		'args'
	],
	#category : #'PharoStylesheet-Value'
}

{ #category : #comparing }
PssFunctionValue >> = aFunction [
	^ super = aFunction and: [ self args = aFunction args ]
]

{ #category : #accessing }
PssFunctionValue >> args [
	^ args
]

{ #category : #accessing }
PssFunctionValue >> args: anObject [
	args := anObject
]

{ #category : #testing }
PssFunctionValue >> isFunction [
	^ true
]
