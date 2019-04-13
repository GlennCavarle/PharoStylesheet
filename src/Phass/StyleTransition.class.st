"
to be removed ?
"
Class {
	#name : #StyleTransition,
	#superclass : #StyleStyle,
	#category : #'Phass-Utils'
}

{ #category : #accessing }
StyleTransition >> transition [
	^ declaration
]

{ #category : #accessing }
StyleTransition >> transition: anObject [
	declaration := anObject
]
