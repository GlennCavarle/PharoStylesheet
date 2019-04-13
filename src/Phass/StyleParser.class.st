Class {
	#name : #StyleParser,
	#superclass : #StyleGrammar,
	#category : #'Phass-Parser'
}

{ #category : #'grammar value' }
StyleParser >> arrayToken [
	^ super arrayToken ==> [ :nodes | nodes parsedValue first  ]
]

{ #category : #'grammar relation' }
StyleParser >> childRelationToken [
	^ super childRelationToken ==> [ :nodes| #CHILD ]
]

{ #category : #'grammar selector' }
StyleParser >> classSelectorToken [
	^ super classSelectorToken ==> [ :nodes | nodes inputValue allButFirst asSymbol ]
]

{ #category : #'as yet unclassified' }
StyleParser >> colorClass [
	^ Color
	
]

{ #category : #'as yet unclassified' }
StyleParser >> convertPropertyName: aString [
	| strParts result |
	strParts := aString substrings: '-'.
	result := strParts first.
	strParts allButFirstDo: [ :str | result := result , str asCamelCase ].
	^ result
]

{ #category : #'grammar declaration' }
StyleParser >> declaration [
	^ super declaration ==> [ :nodes | nodes first -> nodes third ]
]

{ #category : #'grammar declaration' }
StyleParser >> declarations [
	^ super declarations ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asDictionary ]
]

{ #category : #'grammar relation' }
StyleParser >> descendantRelationToken [
	^ super descendantRelationToken ==> [ :nodes| #DESCENDANT ]
]

{ #category : #'grammar value' }
StyleParser >> floatNumber [
	^ super floatNumber trim ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar value' }
StyleParser >> hexcolorToken [
	^ super hexcolorToken ==> [ :nodes | self colorClass fromHexString: nodes inputValue allButFirst]
]

{ #category : #'grammar selector' }
StyleParser >> idSelectorToken [
	^ super idSelectorToken ==> [ :nodes | nodes inputValue asSymbol ]
]

{ #category : #'grammar value' }
StyleParser >> ident [
	^ super ident ==> [ :nodes | (self convertPropertyName: nodes) asSymbol ]
]

{ #category : #'grammar value' }
StyleParser >> identToken [
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
StyleParser >> intNumber [
	^ super intNumber trim ==> [ :nodes | Number readFrom: nodes ]
]

{ #category : #'grammar media' }
StyleParser >> media [
	^ super media
		==>
			[ :nodes | 
			{(#media -> (nodes second first reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection).
			(#rules -> nodes second third)} asDictionary ]
]

{ #category : #'grammar media' }
StyleParser >> mediaCondition [
	^ super mediaCondition ==> [ :nodes | nodes second -> (nodes at: 4) ]
]

{ #category : #'grammar media' }
StyleParser >> mediaConditions [
	^ super mediaConditions ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asDictionary ]
]

{ #category : #'grammar media' }
StyleParser >> mediaQuery [
	^ super mediaQuery ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection ]
]

{ #category : #'grammar media' }
StyleParser >> mediaTypeWithConditions [
	^ super mediaTypeWithConditions
		==> [ :nodes | 
			nodes second second
				at: nodes first put: nil;
				yourself ]
]

{ #category : #'grammar selector' }
StyleParser >> nameSelectorToken [
	^ super nameSelectorToken ==> [ :nodes | nodes inputValue asSymbol ]
]

{ #category : #'grammar value' }
StyleParser >> numberToken [
	^ super numberToken  ==> [ :nodes |  nodes parsedValue ]
]

{ #category : #'grammar value' }
StyleParser >> percentSymbol [
	^ super percentSymbol ==> [ :nodes | 'percent' ]
]

{ #category : #'grammar declaration' }
StyleParser >> propertyToken [
	^ super propertyToken ==> [ :nodes | nodes parsedValue ]
]

{ #category : #'grammar selector' }
StyleParser >> pseudoClassSelectorToken [
	^ super pseudoClassSelectorToken ==> [ :nodes | nodes inputValue allButFirst asSymbol ]
]

{ #category : #grammar }
StyleParser >> rule [
	^ super rule
		==> [ :nodes | 
			Dictionary new
				at: #selectors put: nodes first;
				at: #declarations put: nodes third;
				yourself ]
]

{ #category : #'grammar selector' }
StyleParser >> selector [
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
StyleParser >> selectors [
  ^ super selectors ==> [ :nodes | (nodes reject: [ :each | each isKindOf: PPToken ]) asOrderedCollection   ]
]

{ #category : #'grammar value' }
StyleParser >> string [
	^ super string ==> [ :nodes | nodes second ]
]

{ #category : #'grammar value' }
StyleParser >> stringToken [
	^ super stringToken ==> [ :nodes | nodes inputValue ]
]

{ #category : #'grammar value' }
StyleParser >> typedValue [
	^ super typedValue
		==> [ :nodes | 
			{nodes parsedValue first.
			nodes parsedValue second asSymbol} ]
]
