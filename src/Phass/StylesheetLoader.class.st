Class {
	#name : #StylesheetLoader,
	#superclass : #StyleGrammar,
	#category : #'Phass-Utils'
}

{ #category : #'grammar value' }
StylesheetLoader >> arrayToken [
	^ super arrayToken
		==>
			[ :nodes | StyleArrayValue value: (nodes parsedValue first collect: [ :item | item value ]) ]
]

{ #category : #'grammar relation' }
StylesheetLoader >> childRelationToken [
	^ super childRelationToken ==> [ :nodes| StyleRelation CHILD ]
]

{ #category : #'grammar selector' }
StylesheetLoader >> classSelectorToken [
	^ super classSelectorToken ==> [ :nodes | nodes inputValue allButFirst asSymbol ]
]

{ #category : #'as yet unclassified' }
StylesheetLoader >> colorClass [
	^ BlMaterialColor
]

{ #category : #'as yet unclassified' }
StylesheetLoader >> convertPropertyName: aString [
	| strParts result |
	strParts := aString substrings: '-'.
	result := strParts first.
	strParts allButFirstDo: [ :str | result := result , str asCamelCase ].
	^ result
]

{ #category : #'as yet unclassified' }
StylesheetLoader >> createSimpleSelector: anItem [
	| theSelector |
	theSelector := StyleSimpleSelector new
		name: anItem first first;
		id: anItem first second;
		yourself.
	theSelector styleClasses addAll: anItem first third.
	theSelector pseudoClasses addAll: anItem second.
	^ theSelector
		update;
		yourself
]

{ #category : #'grammar declaration' }
StylesheetLoader >> declaration [
	^ super declaration
		==>
			[ :nodes | 
			nodes first = #transition
				ifTrue:
					[ StyleTransitionDeclaration new
						property: nodes third value first;
						duration: nodes third value second;
						timingFunction: (nodes third value at: 3 ifAbsent: [ #linear ]);
						delay: (nodes third value at: 4 ifAbsent: [ 0 ]);
						yourself ]
				ifFalse:
					[ StylePropertyDeclaration new
						property: nodes first;
						value: nodes third;
						important: (nodes at: 4) isNotNil;
						yourself ] ]
]

{ #category : #'grammar declaration' }
StylesheetLoader >> declarations [
	^ super declarations ==> [ :nodes | nodes reject: [ :each | each isKindOf: PPToken ] ]
]

{ #category : #'grammar relation' }
StylesheetLoader >> descendantRelationToken [
	^ super descendantRelationToken ==> [ :nodes| StyleRelation DESCENDANT ]
]

{ #category : #'grammar value' }
StylesheetLoader >> floatNumber [
	^ super floatNumber  ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar value' }
StylesheetLoader >> function [
	^ super function
		==> [ :nodes | 
			{nodes first.
			(nodes third reject: [ :item | item = $, ])} ]
]

{ #category : #'grammar value' }
StylesheetLoader >> functionToken [
	^ super functionToken
		==>
			[ :nodes | 
			| val funct args |
			val := nodes parsedValue.
			funct := val first.
			args := val second.
			self perform: ('helper' , funct asCamelCase) asSymbol asMutator with: args ]
]

{ #category : #helper }
StylesheetLoader >> helperRgba: args [
	args first value isColor
		ifTrue: [ ^ StyleColorValue value: (args first value alpha: args last value) ]
]

{ #category : #'grammar value' }
StylesheetLoader >> hexcolorToken [
	^ super hexcolorToken
		==>
			[ :nodes | StyleColorValue value: (self colorClass fromHexString: nodes inputValue allButFirst) ]
]

{ #category : #'grammar selector' }
StylesheetLoader >> idSelectorToken [
	^ super idSelectorToken ==> [ :nodes | nodes inputValue asSymbol ]
]

{ #category : #'grammar value' }
StylesheetLoader >> ident [
	^ super ident ==> [ :nodes | (self convertPropertyName: nodes) asSymbol ]
]

{ #category : #'grammar value' }
StylesheetLoader >> identToken [
	^ super identToken
		==>
			[ :nodes | 
			| val |
			val := nodes parsedValue.
			(self colorClass respondsTo: val)
				ifTrue: [ StyleColorValue value: (self colorClass perform: val) ]
				ifFalse: [ StyleSymbolValue value: val ] ]
]

{ #category : #'grammar value' }
StylesheetLoader >> intNumber [
	^ super intNumber  ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar media' }
StylesheetLoader >> media [
	^ super media
		==>
			[ :nodes | 
			StyleMedia new
				conditions: nodes second first first;
				rules: nodes second third asOrderedCollection;
				yourself ]
]

{ #category : #'grammar media' }
StylesheetLoader >> mediaCondition [
	^ super mediaCondition ==> [ :nodes | nodes second -> (nodes at: 4) ]
]

{ #category : #'grammar media' }
StylesheetLoader >> mediaConditions [
	^ super mediaConditions ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asDictionary ]
]

{ #category : #'grammar media' }
StylesheetLoader >> mediaDefaultTypeWithConditions [
	^ super mediaDefaultTypeWithConditions
		==> [ :nodes | 
			StyleMediaCondition new
				type: #default;
				conditions: nodes;
				yourself ]
]

{ #category : #'grammar media' }
StylesheetLoader >> mediaQuery [
	^ super mediaQuery ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection ]
]

{ #category : #'grammar media' }
StylesheetLoader >> mediaTypeToken [
	^ super mediaTypeToken ==> [ :nodes | nodes asSymbol ]
]

{ #category : #'grammar media' }
StylesheetLoader >> mediaTypeWithConditions [
	^ super mediaTypeWithConditions
		==> [ :nodes | 
			StyleMediaCondition new
				type: nodes first;
				conditions: nodes second second;
				yourself ]
]

{ #category : #'grammar selector' }
StylesheetLoader >> nameSelectorToken [
	^ super nameSelectorToken ==> [ :nodes | nodes inputValue asSymbol ]
]

{ #category : #'grammar value' }
StylesheetLoader >> numberToken [
	^ super numberToken ==> [ :nodes | StyleNumberValue value value: nodes parsedValue ]
]

{ #category : #'grammar value' }
StylesheetLoader >> percentSymbol [
	^ super percentSymbol ==> [ :nodes | 'percent' ]
]

{ #category : #'grammar declaration' }
StylesheetLoader >> propertyToken [
	^ super propertyToken ==> [ :nodes | nodes parsedValue ]
]

{ #category : #'grammar selector' }
StylesheetLoader >> pseudoClassSelectorToken [
	^ super pseudoClassSelectorToken
		==> [ :nodes | BlState fromSymbol: nodes inputValue allButFirst asSymbol ]
]

{ #category : #grammar }
StylesheetLoader >> rule [
	^ super rule
		==> [ :nodes | 
			StyleRule new
				selectors: nodes first;
				declarations: nodes third;
				yourself ]
]

{ #category : #'grammar selector' }
StylesheetLoader >> selector [
	^ super selector
		==>
			[ :nodes | 
			| finalSelector theSelectors theRelations |
			theSelectors := OrderedCollection new.
			theRelations := OrderedCollection new.
			nodes
				withIndexDo:
					[ :item :index | 
					index % 2 = 1
						ifTrue: [ theSelectors add: (self createSimpleSelector: item) ]
						ifFalse: [ theRelations add: item ] ].
			theSelectors size = 1
				ifTrue: [ finalSelector := theSelectors first ]
				ifFalse:
					[ finalSelector := StyleCompoundSelector new
						selectors: theSelectors;
						relationships: theRelations;
						update;
						yourself ].
			finalSelector ]
]

{ #category : #'grammar selector' }
StylesheetLoader >> selectors [
  ^ super selectors ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection   ]
]

{ #category : #'grammar value' }
StylesheetLoader >> string [
	^ super string ==> [ :nodes | nodes second ]
]

{ #category : #'grammar value' }
StylesheetLoader >> stringToken [
	^ super stringToken ==> [ :nodes | StyleStringValue value value: nodes parsedValue ]
]

{ #category : #grammar }
StylesheetLoader >> stylesheet [
	^ super stylesheet
		==> [ :nodes | 
			| ss |
			ss := StyleStylesheet new.
			nodes do: [ :item | item addTo: ss ].
			ss ]
]

{ #category : #'grammar value' }
StylesheetLoader >> typedValue [
	^ super typedValue
		==>
			[ :nodes | 
			StyleValue
				perform: nodes parsedValue second asSymbol asMutator
				with: nodes parsedValue first ]
]
