Class {
	#name : #PssSimpleSelector,
	#superclass : #PssSelector,
	#instVars : [
		'name',
		'styleClasses',
		'id',
		'pseudoClasses',
		'idCount',
		'styleClassCount',
		'nameCount',
		'pseudoClassCount'
	],
	#category : #'PharoStylesheet-Core'
}

{ #category : #testing }
PssSimpleSelector >> = aSelector [
	^ (aSelector isSimpleSelector) and:[
		((self name = aSelector name 
		and: [ self id = aSelector id ]) 
		and: [ self pseudoClasses = aSelector pseudoClasses ])
		and: [ self styleClasses = aSelector styleClasses ]]
]

{ #category : #accessing }
PssSimpleSelector >> id [
	^ id
]

{ #category : #accessing }
PssSimpleSelector >> id: anObject [
	id := anObject
]

{ #category : #accessing }
PssSimpleSelector >> idCount [
	^ idCount
]

{ #category : #accessing }
PssSimpleSelector >> initialize [
	super initialize.
	pseudoClasses := Dictionary new.
	styleClasses := OrderedCollection new
]

{ #category : #testing }
PssSimpleSelector >> isSimpleSelector [
	^ true
]

{ #category : #testing }
PssSimpleSelector >> matchesPseudoClasseState: aPseudoClassState [
	| found |
	pseudoClasses keysAndValuesDo: [ :sKey :sValue |
		found := false.
		aPseudoClassState
			select: [ :cAssociation | cAssociation key = sKey ]
			thenDo: [ :cAssociation | | cValue | 
				sValue 
					ifNil: [ found := true ]
					ifNotNil: [ 
						cValue := cAssociation value.	
						(sValue respondsTo: cValue)
							ifTrue: [ (sValue perform: cValue) ifTrue: [ found := true ] ]
							ifFalse: [ found := cValue = sValue ]
					].
			].
		found ifFalse: [ ^ false ]
	].
	^ true
]

{ #category : #testing }
PssSimpleSelector >> matchesStyleClasses: aStyleClassList [
	^ aStyleClassList includesAll: styleClasses
]

{ #category : #testing }
PssSimpleSelector >> matchesStyleable: aStyleable [
	self matchesOnName
		ifTrue: [ (self nameMatches: aStyleable styleName) ifFalse: [ ^ false ] ].
	self matchesOnId
		ifTrue: [self id = aStyleable styleId ifFalse: [ ^ false ] ].
	self matchesOnStyleClass
		ifTrue:[(self matchesStyleClasses: aStyleable styleClasses ) ifFalse: [ ^ false ] ].
	^ self matchesPseudoClasseState: aStyleable pseudoClasses
]

{ #category : #testing }
PssSimpleSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList [
	^ self
		matchesStyleable: aStyleable
		pseudoClassStates: aPseudoClassStateList
		selectorIndex: aPseudoClassStateList size
]

{ #category : #testing }
PssSimpleSelector >> matchesStyleable: aStyleable pseudoClassStates: aPseudoClassStateList selectorIndex: aSelectorIndex [
	(self matchesStyleable: aStyleable)
		ifFalse: [ ^ false ].
	aPseudoClassStateList
		ifNotEmpty:
			[ :c | (self matchesPseudoClasseState: (c last))
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #accessing }
PssSimpleSelector >> name [
	^ name
]

{ #category : #accessing }
PssSimpleSelector >> name: anObject [
	name := anObject
]

{ #category : #accessing }
PssSimpleSelector >> nameCount [
	^ nameCount
]

{ #category : #testing }
PssSimpleSelector >> nameMatches: aClassName [
	matchOnName
		ifFalse: [ ^ false ].
	^ name = aClassName
]

{ #category : #printing }
PssSimpleSelector >> printOn: aStream [
	self name ifNotNil: [ :n | aStream nextPutAll: n ].
	self id ifNotNil: [ :i | aStream nextPutAll: i ].
	self styleClasses
		ifNotEmpty: [ :cls | 
			aStream
				nextPut: $.;
				nextPutAll: (cls joinUsing: '.') ].
	self pseudoClasses
		keysAndValuesDo: [ :k :v | 
			aStream
				nextPut: $:;
				nextPutAll: k.
			v ifNotNil: [ 
				aStream 
					nextPut: $(;
					nextPutAll: v printString;
					nextPut: $) ] ]
]

{ #category : #accessing }
PssSimpleSelector >> pseudoClassCount [
	^ pseudoClassCount
]

{ #category : #accessing }
PssSimpleSelector >> pseudoClasses [
	^ pseudoClasses
]

{ #category : #accessing }
PssSimpleSelector >> pseudoClasses: anObject [
	pseudoClasses := anObject
]

{ #category : #accessing }
PssSimpleSelector >> styleClassCount [
	^ styleClassCount
]

{ #category : #accessing }
PssSimpleSelector >> styleClasses [
	^ styleClasses
]

{ #category : #accessing }
PssSimpleSelector >> styleClasses: anObject [
	styleClasses := anObject
]

{ #category : #updating }
PssSimpleSelector >> updateMatching [
	matchOnId := id isNotNil and: [ id isNotEmpty ].
	matchOnName := name isNotNil and: [ name isNotEmpty and: [ (name = '*') not ] ].
	matchOnStyleClass := styleClasses isNotEmpty.
]

{ #category : #updating }
PssSimpleSelector >> updateSpecificity [
	idCount := self matchesOnId asBit.
	styleClassCount := self styleClasses size.
	pseudoClassCount := self pseudoClasses size.
	nameCount := self matchesOnName asBit.
	specificity := idCount << 8 | (pseudoClassCount << 4) | styleClassCount | nameCount
]
