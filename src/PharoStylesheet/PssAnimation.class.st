Class {
	#name : #PssAnimation,
	#superclass : #Object,
	#instVars : [
		'name',
		'keyframes',
		'stylesheet'
	],
	#category : #'PharoStylesheet-Core'
}

{ #category : #adding }
PssAnimation >> addTo: aStylesheet [
	self stylesheet: aStylesheet.
	aStylesheet animations add: self
]

{ #category : #initialization }
PssAnimation >> initialize [ 
	super initialize.
	keyframes := OrderedCollection new
]

{ #category : #accessing }
PssAnimation >> keyframes [
	^ keyframes
]

{ #category : #accessing }
PssAnimation >> keyframes: aCollection [
	aCollection do: [ :e |
		e animation: self.
		self keyframes add: e ]
]

{ #category : #accessing }
PssAnimation >> name [
	^ name
]

{ #category : #accessing }
PssAnimation >> name: anObject [
	name := anObject
]

{ #category : #accessing }
PssAnimation >> stylesheet [
	^ stylesheet
]

{ #category : #accessing }
PssAnimation >> stylesheet: anObject [
	stylesheet := anObject
]
