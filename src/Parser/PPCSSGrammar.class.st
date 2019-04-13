Class {
	#name : #PPCSSGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'parentRelation',
		'orRelationToken',
		'childRelationToken',
		'descendantRelationToken',
		'selectors',
		'selector',
		'nameSelectorToken',
		'idSelectorToken',
		'classSelectorToken',
		'pseudoClassSelectorToken',
		'propertyToken',
		'propertyValue',
		'declarations',
		'declaration',
		'numberToken',
		'percentToken',
		'lengthToken',
		'stringToken',
		'identToken',
		'hexcolorToken',
		'number',
		'string',
		'ident',
		'hexcolor',
		'rule',
		'fontSize',
		'fontSizeToken',
		'intNumber',
		'floatNumber',
		'array',
		'arrayToken',
		'baseValue',
		'typedValue',
		'percentSymbol',
		'baseClassSelector',
		'baseIdSelector',
		'baseNameSelector',
		'importantIdent',
		'durationToken',
		'stylesheet',
		'function',
		'functionToken',
		'media',
		'mediaCondition',
		'mediaTypeToken',
		'mediaPropertyToken',
		'mediaQuery',
		'mediaAndToken',
		'mediaSeparatorToken',
		'mediaConditions',
		'mediaTypeWithConditions'
	],
	#category : #PetitCSS
}

