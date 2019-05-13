Class {
	#name : #PssKeyframe,
	#superclass : #Object,
	#instVars : [
		'animation',
		'percentage',
		'declarations'
	],
	#category : #'PharoStylesheet-Core'
}

{ #category : #accessing }
PssKeyframe >> animation [
	^ animation
]

{ #category : #accessing }
PssKeyframe >> animation: anObject [
	animation := anObject
]

{ #category : #accessing }
PssKeyframe >> declarations [
	^ declarations
]

{ #category : #accessing }
PssKeyframe >> declarations: aCollection [
	aCollection do: [ :d |
		d rule: self.
		self declarations add: d. ]
]

{ #category : #initialization }
PssKeyframe >> initialize [
	super initialize.
	declarations := OrderedCollection new
]

{ #category : #accessing }
PssKeyframe >> percentage [
	^ percentage
]

{ #category : #accessing }
PssKeyframe >> percentage: anObject [
	percentage := anObject
]
