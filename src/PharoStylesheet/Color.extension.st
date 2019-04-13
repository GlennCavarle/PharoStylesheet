Extension { #name : #Color }

{ #category : #'*PharoStylesheet' }
Color >> asPssValue [
	^ PssColorValue value: self
]
