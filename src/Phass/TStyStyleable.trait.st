Trait {
	#name : #TStyStyleable,
	#category : #'Phass-Core'
}

{ #category : #accessing }
TStyStyleable >> pseudoClasses [
	^ self explicitRequirement
]

{ #category : #accessing }
TStyStyleable >> styleClasses [
	^ self explicitRequirement
]

{ #category : #accessing }
TStyStyleable >> styleId [
	^ self explicitRequirement
]

{ #category : #accessing }
TStyStyleable >> styleName [
	^ self explicitRequirement
]