{ #category : #'as yet unclassified' }
PPCSSGrammar class >> parseSelectors: anObject [
	^ self parse: anObject startingAt: #startSelectors
]

{ #category : #'grammar value' }
PPCSSGrammar >> array [
	^ (baseValue min: 2) separatedBy: #space asParser
]

{ #category : #'grammar value' }
PPCSSGrammar >> arrayToken [
	^   array token
]

{ #category : #'grammar selector' }
PPCSSGrammar >> baseClassSelector [
	^ nameSelectorToken optional , idSelectorToken optional , classSelectorToken plus
]

{ #category : #'grammar selector' }
PPCSSGrammar >> baseIdSelector [
	^ nameSelectorToken optional, idSelectorToken , classSelectorToken star
]

{ #category : #'grammar selector' }
PPCSSGrammar >> baseNameSelector [
	^ nameSelectorToken, idSelectorToken optional, classSelectorToken star
]

{ #category : #'grammar value' }
PPCSSGrammar >> baseValue [
	^ (typedValue / numberToken / functionToken / stringToken / identToken / hexcolorToken ) trim
]

{ #category : #'grammar relation' }
PPCSSGrammar >> childRelationToken [
	^ $> asParser trim token
]

{ #category : #'grammar selector' }
PPCSSGrammar >> classSelectorToken [
	^ ($. asParser , ident) token
]

{ #category : #'grammar declaration' }
PPCSSGrammar >> declaration [
  ^ (propertyToken , $: asParser trim , propertyValue, importantIdent optional) trim
]

{ #category : #'grammar declaration' }
PPCSSGrammar >> declarations [
	^ declaration delimitedBy: $; asParser trim token
]

{ #category : #'grammar relation' }
PPCSSGrammar >> descendantRelationToken [
	^ #space asParser token
]

{ #category : #'grammar value' }
PPCSSGrammar >> durationToken [
	^ (number , ('s' asParser / 'ms' asParser)) token
]

{ #category : #'grammar value' }
PPCSSGrammar >> floatNumber [
	^ ($- asParser optional , ($0 asParser / #digit asParser plus)
		, ($. asParser , ($0 asParser / #digit asParser plus))) flatten
]

{ #category : #'grammar value' }
PPCSSGrammar >> fontSize [
	^ (intNumber , 'pt' asParser) / (number , 'em' asParser) / (number , 'rem' asParser)
]

{ #category : #'grammar value' }
PPCSSGrammar >> fontSizeToken [
	^ fontSize token
]

{ #category : #'grammar value' }
PPCSSGrammar >> function [
	^ ident , $( asParser , (baseValue separatedBy: $, asParser) , $) asParser
]

{ #category : #'grammar value' }
PPCSSGrammar >> functionToken [
	^ function token
]

{ #category : #'grammar value' }
PPCSSGrammar >> hexcolor [
	^ $# asParser , (#word asParser times: 6) flatten
]

{ #category : #'grammar value' }
PPCSSGrammar >> hexcolorToken [
	^ hexcolor token
]

{ #category : #'grammar selector' }
PPCSSGrammar >> idSelectorToken [
	^ ($# asParser , #word asParser plus) token
]

{ #category : #'grammar value' }
PPCSSGrammar >> ident [
	^ (#word asParser / $- asParser) plus flatten
]

{ #category : #'grammar value' }
PPCSSGrammar >> identToken [
	^ ident token
]

{ #category : #'grammar declaration' }
PPCSSGrammar >> importantIdent [
	^ ($! asParser trim , 'important' asParser) flatten
]

{ #category : #'grammar value' }
PPCSSGrammar >> intNumber [
	^ ($- asParser optional , ($0 asParser / #digit asParser plus)) flatten
]

{ #category : #'grammar value' }
PPCSSGrammar >> lengthToken [
	^ (intNumber , 'px' asParser) token
]

{ #category : #'grammar media' }
PPCSSGrammar >> media [
	^ '@media' asParser trim , ((mediaQuery separatedBy: mediaSeparatorToken) , ${ asParser trim , rule star , $} asParser) trim
]

{ #category : #'grammar media' }
PPCSSGrammar >> mediaAndToken [
	^ 'and' asParser trim token
]

{ #category : #'grammar media' }
PPCSSGrammar >> mediaCondition [
	^ $( asParser trim , mediaPropertyToken , $: asParser trim , propertyValue optional , $) asParser trim
]

{ #category : #'grammar media' }
PPCSSGrammar >> mediaConditions [
	^ mediaCondition separatedBy: mediaAndToken
]

{ #category : #'grammar media' }
PPCSSGrammar >> mediaPropertyToken [
	^ propertyToken
]

{ #category : #'grammar media' }
PPCSSGrammar >> mediaQuery [
	^ mediaConditions / mediaTypeWithConditions separatedBy: mediaSeparatorToken
]

{ #category : #'grammar media' }
PPCSSGrammar >> mediaSeparatorToken [
	^ $, asParser trim token
]

{ #category : #'grammar media' }
PPCSSGrammar >> mediaTypeToken [
	^ propertyToken 
]

{ #category : #'grammar media' }
PPCSSGrammar >> mediaTypeWithConditions [
	^ mediaTypeToken , (mediaAndToken , mediaConditions) optional
]

{ #category : #'grammar selector' }
PPCSSGrammar >> nameSelectorToken [
	^ (#uppercase asParser , #word asParser star) token
]

{ #category : #'grammar value' }
PPCSSGrammar >> number [
	^ (floatNumber / intNumber ) trim
]

{ #category : #'grammar value' }
PPCSSGrammar >> numberToken [
	^ number token
]

{ #category : #'grammar relation' }
PPCSSGrammar >> orRelationToken [
	^ $, asParser trim token
]

{ #category : #'grammar relation' }
PPCSSGrammar >> parentRelation [
	^ childRelationToken / descendantRelationToken
]

{ #category : #'grammar value' }
PPCSSGrammar >> percentSymbol [
	^   '%' asParser
]

{ #category : #'grammar value' }
PPCSSGrammar >> percentToken [
	^ (intNumber , percentSymbol) token
]

{ #category : #'grammar declaration' }
PPCSSGrammar >> propertyToken [
	^ ident token
]

{ #category : #'grammar value' }
PPCSSGrammar >> propertyValue [
	^   (arrayToken / baseValue) trim
]

{ #category : #'grammar selector' }
PPCSSGrammar >> pseudoClassSelectorToken [
	^ ($: asParser , #word asParser plus) token
]

{ #category : #grammar }
PPCSSGrammar >> root [
  ^ rule plus
]

{ #category : #grammar }
PPCSSGrammar >> rule [
 ^ (selectors, ${ asParser trim , declarations optional , $} asParser) trim
]

{ #category : #'grammar selector' }
PPCSSGrammar >> selector [
	^ baseClassSelector / baseIdSelector / baseNameSelector , pseudoClassSelectorToken star separatedBy: parentRelation
]

{ #category : #'grammar selector' }
PPCSSGrammar >> selectors [
  ^ selector separatedBy:orRelationToken
]

{ #category : #grammar }
PPCSSGrammar >> start [
	^ stylesheet end
]

{ #category : #grammar }
PPCSSGrammar >> startSelectors [
	^ selectors end
]

{ #category : #'grammar value' }
PPCSSGrammar >> string [
	^ $" asParser , #word asParser star flatten , $" asParser
]

{ #category : #'grammar value' }
PPCSSGrammar >> stringToken [
	^ string token
]

{ #category : #grammar }
PPCSSGrammar >> stylesheet [
	^ (rule / media) plus
]

{ #category : #'grammar value' }
PPCSSGrammar >> typedValue [
	^ percentToken / lengthToken / fontSizeToken / durationToken
]
