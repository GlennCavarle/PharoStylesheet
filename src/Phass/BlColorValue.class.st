Class {
	#name : #BlColorValue,
	#superclass : #StyleValue,
	#category : #'Phass-Value'
}

{ #category : #'as yet unclassified' }
BlColorValue >> defaultAnimation [
	^ BlColorTransition new 
]
