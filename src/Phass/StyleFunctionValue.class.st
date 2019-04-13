Class {
	#name : #StyleFunctionValue,
	#superclass : #StyleValue,
	#instVars : [
		'args'
	],
	#category : #'Phass-Value'
}

{ #category : #comparing }
StyleFunctionValue >> = aFunction [
	^ super = aFunction and: [ self args = aFunction args ]
]

{ #category : #accessing }
StyleFunctionValue >> args [
	^ args
]

{ #category : #accessing }
StyleFunctionValue >> args: anObject [
	args := anObject
]

{ #category : #testing }
StyleFunctionValue >> isFunction [
	^ true
]
