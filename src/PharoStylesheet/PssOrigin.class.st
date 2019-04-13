Class {
	#name : #PssOrigin,
	#superclass : #Object,
	#category : #'PharoStylesheet-Core'
}

{ #category : #'as yet unclassified' }
PssOrigin class >> AUTHOR [
	^ CSSAuthorOrigin
]

{ #category : #'as yet unclassified' }
PssOrigin class >> INLINE [
	^ CSSInlineOrigin
]

{ #category : #'as yet unclassified' }
PssOrigin class >> USER [
	^ CSSUserOrigin
]

{ #category : #'as yet unclassified' }
PssOrigin class >> USER_AGENT [
	^ CSSUserAgentOrigin
]
