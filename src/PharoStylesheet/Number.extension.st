Extension { #name : #Number }

{ #category : #'*PharoStylesheet' }
Number >> asPssEm [
	^ PssValue em: self
]

{ #category : #'*PharoStylesheet' }
Number >> asPssMs [
	^ PssValue ms: self
]

{ #category : #'*PharoStylesheet' }
Number >> asPssSec [
	^ PssValue s: self
]

{ #category : #'*PharoStylesheet' }
Number >> asPssValue [
	^ PssNumberValue value: self
]

{ #category : #'*PharoStylesheet' }
Number >> em [
	^ self
]

{ #category : #'*PharoStylesheet' }
Number >> ms [
	^ self 
]

{ #category : #'*PharoStylesheet' }
Number >> rem [
	^ self
]

{ #category : #'*PharoStylesheet' }
Number >> s [
	^ self * 1000
]
