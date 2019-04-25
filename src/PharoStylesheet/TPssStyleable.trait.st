Trait {
	#name : #TPssStyleable,
	#category : #'PharoStylesheet-Core'
}

{ #category : #accessing }
TPssStyleable >> parent [
	^ self explicitRequirement
]

{ #category : #accessing }
TPssStyleable >> pseudoClasses [
	^ self explicitRequirement
]

{ #category : #accessing }
TPssStyleable >> styleClasses [
	^ self explicitRequirement
]

{ #category : #accessing }
TPssStyleable >> styleId [
	^ self explicitRequirement
]

{ #category : #accessing }
TPssStyleable >> styleName [
	^ self explicitRequirement
]
