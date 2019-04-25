Class {
	#name : #PssParser,
	#superclass : #PssGrammar,
	#category : #'PharoStylesheet-Parser'
}

{ #category : #'grammar value' }
PssParser >> arrayToken [
	^ super arrayToken
		==>
			[ :nodes | PssArrayValue value: nodes ]
]

{ #category : #'grammar relation' }
PssParser >> childRelationToken [
	^ super childRelationToken ==> [ :nodes| PssRelation CHILD ]
]

{ #category : #'grammar selector' }
PssParser >> classSelectorToken [
	^ super classSelectorToken ==> [ :nodes | nodes parsedValue second ]
]

{ #category : #'as yet unclassified' }
PssParser >> convertPropertyName: aString [
	| strParts result |
	strParts := aString substrings: '-'.
	result := strParts first.
	strParts allButFirstDo: [ :str | result := result , str asCamelCase ].
	^ result
]

{ #category : #'as yet unclassified' }
PssParser >> createSimpleSelector: anItem [
	| theSelector |
	theSelector := PssSimpleSelector new
		name: anItem first first;
		id: anItem first second;
		yourself.
	theSelector styleClasses addAll: anItem first third.
	theSelector pseudoClasses: anItem second asDictionary.
	^ theSelector
		update;
		yourself
]

{ #category : #'grammar declaration' }
PssParser >> declaration [
	^ super declaration
		==>
			[ :nodes | 
			nodes first = #transition
				ifTrue:
					[ PssTransitionDeclaration new
						property: nodes third value first;
						duration: nodes third value second;
						timingFunction: (nodes third value at: 3 ifAbsent: [ #linear ]);
						delay: (nodes third value at: 4 ifAbsent: [ 0 ]);
						yourself ]
				ifFalse:
					[ PssPropertyDeclaration new
						property: nodes first;
						value: nodes third;
						important: (nodes at: 4) isNotNil;
						yourself ] ]
]

{ #category : #'grammar declaration' }
PssParser >> declarations [
	^ super declarations ==> [ :nodes | nodes reject: [ :each | each isKindOf: PPToken ] ]
]

{ #category : #'grammar relation' }
PssParser >> descendantRelationToken [
	^ super descendantRelationToken ==> [ :nodes| PssRelation DESCENDANT ]
]

{ #category : #primitives }
PssParser >> float [
	^ super float  ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar value' }
PssParser >> function [
	^ super function
		==> 
			[ :nodes | | funct args |
			funct := nodes first.
			args := nodes third reject: [ :node | node = $, ].
			(PssFunctionValue value: funct) args: args ]
]

{ #category : #primitives }
PssParser >> hexColor3 [
	^ super hexColor3 
		==> 
			[ :nodes | | string | 
			string := String new.
			nodes second do: [ :hex | string := string, hex asString, hex asString ].
			string ]
]

{ #category : #primitives }
PssParser >> hexColor6 [
	^ super hexColor6
		==> 
			[ :nodes | nodes second ]
]

{ #category : #'as yet unclassified' }
PssParser >> hexColorToken [
	^ super hexColorToken
		==> 
			[ :nodes | PssColorValue value: (Color fromHexString: nodes parsedValue) ]
]

{ #category : #'grammar selector' }
PssParser >> idSelectorToken [
	^ super idSelectorToken ==> [ :nodes | nodes inputValue allButFirst asSymbol  ]
]

{ #category : #primitives }
PssParser >> ident [
	^ super ident
		==>
			[ :nodes | | strParts val |
			"Convert as camel case"
			strParts := nodes substrings: '-'.
			val := strParts first.
			strParts allButFirstDo: [ :str | val := val, str asCamelCase ].
			val asSymbol]
]

{ #category : #'grammar value' }
PssParser >> identToken [
	^ super identToken
		==>
			[ :nodes | | val |
			val := nodes parsedValue.
			(Color respondsTo: val)
				ifTrue: [ PssColorValue value: (Color perform: val) ]
				ifFalse: [ PssSymbolValue value: val ] ]
]

{ #category : #primitives }
PssParser >> integer [
	^ super integer  ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar value' }
PssParser >> listToken [
	^ super listToken
		==>
			[ :nodes | | collection | 
			collection := OrderedCollection with: nodes first.
			collection addAll: (nodes second collect: [ :array | array second]).
			PssArrayValue value: collection asArray ]
]

{ #category : #'grammar media' }
PssParser >> media [
	^ super media
		==>
			[ :nodes | 
			PssMedia new
				conditions: nodes second first first;
				rules: nodes second third asOrderedCollection;
				yourself ]
]

{ #category : #'grammar media' }
PssParser >> mediaCondition [
	^ super mediaCondition ==> [ :nodes | nodes second -> (nodes at: 4) ]
]

{ #category : #'grammar media' }
PssParser >> mediaConditions [
	^ super mediaConditions ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asDictionary ]
]

{ #category : #'grammar media' }
PssParser >> mediaDefaultTypeWithConditions [
	^ super mediaDefaultTypeWithConditions
		==> [ :nodes | 
			PssMediaCondition new
				type: #default;
				conditions: nodes;
				yourself ]
]

{ #category : #'grammar media' }
PssParser >> mediaQuery [
	^ super mediaQuery ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection ]
]

{ #category : #'grammar media' }
PssParser >> mediaTypeToken [
	^ super mediaTypeToken ==> [ :nodes | nodes asSymbol ]
]

{ #category : #'grammar media' }
PssParser >> mediaTypeWithConditions [
	^ super mediaTypeWithConditions
		==> [ :nodes | 
			PssMediaCondition new
				type: nodes first;
				conditions: nodes second second;
				yourself ]
]

{ #category : #'grammar selector' }
PssParser >> nameSelectorToken [
	^ super nameSelectorToken ==> [ :nodes | nodes inputValue asSymbol ]
]

{ #category : #'grammar value' }
PssParser >> numberToken [
	^ super numberToken ==> [ :nodes | PssNumberValue value value: nodes parsedValue ]
]

{ #category : #primitives }
PssParser >> percentSymbol [
	^ super percentSymbol ==> [ :nodes | 'percent' ]
]

{ #category : #'grammar declaration' }
PssParser >> propertyToken [
	^ super propertyToken ==> [ :nodes | nodes parsedValue ]
]

{ #category : #'grammar selector' }
PssParser >> pseudoClassSelectorToken [
	^ super pseudoClassSelectorToken
		==> [ :nodes | | key value |
				key := nodes second.
				value := nodes third ifNotNil: [ :o | o second ].
				(key -> value)
			 ]
]

{ #category : #grammar }
PssParser >> rule [
	^ super rule
		==> [ :nodes | | collection |
			collection := nodes third ifNil: [ OrderedCollection new ].
			PssRule new
				selectors: nodes first;
				declarations: collection;
				yourself ]
]

{ #category : #'grammar selector' }
PssParser >> selector [
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
					[ finalSelector := PssCompoundSelector new
						selectors: theSelectors;
						relationships: theRelations;
						update;
						yourself ].
			finalSelector ]
]

{ #category : #'grammar selector' }
PssParser >> selectors [
  ^ super selectors ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection   ]
]

{ #category : #'grammar value' }
PssParser >> stringToken [
	^ super stringToken ==> [ :nodes | PssStringValue value: nodes parsedValue second ]
]

{ #category : #grammar }
PssParser >> stylesheet [
	^ super stylesheet
		==> [ :nodes | 
			| ss |
			ss := PssStylesheet new.
			nodes do: [ :item | item addTo: ss ].
			ss ]
]

{ #category : #'grammar value' }
PssParser >> typedValue [
	^ super typedValue
		==>
			[ :nodes | 
			PssValue
				perform: nodes parsedValue second asSymbol asMutator
				with: nodes parsedValue first ]
]
