Class {
	#name : #PssSelector,
	#superclass : #Object,
	#instVars : [
		'rule',
		'specificity',
		'matchOnId',
		'matchOnName',
		'matchOnStyleClass'
	],
	#category : #'PharoStylesheet-Core'
}

{ #category : #'as yet unclassified' }
PssSelector class >> from: anObject [
	anObject isSymbol
		ifTrue: [ ^ self fromSymbol: anObject ].
	(anObject isArray and: [ anObject size = 1 ])
		ifTrue: [ ^ self fromSymbol: anObject first ].
	anObject isArray
		ifTrue: [ ^ self fromSymbols: anObject ]
]

{ #category : #'as yet unclassified' }
PssSelector class >> fromSymbol: aSymbol [
	| parts selector |
	parts := BlStyleHelper splitSelectorSymbol: aSymbol.
	selector := BlStyleSimpleSelector new
		name: nil;
		styleClasses: {parts first asSymbol};
		id: nil;
		yourself.
	parts size > 1
		ifTrue:
			[ 
			selector pseudoClasses
				addAll: (parts allButFirst collect: [ :each | BlState fromSymbol: each asSymbol ]) ].
	selector update.
	^ selector
]

{ #category : #'as yet unclassified' }
PssSelector class >> fromSymbols: aSymbolList [
	| selectors relationships |
	selectors := OrderedCollection new.
	relationships := OrderedCollection new.
	aSymbolList
		do:
			[ :aSymb | 
			aSymb = #>
				ifTrue: [ relationships add: CSSRelation CHILD ]
				ifFalse:
					[ 
					(aSymb = aSymbolList first) not
						ifTrue: [ relationships add: CSSRelation DESCENDANT ].
					selectors add: (self fromSymbol: aSymb) ] ].
	^ (CSSCompoundSelector selectors: selectors relationships: relationships)
		update;
		yourself
]

{ #category : #testing }
PssSelector >> isSimpleSelector [
	^ false
]

{ #category : #testing }
PssSelector >> matchesOnId [
	^ matchOnId
]

{ #category : #testing }
PssSelector >> matchesOnName [
	^ matchOnName 
]

{ #category : #testing }
PssSelector >> matchesOnStyleClass [ 
	^ matchOnStyleClass 
]

{ #category : #testing }
PssSelector >> matchesStyleable: aStyleable [
	self subclassResponsibility 
]

{ #category : #testing }
PssSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	self subclassResponsibility 
]

{ #category : #testing }
PssSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex [
	self subclassResponsibility 
]

{ #category : #accessing }
PssSelector >> origin [
	^ self rule origin
]

{ #category : #accessing }
PssSelector >> rule [
	^ rule
]

{ #category : #accessing }
PssSelector >> rule: anObject [
	rule := anObject
]

{ #category : #accessing }
PssSelector >> specificity [
	^ specificity
]

{ #category : #updating }
PssSelector >> update [
	self updateMatching.
	self updateSpecificity 
]

{ #category : #updating }
PssSelector >> updateMatching [
	self subclassResponsibility 
]

{ #category : #updating }
PssSelector >> updateSpecificity [
	self subclassResponsibility
]
