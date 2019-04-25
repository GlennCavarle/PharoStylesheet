"
to be removed ?
"
Class {
	#name : #PssTransition,
	#superclass : #PssStyle,
	#category : #'PharoStylesheet-Utils'
}

{ #category : #accessing }
PssTransition >> transition [
	^ declaration
]

{ #category : #accessing }
PssTransition >> transition: anObject [
	declaration := anObject
]
