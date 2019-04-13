Class {
	#name : #StyleOrigin,
	#superclass : #Object,
	#category : #'Phass-Core'
}

{ #category : #'as yet unclassified' }
StyleOrigin class >> AUTHOR [
	^ StyleAuthorOrigin
]

{ #category : #'as yet unclassified' }
StyleOrigin class >> INLINE [
	^ StyleInlineOrigin
]

{ #category : #'as yet unclassified' }
StyleOrigin class >> USER [
	^ StyleUserOrigin
]

{ #category : #'as yet unclassified' }
StyleOrigin class >> USER_AGENT [
	^ StyleUserAgentOrigin
]
