Class {
	#name : #Stylesheet,
	#superclass : #Object,
	#instVars : [
		'name',
		'file',
		'rules',
		'medias',
		'origin'
	],
	#category : #'Phass-CSS'
}

{ #category : #'as yet unclassified' }
Stylesheet class >> origin: anOrigin [
	^ self new
		origin: anOrigin;
		yourself
]

{ #category : #comparing }
Stylesheet >> <= aStylesheet [
	^ self origin <= aStylesheet origin
]

{ #category : #comparing }
Stylesheet >> >= aStylesheet [
	^ self origin >= aStylesheet origin
]

{ #category : #accessing }
Stylesheet >> file [
	^ file
]

{ #category : #accessing }
Stylesheet >> file: anObject [
	file := anObject
]

{ #category : #'as yet unclassified' }
Stylesheet >> for: aSelectorString style: aBlock [
	| theSelectors theRule |
	theSelectors := StylesheetLoader parseSelectors: aSelectorString.
	theRule := StyleRule new.
	theRule
		selectors: theSelectors;
		stylesheet: self.
	aBlock value: theRule.
	self rules add: theRule
]

{ #category : #'initialize-release' }
Stylesheet >> initialize [
	super initialize.
	rules := OrderedCollection new.
	medias := OrderedCollection new.
	origin := StyleOrigin USER
]

{ #category : #'as yet unclassified' }
Stylesheet >> matchingMediaRulesFor: aStyleable [
	| matchedRules |
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	self medias do: [ :m |  m rules do: [ :r | 
					r selectors
						detect: [ :s | s matchesStyleable: aStyleable ]
						ifFound: [ :s |  matchedRules add:
									(BlMatchedRule new
										selector: s;
										declarations: r declarations;
										transitions: r transitions;
										conditions: m conditions;
										yourself) ] ] ].
	^ matchedRules
]

{ #category : #'as yet unclassified' }
Stylesheet >> matchingRulesFor: aStyleable [
	| matchedRules |
	matchedRules := SortedCollection sortBlock: [ :r1 :r2 | r1 specificity <= r2 specificity ].
	self rules do: [ :r |  r selectors
				select: [ :s | s matchesStyleable: aStyleable ]
				thenDo: [ :s |  matchedRules add:
							(BlMatchedRule new
								selector: s;
								declarations: r declarations;
								transitions: r transitions;
								yourself) ] ].
	matchedRules addAll: (self matchingMediaRulesFor: aStyleable).
	^ matchedRules
]

{ #category : #accessing }
Stylesheet >> medias [
	^ medias
]

{ #category : #accessing }
Stylesheet >> medias: aCollection [
	aCollection
		do: [ :r | 
			r stylesheet: self.
			self medias add: r ]
]

{ #category : #accessing }
Stylesheet >> name [
	^ name
]

{ #category : #accessing }
Stylesheet >> name: anObject [
	name := anObject
]

{ #category : #accessing }
Stylesheet >> origin [
	^ origin
]

{ #category : #accessing }
Stylesheet >> origin: anObject [
	origin := anObject
]

{ #category : #accessing }
Stylesheet >> rules [
	^ rules
]

{ #category : #accessing }
Stylesheet >> rules: aCollection [
	aCollection
		do: [ :r | 
			r stylesheet: self.
			self rules add: r ]
]
