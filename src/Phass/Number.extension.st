Extension { #name : #Number }

{ #category : #'*Phass' }
Number >> asBlEm [
	^ StyleValue em: self
]

{ #category : #'*Phass' }
Number >> asBlMs [
	^ StyleValue ms: self
]

{ #category : #'*Phass' }
Number >> asBlSec [
	^ StyleValue s: self
]

{ #category : #'*Phass' }
Number >> asPhassValue [
	^ StyleNumberValue value: self
]

{ #category : #'*Phass' }
Number >> em [
	^ self
]

{ #category : #'*Phass' }
Number >> ms [
	^ self 
]

{ #category : #'*Phass' }
Number >> rem [
	^ self
]

{ #category : #'*Phass' }
Number >> s [
	^ self * 1000
]
