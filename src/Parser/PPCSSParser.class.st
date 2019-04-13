Class {
	#name : #PPCSSParser,
	#superclass : #PPCSSGrammar,
	#category : #PetitCSS
}

{ #category : #'grammar value' }
PPCSSParser >> arrayToken [
	^ super arrayToken ==> [ :nodes | nodes parsedValue first  ]
]

{ #category : #'grammar relation' }
PPCSSParser >> childRelationToken [
	^ super childRelationToken ==> [ :nodes| #CHILD ]
]

{ #category : #'grammar selector' }
PPCSSParser >> classSelectorToken [
	^ super classSelectorToken ==> [ :nodes | nodes inputValue allButFirst asSymbol ]
]

{ #category : #'as yet unclassified' }
PPCSSParser >> colorClass [
	^ Color
	
]

{ #category : #'as yet unclassified' }
PPCSSParser >> convertPropertyName: aString [
	| strParts result |
	strParts := aString substrings: '-'.
	result := strParts first.
	strParts allButFirstDo: [ :str | result := result , str asCamelCase ].
	^ result
]

{ #category : #'grammar declaration' }
PPCSSParser >> declaration [
	^ super declaration ==> [ :nodes | nodes first -> nodes third ]
]

{ #category : #'grammar declaration' }
PPCSSParser >> declarations [
	^ super declarations ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asDictionary ]
]

{ #category : #'grammar relation' }
PPCSSParser >> descendantRelationToken [
	^ super descendantRelationToken ==> [ :nodes| #DESCENDANT ]
]

{ #category : #'grammar value' }
PPCSSParser >> floatNumber [
	^ super floatNumber trim ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar value' }
PPCSSParser >> hexcolorToken [
	^ super hexcolorToken ==> [ :nodes | self colorClass fromHexString: nodes inputValue allButFirst]
]

{ #category : #'grammar selector' }
PPCSSParser >> idSelectorToken [
	^ super idSelectorToken ==> [ :nodes | nodes inputValue asSymbol ]
]

{ #category : #'grammar value' }
PPCSSParser >> ident [
	^ super ident ==> [ :nodes | (self convertPropertyName: nodes) asSymbol ]
]

{ #category : #'grammar value' }
PPCSSParser >> identToken [
	^ super identToken
		==>
			[ :nodes | 
			| val |
			val := nodes parsedValue.
			(self colorClass respondsTo: val)
				ifTrue: [ self colorClass perform: val ]
				ifFalse: [ val ] ]
]

{ #category : #'grammar value' }
PPCSSParser >> intNumber [
	^ super intNumber trim ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar media' }
PPCSSParser >> media [
	^ super media
		==>
			[ :nodes | 
			{(#media -> (nodes second first reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection).
			(#rules -> nodes second third)} asDictionary ]
]

{ #category : #'grammar media' }
PPCSSParser >> mediaCondition [
	^ super mediaCondition ==> [ :nodes | nodes second -> (nodes at: 4) ]
]

{ #category : #'grammar media' }
PPCSSParser >> mediaConditions [
	^ super mediaConditions ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asDictionary ]
]

{ #category : #'grammar media' }
PPCSSParser >> mediaQuery [
	^ super mediaQuery ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection ]
]

{ #category : #'grammar media' }
PPCSSParser >> mediaTypeWithConditions [
	^ super mediaTypeWithConditions
		==> [ :nodes | 
			nodes second second
				at: nodes first put: nil;
				yourself ]
]

{ #category : #'grammar selector' }
PPCSSParser >> nameSelectorToken [
	^ super nameSelectorToken ==> [ :nodes | nodes inputValue asSymbol ]
]

{ #category : #'grammar value' }
PPCSSParser >> numberToken [
	^ super numberToken  ==> [ :nodes |  nodes parsedValue ]
]

{ #category : #'grammar value' }
PPCSSParser >> percentSymbol [
	^ super percentSymbol ==> [ :nodes | 'percent' ]
]

{ #category : #'grammar declaration' }
PPCSSParser >> propertyToken [
	^ super propertyToken ==> [ :nodes | nodes parsedValue ]
]

{ #category : #'grammar selector' }
PPCSSParser >> pseudoClassSelectorToken [
	^ super pseudoClassSelectorToken ==> [ :nodes | nodes inputValue allButFirst asSymbol ]
]

{ #category : #grammar }
PPCSSParser >> rule [
	^ super rule
		==> [ :nodes | 
			Dictionary new
				at: #selectors put: nodes first;
				at: #declarations put: nodes third;
				yourself ]
]

{ #category : #'grammar selector' }
PPCSSParser >> selector [
	^ super selector
		==>
			[ :nodes | 
			| aSelectorDict |
			aSelectorDict := Dictionary new.
			aSelectorDict at: #selectors put: OrderedCollection new.
			aSelectorDict at: #relationships put: OrderedCollection new.
			nodes
				withIndexDo:
					[ :item :index | 
					index % 2 = 1
						ifTrue:
							[ (aSelectorDict at: #selectors)
								add:
									{(#name -> item first first).
									(#id -> item first second).
									(#classes -> item first third).
									(#pseudo -> item second)} asDictionary ]
						ifFalse: [ (aSelectorDict at: #relationships) add: item ] ].
			aSelectorDict ]
]

{ #category : #'grammar selector' }
PPCSSParser >> selectors [
  ^ super selectors ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection   ]
]

{ #category : #'grammar value' }
PPCSSParser >> string [
	^ super string ==> [ :nodes | nodes second ]
]

{ #category : #'grammar value' }
PPCSSParser >> stringToken [
	^ super stringToken ==> [ :nodes | nodes inputValue ]
]

{ #category : #'grammar value' }
PPCSSParser >> typedValue [
	^ super typedValue
		==> [ :nodes | 
			{nodes parsedValue first.
			nodes parsedValue second asSymbol} ]
]
