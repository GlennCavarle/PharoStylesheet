Class {
	#name : #PssPropertyDeclaration,
	#superclass : #PssDeclaration,
	#instVars : [
		'value'
	],
	#category : #'PharoStylesheet-Core'
}

{ #category : #'as yet unclassified' }
PssPropertyDeclaration >> = aDeclaration [
	^ super = aDeclaration and: [ self value = aDeclaration value ]
]

{ #category : #'adding/removing' }
PssPropertyDeclaration >> addTo: aRule [
	aRule declarations add: self
]

{ #category : #printing }
PssPropertyDeclaration >> printOn: aStream [
	aStream
		nextPutAll: self property;
		nextPutAll: ': ';
		nextPutAll: self value asString.
	self isImportant
		ifTrue: [ aStream nextPutAll: '!important' ]
]

{ #category : #accessing }
PssPropertyDeclaration >> value [
	^ value
]

{ #category : #accessing }
PssPropertyDeclaration >> value: anObject [
	value := anObject
]
