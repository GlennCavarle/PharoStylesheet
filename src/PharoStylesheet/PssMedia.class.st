Class {
	#name : #PssMedia,
	#superclass : #Object,
	#instVars : [
		'conditions',
		'rules',
		'stylesheet'
	],
	#category : #'PharoStylesheet-Core'
}

{ #category : #'adding/removing' }
PssMedia >> addTo: aStylesheet [
	self stylesheet: aStylesheet.
	aStylesheet medias add: self
]

{ #category : #'as yet unclassified' }
PssMedia >> computedStyles [
	
]

{ #category : #accessing }
PssMedia >> conditions [
	^ conditions
]

{ #category : #accessing }
PssMedia >> conditions: aCollection [
	aCollection
		do: [ :item | 
			item media: self.
			self conditions add: item ]
]

{ #category : #'initialize-release' }
PssMedia >> initialize [
	super initialize.
	conditions := OrderedCollection new.
	rules := OrderedCollection new
]

{ #category : #accessing }
PssMedia >> rules [
	^ rules
]

{ #category : #accessing }
PssMedia >> rules: anObject [
	rules := anObject
]

{ #category : #accessing }
PssMedia >> stylesheet [
	^ stylesheet
]

{ #category : #accessing }
PssMedia >> stylesheet: anObject [
	stylesheet := anObject
]
