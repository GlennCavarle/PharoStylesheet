Class {
	#name : #PssValue,
	#superclass : #Object,
	#instVars : [
		'value',
		'transition',
		'animation'
	],
	#category : #'PharoStylesheet-Value'
}

{ #category : #'as yet unclassified' }
PssValue class >> em: aValue [
	^ PssEmValue value: aValue 
]

{ #category : #'as yet unclassified' }
PssValue class >> ms: aValue [
	^ CssDurationValue value: aValue
]

{ #category : #'as yet unclassified' }
PssValue class >> percent: aValue [
	^ PssPercentValue value: aValue percent
]

{ #category : #'as yet unclassified' }
PssValue class >> pt: aValue [
	^ PssPtValue value: aValue 
]

{ #category : #'as yet unclassified' }
PssValue class >> px: aValue [
	^ PssPixelValue value: aValue
]

{ #category : #'as yet unclassified' }
PssValue class >> rem: aValue [
	^ PssRemValue value: aValue rem
]

{ #category : #'as yet unclassified' }
PssValue class >> s: aValue [
	^ PssDurationValue value: aValue seconds
]

{ #category : #'as yet unclassified' }
PssValue class >> value: aValue [
	^ self value: aValue transition: nil
]

{ #category : #'as yet unclassified' }
PssValue class >> value: aValue transition: aTransition [
	^ self new
		value: aValue;
		transition: aTransition;
		yourself
]

{ #category : #'as yet unclassified' }
PssValue >> + anObject [
	^ self value + anObject
]

{ #category : #'as yet unclassified' }
PssValue >> = aStyleValue [
	^ self value = aStyleValue value
]

{ #category : #'as yet unclassified' }
PssValue >> @ anObject [
	^ self value @ anObject
]

{ #category : #accessing }
PssValue >> animation [
	^ animation
]

{ #category : #accessing }
PssValue >> animation: anObject [
	animation := anObject
]

{ #category : #'as yet unclassified' }
PssValue >> asPssValue [
	^ self
]

{ #category : #accessing }
PssValue >> computeValueFrom: aTarget property: aSymbol [
	^ self 
]

{ #category : #'as yet unclassified' }
PssValue >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: self value
]

{ #category : #'as yet unclassified' }
PssValue >> hasTransition [
	^ self transition isNotNil and: [ self transition duration > 0 ]
]

{ #category : #accessing }
PssValue >> initialize [
	super initialize.

]

{ #category : #testing }
PssValue >> isFunction [
	^ false
]

{ #category : #testing }
PssValue >> isPixelValue [
	^ false
]

{ #category : #accessing }
PssValue >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		nextPutAll: self value asString;
		nextPut: $)
]

{ #category : #accessing }
PssValue >> property: aSymbol of: aTarget [
	^ aTarget styler perform: aSymbol
]

{ #category : #accessing }
PssValue >> transition [
	^ transition
]

{ #category : #accessing }
PssValue >> transition: anObject [
	transition := anObject
]

{ #category : #accessing }
PssValue >> value [
	^ value
]

{ #category : #accessing }
PssValue >> value: anObject [
	value := anObject
]

{ #category : #'as yet unclassified' }
PssValue >> valueRelativeTo: aTargetProperty [
	^ self value
]
