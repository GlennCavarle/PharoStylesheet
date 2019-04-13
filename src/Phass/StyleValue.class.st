Class {
	#name : #StyleValue,
	#superclass : #Object,
	#instVars : [
		'value',
		'transition',
		'animation'
	],
	#category : #'Phass-Value'
}

{ #category : #'as yet unclassified' }
StyleValue class >> em: aValue [
	^ StyleEmValue value: aValue 
]

{ #category : #'as yet unclassified' }
StyleValue class >> ms: aValue [
	^ StyleDurationValue value: aValue ms
]

{ #category : #'as yet unclassified' }
StyleValue class >> percent: aValue [
	^ StylePercentValue value: aValue percent
]

{ #category : #'as yet unclassified' }
StyleValue class >> pt: aValue [
	^ StylePtValue value: aValue 
]

{ #category : #'as yet unclassified' }
StyleValue class >> px: aValue [
	^ StylePixelValue value: aValue px
]

{ #category : #'as yet unclassified' }
StyleValue class >> rem: aValue [
	^ StyleRemValue value: aValue rem
]

{ #category : #'as yet unclassified' }
StyleValue class >> s: aValue [
	^ StyleDurationValue value: aValue s
]

{ #category : #'as yet unclassified' }
StyleValue class >> value: aValue [
	^ self value: aValue transition: nil
]

{ #category : #'as yet unclassified' }
StyleValue class >> value: aValue transition: aTransition [
	^ self new
		value: aValue;
		transition: aTransition;
		yourself
]

{ #category : #'as yet unclassified' }
StyleValue >> + anObject [
	^ self value + anObject
]

{ #category : #'as yet unclassified' }
StyleValue >> = aStyleValue [
	^ self value = aStyleValue value
]

{ #category : #'as yet unclassified' }
StyleValue >> @ anObject [
	^ self value @ anObject
]

{ #category : #accessing }
StyleValue >> animation [
	^ animation ifNil: [ animation := self defaultAnimation ]
]

{ #category : #accessing }
StyleValue >> animation: anObject [
	animation := anObject
]

{ #category : #accessing }
StyleValue >> apply: aValue on: aTarget property: aSymbol [
	aTarget perform: aSymbol asMutator with: aValue
]

{ #category : #accessing }
StyleValue >> applyOn: aTarget property: aSymbol [
	| valueToApply |
	valueToApply := self computeValueFrom: aTarget property: aSymbol.
	(self transition isNil or: [ self transition duration = 0 ])
		ifTrue: [ self apply: valueToApply on: aTarget property: aSymbol ]
		ifFalse: [ self transite: valueToApply on: aTarget property: aSymbol ]
]

{ #category : #'as yet unclassified' }
StyleValue >> asPhassValue [
	^ self
]

{ #category : #accessing }
StyleValue >> computeValueFrom: aTarget property: aSymbol [
	^ self 
]

{ #category : #accessing }
StyleValue >> defaultAnimation [
	^ BlNumberTransition new
]

{ #category : #'as yet unclassified' }
StyleValue >> doesNotUnderstand: aMessage [
	^ aMessage sendTo: self value
]

{ #category : #'as yet unclassified' }
StyleValue >> hasTransition [
	^ self transition isNotNil and: [ self transition duration > 0 ]
]

{ #category : #accessing }
StyleValue >> initialize [
	super initialize.

]

{ #category : #accessing }
StyleValue >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPut: $(;
		nextPutAll: self value asString;
		nextPut: $)
]

{ #category : #accessing }
StyleValue >> property: aSymbol of: aTarget [
	^ aTarget styler perform: aSymbol
]

{ #category : #accessing }
StyleValue >> transite: aValue on: aTarget property: aSymbol [
	| anim |
	anim := self animation
		duration: self transition duration;
		delay: self transition delay;
		from: (self property: aSymbol of: aTarget);
		to: aValue;
		easing:(BlEasing perform:self transition timingFunction);
		onStepDo: [ :v | self apply: v on: aTarget property: aSymbol ].
	anim start.
]

{ #category : #accessing }
StyleValue >> transition [
	^ transition
]

{ #category : #accessing }
StyleValue >> transition: anObject [
	transition := anObject
]

{ #category : #accessing }
StyleValue >> value [
	^ value
]

{ #category : #accessing }
StyleValue >> value: anObject [
	value := anObject
]

{ #category : #'as yet unclassified' }
StyleValue >> valueRelativeTo: aTargetProperty [
	^ self value
]
