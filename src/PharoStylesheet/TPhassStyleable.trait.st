Trait {
	#name : #TPhassStyleable,
	#category : #'PharoStylesheet-Core'
}

{ #category : #accessing }
TPhassStyleable >> parent [
	^ self explicitRequirement
]

{ #category : #accessing }
TPhassStyleable >> pseudoClasses [
	^ self explicitRequirement
]

{ #category : #accessing }
TPhassStyleable >> styleClasses [
	^ self explicitRequirement
]

{ #category : #accessing }
TPhassStyleable >> styleId [
	^ self explicitRequirement
]

{ #category : #accessing }
TPhassStyleable >> styleName [
	^ self explicitRequirement
]
