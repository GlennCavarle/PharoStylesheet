Class {
	#name : #PssTransitionDeclaration,
	#superclass : #PssDeclaration,
	#instVars : [
		'duration',
		'timingFunction',
		'delay'
	],
	#category : #'PharoStylesheet-Core'
}

{ #category : #'adding/removing' }
PssTransitionDeclaration >> addTo: aRule [
	aRule transitions add: self
]

{ #category : #accessing }
PssTransitionDeclaration >> delay [
	^ delay
]

{ #category : #accessing }
PssTransitionDeclaration >> delay: anObject [
	delay := anObject
]

{ #category : #accessing }
PssTransitionDeclaration >> duration [
	^ duration
]

{ #category : #accessing }
PssTransitionDeclaration >> duration: anObject [
	duration := anObject
]

{ #category : #'initialize-release' }
PssTransitionDeclaration >> initialize [
	super initialize.
	duration := 0.
	timingFunction := #linear.
	delay := 0.
]

{ #category : #accessing }
PssTransitionDeclaration >> timingFunction [
	^ timingFunction
]

{ #category : #accessing }
PssTransitionDeclaration >> timingFunction: anObject [
	timingFunction := anObject
]

{ #category : #importing }
PssTransitionDeclaration >> valuesFromArray: anArray [
	self duration: (anArray at: 1 ifAbsent: [ ^ self duration ]) value.
	self timingFunction: (anArray at: 2 ifAbsent: [ ^ self timingFunction ]) value.
	self delay: (anArray at: 3 ifAbsent: [ ^ self delay ]) value
]
