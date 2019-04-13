"
to be removed ?
"
Class {
	#name : #StyleTransition,
	#superclass : #Style,
	#category : #'Phass-Util'
}

{ #category : #accessing }
StyleTransition >> transition [
	^ declaration
]

{ #category : #accessing }
StyleTransition >> transition: anObject [
	declaration := anObject
]
