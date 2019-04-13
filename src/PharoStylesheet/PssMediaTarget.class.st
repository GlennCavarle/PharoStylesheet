Class {
	#name : #PssMediaTarget,
	#superclass : #Object,
	#category : #'PharoStylesheet-Core'
}

{ #category : #'as yet unclassified' }
PssMediaTarget class >> defaultOn: aTarget [
	^ aTarget
]

{ #category : #'as yet unclassified' }
PssMediaTarget class >> screenOn: aTarget [
	^ aTarget space root
]
