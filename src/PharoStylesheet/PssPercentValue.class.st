Class {
	#name : #PssPercentValue,
	#superclass : #PssValue,
	#category : #'PharoStylesheet-Value'
}

{ #category : #'as yet unclassified' }
PssPercentValue >> computeValueFrom: aTargetNode property: aSymbol [
	aTargetNode owner
		ifNotNil: [ :p | 
			| pValue |
			pValue := p height max: p width.
			^ pValue * self value ].
	Error signal: 'a styleable parent must exist in order to apply a relative size '
]
