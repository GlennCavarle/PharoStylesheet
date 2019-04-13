Extension { #name : #Symbol }

{ #category : #'*Phass' }
Symbol >> asBl2StyleValue [
	^ Bl2SymbolValue value: self
]

{ #category : #'*Phass' }
Symbol >> asPhassValue [
	^ StyleSymbolValue value: self
]
