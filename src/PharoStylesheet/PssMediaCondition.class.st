Class {
	#name : #PssMediaCondition,
	#superclass : #Object,
	#instVars : [
		'type',
		'conditions',
		'media'
	],
	#category : #'PharoStylesheet-Core'
}

{ #category : #accessing }
PssMediaCondition >> conditions [
	^ conditions
]

{ #category : #accessing }
PssMediaCondition >> conditions: anObject [
	conditions := anObject
]

{ #category : #'evaluating conditions' }
PssMediaCondition >> heightOf: aTarget value: aValue [
	^ aTarget height = aValue
]

{ #category : #testing }
PssMediaCondition >> isValidOn: aTarget [
	| typeTarget |
	typeTarget := PssMediaTarget
		perform: (self type , 'On:') asSymbol
		with: aTarget.
	conditions
		keysAndValuesDo:
			[ :k :v | 
			(self
				perform: (k , 'Of:' , 'value:') asSymbol
				withEnoughArguments:
					{typeTarget.
					v value})
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #'evaluating conditions' }
PssMediaCondition >> maxHeightOf: aTarget value: aValue [
	^ aTarget height <= aValue
]

{ #category : #'evaluating conditions' }
PssMediaCondition >> maxWidthOf: aTarget value: aValue [
	^ aTarget width <= aValue
]

{ #category : #accessing }
PssMediaCondition >> media [
	^ media
]

{ #category : #accessing }
PssMediaCondition >> media: anObject [
	media := anObject
]

{ #category : #'evaluating conditions' }
PssMediaCondition >> minHeightOf: aTarget value: aValue [
	^ aTarget height >= aValue
]

{ #category : #'evaluating conditions' }
PssMediaCondition >> minWidthOf: aTarget value: aValue [
	^ aTarget width >= aValue
]

{ #category : #accessing }
PssMediaCondition >> type [
	^ type
]

{ #category : #accessing }
PssMediaCondition >> type: anObject [
	type := anObject
]

{ #category : #'evaluating conditions' }
PssMediaCondition >> widthOf: aTarget value: aValue [
	^ aTarget width = aValue
]
