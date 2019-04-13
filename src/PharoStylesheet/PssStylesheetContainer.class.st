Class {
	#name : #PssStylesheetContainer,
	#superclass : #OrderedCollection,
	#instVars : [
		'styleable'
	],
	#category : #'PharoStylesheet-Utils'
}

{ #category : #'as yet unclassified' }
PssStylesheetContainer class >> on: aStyleable [
	^ self new
		styleable: aStyleable;
		yourself
]

{ #category : #'adding/removing' }
PssStylesheetContainer >> add: aStylesheet [
	super add: aStylesheet.
	
]

{ #category : #'adding/removing' }
PssStylesheetContainer >> addAll: aCollection [
	super addAll: aCollection.
]

{ #category : #'as yet unclassified' }
PssStylesheetContainer >> computeStyleNodes [
	^ self computeStyleNodesFrom: self styleable
]

{ #category : #'as yet unclassified' }
PssStylesheetContainer >> computeStyleNodesFrom: aNode [
	| aStylesheetList parent |
	aStylesheetList := OrderedCollection new.
	parent := aNode parent.
	[ parent isNotNil ] whileTrue: [ 
		aStylesheetList addAll: parent stylesheets.
		parent := parent parent ].
	^ self computeStyleNodesFrom: aNode stylesheets: aStylesheetList ordinal: 0.
]

{ #category : #'as yet unclassified' }
PssStylesheetContainer >> computeStyleNodesFrom: aStyleable stylesheets: aStylesheetList [
	| rootNode matchedRules |
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	aStylesheetList addAll: aStyleable stylesheets.
	aStylesheetList do: [ :eachStylesheet | matchedRules addAll: (eachStylesheet matchingRulesFor: aStyleable) ].
	rootNode := aStyleable styler.
	matchedRules do: [ :r | 
			rootNode styles addAll: (r computedStyles reject: [ :s | rootNode styles includes: s ]).
			rootNode transitions addAll: (r computedTransitions reject: [ :t | rootNode transitions includes: t ]) ].
	aStyleable isParent ifTrue:[
		aStyleable children do: [ :eachChild | rootNode children add: (self computeStyleNodesFrom: eachChild stylesheets: aStylesheetList) ]].
	^ rootNode
]

{ #category : #'as yet unclassified' }
PssStylesheetContainer >> computeStyleNodesFrom: aStyleable stylesheets: aStylesheetList ordinal: anInteger [
	| rootNode matchedRules ordinal|
	ordinal := anInteger.
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	aStylesheetList addAll: aStyleable stylesheets.
	aStylesheetList do: [ :eachStylesheet | matchedRules addAll: (eachStylesheet matchingRulesFor: aStyleable) ].
	rootNode := aStyleable styler.
	matchedRules do: [ :r | 
			rootNode styles addAll: 
				((r computedStyles do:[:s| s ordinal: (ordinal := ordinal +1) ]) 
					reject: [ :s | rootNode styles includes: s ]).
			rootNode transitions addAll: 
				((r computedTransitions do:[:s| s ordinal: (ordinal := ordinal +1) ])
					reject: [ :t | rootNode transitions includes: t ]) ].
	aStyleable isParent ifTrue:[
		aStyleable children do: [ :eachChild | 
			rootNode children add: 
				(self computeStyleNodesFrom: eachChild stylesheets: aStylesheetList ordinal:ordinal) ]].
	^ rootNode
]

{ #category : #'as yet unclassified' }
PssStylesheetContainer >> initialize [
	super initialize.
	super add: (PssStylesheet origin: PssOrigin USER).
]

{ #category : #'adding/removing' }
PssStylesheetContainer >> remove: aStylesheet [
	super remove: aStylesheet.
]

{ #category : #'adding/removing' }
PssStylesheetContainer >> removeAll [
	super removeAll.
]

{ #category : #'adding/removing' }
PssStylesheetContainer >> removeAll: aCollection [
	super removeAll: aCollection.
]

{ #category : #accessing }
PssStylesheetContainer >> styleable [
	^ styleable
]

{ #category : #accessing }
PssStylesheetContainer >> styleable: anObject [
	styleable := anObject
]

{ #category : #'as yet unclassified' }
PssStylesheetContainer >> userStylesheet [
	^ self first
]
