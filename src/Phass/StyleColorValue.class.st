Class {
	#name : #StyleColorValue,
	#superclass : #StyleValue,
	#category : #'Phass-Value'
}

{ #category : #'as yet unclassified' }
StyleColorValue >> defaultAnimation [
	^ BlColorTransition new 
]
