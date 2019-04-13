Extension { #name : #Array }

{ #category : #'*Phass' }
Array >> asPhassValue [
	^ BlArrayValue value: self
]
