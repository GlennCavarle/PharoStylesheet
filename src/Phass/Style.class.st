Class {
	#name : #Style,
	#superclass : #Object,
	#instVars : [
		'selector',
		'declaration',
		'conditions',
		'ordinal'
	],
	#category : #'Phass-Util'
}

{ #category : #comparing }
Style >> < aStyle [
	^ (self compareTo: aStyle) = -1 or: (self specificity = aStyle specificity and: self ordinal < aStyle ordinal)
]

{ #category : #comparing }
Style >> <= aStyle [
	^ ((self compareTo: aStyle) = 1) not
]

{ #category : #comparing }
Style >> = aStyle [
	^ super = aStyle or: [ ((self compareTo: aStyle) = 0
		and: [ self selector = aStyle selector ]) and: [ self declaration = aStyle declaration ] ]
]

{ #category : #comparing }
Style >> > aStyle [
	^ (self compareTo: aStyle) = 1 or: (self specificity = aStyle specificity and: self ordinal > aStyle ordinal)
]

{ #category : #comparing }
Style >> >= aStyle [
	^ (self compareTo: aStyle) != -1
]

{ #category : #comparing }
Style >> compareTo: aStyle [
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
Style >> conditions [
	^ conditions
]

{ #category : #accessing }
Style >> conditions: anObject [
	conditions := anObject
]

{ #category : #accessing }
Style >> declaration [
	^ declaration
]

{ #category : #accessing }
Style >> declaration: anObject [
	declaration := anObject
]

{ #category : #testing }
Style >> isImportant [
	^ declaration isImportant
]

{ #category : #testing }
Style >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	self conditions
		ifNotNil: [ :cs | 
			 cs do: [ :c | 
					(c isValidOn: aStyleable) ifFalse: [ ^ false ] ] ].
			
	^ self selector matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList
]

{ #category : #accessing }
Style >> ordinal [
	^ ordinal
]

{ #category : #accessing }
Style >> ordinal: anObject [
	ordinal := anObject
]

{ #category : #accessing }
Style >> origin [
	^ selector origin
]

{ #category : #printing }
Style >> printOn: aStream [
	self declaration printOn: aStream
]

{ #category : #accessing }
Style >> selector [
	^ selector
]

{ #category : #accessing }
Style >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
Style >> specificity [
	^ selector specificity + (conditions isNotNil and: [ conditions isNotEmpty ]) asBit
]
