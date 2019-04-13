Class {
	#name : #StyleMediaTarget,
	#superclass : #Object,
	#category : #'Phass-CSS'
}

{ #category : #'as yet unclassified' }
StyleMediaTarget class >> defaultOn: aTarget [
	^ aTarget
]

{ #category : #'as yet unclassified' }
StyleMediaTarget class >> screenOn: aTarget [
	^ aTarget space root
]
