Class {
	#name : #PssStylesheet,
	#superclass : #Object,
	#instVars : [
		'name',
		'file',
		'rules',
		'medias',
		'animations',
		'origin'
	],
	#category : #'PharoStylesheet-Core'
}

{ #category : #'as yet unclassified' }
PssStylesheet class >> fromFile: aFilename [
	^ self new
]

{ #category : #'as yet unclassified' }
PssStylesheet class >> origin: anOrigin [
	^ self new
		origin: anOrigin;
		yourself
]

{ #category : #comparing }
PssStylesheet >> <= aStylesheet [
	^ self origin <= aStylesheet origin
]

{ #category : #comparing }
PssStylesheet >> >= aStylesheet [
	^ self origin >= aStylesheet origin
]

{ #category : #accessing }
PssStylesheet >> animations [
	^ animations
]

{ #category : #accessing }
PssStylesheet >> animations: aCollection [
	aCollection
		do: [ :a | 
			a stylesheet: self.
			self animations add: a ]
]

{ #category : #accessing }
PssStylesheet >> file [
	^ file
]

{ #category : #accessing }
PssStylesheet >> file: anObject [
	file := anObject
]

{ #category : #'as yet unclassified' }
PssStylesheet >> for: aSelectorString style: aBlock [
	| theSelectors theRule |
	theSelectors := PssParser parseSelectors: aSelectorString.
	theRule := PssRule new.
	theRule
		selectors: theSelectors;
		stylesheet: self.
	aBlock value: theRule.
	self rules add: theRule
]

{ #category : #'initialize-release' }
PssStylesheet >> initialize [
	super initialize.
	rules := OrderedCollection new.
	medias := OrderedCollection new.
	animations := OrderedCollection new.
	origin := PssOrigin USER
]

{ #category : #'as yet unclassified' }
PssStylesheet >> matchingMediaRulesFor: aStyleable [
	| matchedRules |
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	self medias do: [ :m |  m rules do: [ :r | 
					r selectors
						detect: [ :s | s matchesStyleable: aStyleable ]
						ifFound: [ :s |  matchedRules add:
									(PssMatchedRule new
										selector: s;
										declarations: r declarations;
										transitions: r transitions;
										conditions: m conditions;
										yourself) ] ] ].
	^ matchedRules
]

{ #category : #'as yet unclassified' }
PssStylesheet >> matchingRulesFor: aStyleable [
	| matchedRules |
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	self rules do: [ :r |  r selectors
				select: [ :s | s matchesStyleable: aStyleable ]
				thenDo: [ :s |  matchedRules add:
							(PssMatchedRule new
								selector: s;
								declarations: r declarations;
								transitions: r transitions;
								yourself) ] ].
	matchedRules addAll: (self matchingMediaRulesFor: aStyleable).
	^ matchedRules
]

{ #category : #accessing }
PssStylesheet >> medias [
	^ medias
]

{ #category : #accessing }
PssStylesheet >> medias: aCollection [
	aCollection
		do: [ :r | 
			r stylesheet: self.
			self medias add: r ]
]

{ #category : #accessing }
PssStylesheet >> name [
	^ name
]

{ #category : #accessing }
PssStylesheet >> name: anObject [
	name := anObject
]

{ #category : #accessing }
PssStylesheet >> origin [
	^ origin
]

{ #category : #accessing }
PssStylesheet >> origin: anObject [
	origin := anObject
]

{ #category : #accessing }
PssStylesheet >> rules [
	^ rules
]

{ #category : #accessing }
PssStylesheet >> rules: aCollection [
	aCollection
		do: [ :r | 
			r stylesheet: self.
			self rules add: r ]
]
