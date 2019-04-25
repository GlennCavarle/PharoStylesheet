Extension { #name : #Integer }

{ #category : #'*PharoStylesheet' }
Integer >> asPssPt [
	^ PssValue pt: self
]

{ #category : #'*PharoStylesheet' }
Integer >> asPssPx [
	^ PssValue px: self
]

{ #category : #'*PharoStylesheet' }
Integer >> pt [
	^self
]

{ #category : #'*PharoStylesheet' }
Integer >> px [
	^self
]
