Class {
	#name : #PssGrammar,
	#superclass : #PPCompositeParser,
	#instVars : [
		'stylesheet',
		'declarations',
		'declaration',
		'rule',
		'ident',
		'integer',
		'float',
		'number',
		'quotesString',
		'doubleQuotesString',
		'hexColor3',
		'hexColor6',
		'comment',
		'function',
		'identToken',
		'numberToken',
		'stringToken',
		'hexColorToken',
		'atKeywordToken',
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
		'functionArgs',
		'arrayToken',
		'listToken',
		'baseValue',
		'percentToken',
		'lengthToken',
		'fontSizeToken',
		'typedValue',
		'baseClassSelector',
		'baseIdSelector',
		'baseNameSelector',
		'importantIdent',
		'durationToken',
		'media',
		'mediaCondition',
		'mediaTypeToken',
		'mediaPropertyToken',
		'mediaQuery',
		'mediaAndToken',
		'mediaSeparatorToken',
		'mediaConditions',
		'mediaTypeWithConditions',
		'percentSymbol',
		'keyframes',
		'keyframesSelector',
		'fromToken',
		'toToken',
		'keyframe',
		'percentValue'
	],
	#category : #'PharoStylesheet-Parser'
}

{ #category : #'as yet unclassified' }
PssGrammar class >> parseSelectors: anObject [
	^ self parse: anObject startingAt: #startSelectors
]

{ #category : #tokens }
PssGrammar >> arrayToken [
	^ baseValue min: 2
]

{ #category : #tokens }
PssGrammar >> atKeywordToken [
	^ ($@ asParser , ident) token trim
]

{ #category : #'grammar selector' }
PssGrammar >> baseClassSelector [
	^ nameSelectorToken optional , idSelectorToken optional , classSelectorToken plus
]

{ #category : #'grammar selector' }
PssGrammar >> baseIdSelector [
	^ nameSelectorToken optional, idSelectorToken , classSelectorToken star
]

{ #category : #'grammar selector' }
PssGrammar >> baseNameSelector [
	^ nameSelectorToken, idSelectorToken optional, classSelectorToken star
]

{ #category : #'grammar value' }
PssGrammar >> baseValue [
	^ (typedValue / numberToken / function / stringToken / identToken / hexColorToken ) trim
]

{ #category : #'grammar relation' }
PssGrammar >> childRelationToken [
	^ $> asParser trim token
]

{ #category : #'grammar selector' }
PssGrammar >> classSelectorToken [
	^ ($. asParser , ident) token
]

{ #category : #primitives }
PssGrammar >> comment [
	^ '/*' asParser , PPPredicateObjectParser any , '*/' asParser
]

{ #category : #'grammar declaration' }
PssGrammar >> declaration [
  ^ identToken, $: asParser trim, propertyValue, importantIdent optional
]

{ #category : #'grammar declaration' }
PssGrammar >> declarations [
	^ declaration delimitedBy: $; asParser trim token
]

{ #category : #'grammar relation' }
PssGrammar >> descendantRelationToken [
	^ #space asParser token
]

{ #category : #primitives }
PssGrammar >> doubleQuotesString [
	^ $" asParser , (PPPredicateObjectParser anyExceptAnyOf: '"') star flatten , $" asParser
]

{ #category : #tokens }
PssGrammar >> durationToken [
	^ (number , ('s' asParser / 'ms' asParser)) token
]

{ #category : #primitives }
PssGrammar >> float [
	^ ($- asParser optional , ($0 asParser / #digit asParser plus)
		, ($. asParser , ($0 asParser / #digit asParser plus))) flatten
]

{ #category : #tokens }
PssGrammar >> fontSizeToken [
	^ ((integer , 'pt' asParser) / (number , 'em' asParser) / (number , 'rem' asParser)) token
]

{ #category : #tokens }
PssGrammar >> fromToken [
	^ 'from' asParser token
]

{ #category : #'grammar value' }
PssGrammar >> function [
	^ ident, $( asParser , (functionArgs separatedBy: $, asParser) , $) asParser
]

{ #category : #'grammar value' }
PssGrammar >> functionArgs [
	^ arrayToken / baseValue
]

{ #category : #primitives }
PssGrammar >> hexColor3 [
	^ $# asParser , (PPPredicateObjectParser hex times: 3)
]

{ #category : #primitives }
PssGrammar >> hexColor6 [
	^ $# asParser , (PPPredicateObjectParser hex times: 6) flatten.
]

{ #category : #tokens }
PssGrammar >> hexColorToken [
	^ (hexColor6 / hexColor3) token
]

{ #category : #'grammar selector' }
PssGrammar >> idSelectorToken [
	^ ($# asParser , #word asParser plus) token
]

{ #category : #primitives }
PssGrammar >> ident [
	^ ($- asParser optional, #letter asParser, ($- asParser / #word asParser) star) flatten
]

{ #category : #tokens }
PssGrammar >> identToken [
	^ ident token
]

{ #category : #'grammar declaration' }
PssGrammar >> importantIdent [
	^ ($! asParser trim , 'important' asParser) flatten
]

{ #category : #primitives }
PssGrammar >> integer [
	^ ($- asParser optional , ($0 asParser / #digit asParser plus)) flatten
]

{ #category : #'grammar keyframes' }
PssGrammar >> keyframe [
	^ keyframesSelector trim, ${ asParser, declarations trim, $} asParser trim
]

{ #category : #'grammar keyframes' }
PssGrammar >> keyframes [
	^ '@keyframes' asParser trim , identToken, (${ asParser, keyframe plus, $} asParser) trim
]

{ #category : #'grammar keyframes' }
PssGrammar >> keyframesSelector [
	^ percentValue / fromToken / toToken
]

{ #category : #tokens }
PssGrammar >> lengthToken [
	^ (number , 'px' asParser) token
]

{ #category : #tokens }
PssGrammar >> listToken [
	^ baseValue trim, ($, asParser trim, baseValue trim) plus
]

{ #category : #'grammar media' }
PssGrammar >> media [
	^ '@media' asParser trim , ((mediaQuery separatedBy: mediaSeparatorToken) , ${ asParser trim , rule star , $} asParser) trim
]

{ #category : #'grammar media' }
PssGrammar >> mediaAndToken [
	^ 'and' asParser trim token
]

{ #category : #'grammar media' }
PssGrammar >> mediaCondition [
	^ $( asParser trim , mediaPropertyToken , $: asParser trim , propertyValue optional , $) asParser trim
]

{ #category : #'grammar media' }
PssGrammar >> mediaConditions [
	^ mediaCondition separatedBy: mediaAndToken
]

{ #category : #'grammar media' }
PssGrammar >> mediaPropertyToken [
	^ propertyToken
]

{ #category : #'grammar media' }
PssGrammar >> mediaQuery [
	^ mediaConditions / mediaTypeWithConditions separatedBy: mediaSeparatorToken
]

{ #category : #'grammar media' }
PssGrammar >> mediaSeparatorToken [
	^ $, asParser trim token
]

{ #category : #'grammar media' }
PssGrammar >> mediaTypeToken [
	^ propertyToken 
]

{ #category : #'grammar media' }
PssGrammar >> mediaTypeWithConditions [
	^ mediaTypeToken , (mediaAndToken , mediaConditions) optional
]

{ #category : #'grammar selector' }
PssGrammar >> nameSelectorToken [
	^ (#word asParser plus / $* asParser) token
	
]

{ #category : #primitives }
PssGrammar >> number [
	^ float / integer
]

{ #category : #tokens }
PssGrammar >> numberToken [
	^ number token
]

{ #category : #'grammar relation' }
PssGrammar >> orRelationToken [
	^ $, asParser trim token
]

{ #category : #'grammar relation' }
PssGrammar >> parentRelation [
	^ childRelationToken / descendantRelationToken
]

{ #category : #primitives }
PssGrammar >> percentSymbol [
	^ '%' asParser
]

{ #category : #tokens }
PssGrammar >> percentToken [
	^ percentValue token
]

{ #category : #tokens }
PssGrammar >> percentValue [
	^ integer , percentSymbol
]

{ #category : #'grammar declaration' }
PssGrammar >> propertyToken [
	^ ident token
]

{ #category : #'grammar value' }
PssGrammar >> propertyValue [
	^ listToken / arrayToken / baseValue
]

{ #category : #'grammar selector' }
PssGrammar >> pseudoClassSelectorToken [
	^ $: asParser, ident, ($( asParser, (integer / ident), $) asParser) optional
]

{ #category : #primitives }
PssGrammar >> quotesString [
	^ $' asParser , PPPredicateObjectParser any star , $' asParser
]

{ #category : #grammar }
PssGrammar >> root [
  ^ rule plus
]

{ #category : #grammar }
PssGrammar >> rule [
 ^ (selectors, ${ asParser trim , declarations optional , $} asParser) trim
]

{ #category : #'grammar selector' }
PssGrammar >> selector [
	^ baseClassSelector / baseIdSelector / baseNameSelector , pseudoClassSelectorToken star separatedBy: parentRelation
]

{ #category : #'grammar selector' }
PssGrammar >> selectors [
  ^ selector separatedBy:orRelationToken
]

{ #category : #grammar }
PssGrammar >> start [
	^ stylesheet end
]

{ #category : #grammar }
PssGrammar >> startSelectors [
	^ selectors end
]

{ #category : #tokens }
PssGrammar >> stringToken [
	^ (quotesString / doubleQuotesString) token
]

{ #category : #grammar }
PssGrammar >> stylesheet [
	^ (rule / media / keyframes) plus
]

{ #category : #tokens }
PssGrammar >> toToken [
	^ 'to' asParser token
]

{ #category : #'grammar value' }
PssGrammar >> typedValue [
	^ percentToken / lengthToken / fontSizeToken / durationToken
]
