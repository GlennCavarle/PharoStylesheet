Class {
	#name : #PssStyle,
	#superclass : #Object,
	#instVars : [
		'selector',
		'declaration',
		'conditions',
		'ordinal'
	],
	#category : #'PharoStylesheet-Utils'
}

{ #category : #comparing }
PssStyle >> < aStyle [
	^ (self compareTo: aStyle) = -1 or: (self specificity = aStyle specificity and: self ordinal < aStyle ordinal)
]

{ #category : #comparing }
PssStyle >> <= aStyle [
	^ ((self compareTo: aStyle) = 1) not
]

{ #category : #comparing }
PssStyle >> = aStyle [
	^ super = aStyle or: [ ((self compareTo: aStyle) = 0
		and: [ self selector = aStyle selector ]) and: [ self declaration = aStyle declaration ] ]
]

{ #category : #comparing }
PssStyle >> > aStyle [
	^ (self compareTo: aStyle) = 1 or: (self specificity = aStyle specificity and: self ordinal > aStyle ordinal)
]

{ #category : #comparing }
PssStyle >> >= aStyle [
	^ (self compareTo: aStyle) != -1
]

{ #category : #comparing }
PssStyle >> compareTo: aStyle [
	self isImportant = aStyle isImportant
		ifFalse: [ ^ self isImportant
				ifTrue: [ 1 ]
				ifFalse: [ -1 ] ].
	self origin = aStyle origin
		ifFalse:
			[ ^ (self origin priority >= aStyle origin priority and: [ self specificity >= aStyle specificity ])
				ifTrue: [ 1 ]
				ifFalse: [ -1 ] ].
	self specificity = aStyle specificity
		ifFalse: [ ^ self specificity >= aStyle specificity
				ifTrue: [ 1 ]
				ifFalse: [ -1 ] ].
	^ 0
]

{ #category : #accessing }
PssStyle >> conditions [
	^ conditions
]

{ #category : #accessing }
PssStyle >> conditions: anObject [
	conditions := anObject
]

{ #category : #accessing }
PssStyle >> declaration [
	^ declaration
]

{ #category : #accessing }
PssStyle >> declaration: anObject [
	declaration := anObject
]

{ #category : #testing }
PssStyle >> isImportant [
	^ declaration isImportant
]

{ #category : #testing }
PssStyle >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	self conditions
		ifNotNil: [ :cs | 
			 cs do: [ :c | 
					(c isValidOn: aStyleable) ifFalse: [ ^ false ] ] ].
			
	^ self selector matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList
]

{ #category : #accessing }
PssStyle >> ordinal [
	^ ordinal
]

{ #category : #accessing }
PssStyle >> ordinal: anObject [
	ordinal := anObject
]

{ #category : #accessing }
PssStyle >> origin [
	^ selector origin
]

{ #category : #printing }
PssStyle >> printOn: aStream [
	self declaration printOn: aStream
]

{ #category : #accessing }
PssStyle >> selector [
	^ selector
]

{ #category : #accessing }
PssStyle >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
PssStyle >> specificity [
	^ selector specificity + (conditions isNotNil and: [ conditions isNotEmpty ]) asBit
]
