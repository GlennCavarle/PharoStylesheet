Extension { #name : #Color }

{ #category : #'*Phass' }
Color >> asPhassValue [
	^ StyleColorValue value: self
]
