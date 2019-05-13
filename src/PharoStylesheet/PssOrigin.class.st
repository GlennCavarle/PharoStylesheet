Class {
	#name : #PssOrigin,
	#superclass : #Object,
	#category : #'PharoStylesheet-Core'
}

{ #category : #origins }
PssOrigin class >> AUTHOR [
	^ PssAuthorOrigin
]

{ #category : #origins }
PssOrigin class >> INLINE [
	^ PssInlineOrigin
]

{ #category : #origins }
PssOrigin class >> USER [
	^ PssUserOrigin
]

{ #category : #origins }
PssOrigin class >> USER_AGENT [
	^ PssUserAgentOrigin
]
