Class {
	#name : #PssMatchedRule,
	#superclass : #Object,
	#instVars : [
		'selector',
		'declarations',
		'transitions',
		'conditions'
	],
	#classVars : [
		'AkStyleTransition'
	],
	#category : #'PharoStylesheet-Utils'
}

{ #category : #'as yet unclassified' }
PssMatchedRule >> computedStyles [
	^ self declarations
		collect: [ :d | 
			PssStyle new
				selector: self selector;
				declaration: d;
				conditions: self conditions;
				yourself ]
]

{ #category : #'as yet unclassified' }
PssMatchedRule >> computedTransitions [
	^ self transitions
		collect: [ :t | PssTransition new
				selector: self selector;
				transition: t;
				yourself ]
]

{ #category : #accessing }
PssMatchedRule >> conditions [
	^ conditions
]

{ #category : #accessing }
PssMatchedRule >> conditions: anObject [
	conditions := anObject
]

{ #category : #accessing }
PssMatchedRule >> declarations [
	^ declarations
]

{ #category : #accessing }
PssMatchedRule >> declarations: anObject [
	declarations := anObject
]

{ #category : #accessing }
PssMatchedRule >> selector [
	^ selector
]

{ #category : #accessing }
PssMatchedRule >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
PssMatchedRule >> specificity [
	^ selector specificity
]

{ #category : #accessing }
PssMatchedRule >> transitions [
	^ transitions
]

{ #category : #accessing }
PssMatchedRule >> transitions: anObject [
	transitions := anObject
]
