Class {
	#name : #PssExamples,
	#superclass : #Object,
	#category : #'PharoStylesheet-Examples'
}

{ #category : #examples }
PssExamples class >> buttons [

	^ PssParser
		parse:
			'
	BlButton { 
		background-color : green600;
		box-shadow: 0px 1px 5px rgba(grey500,0.5);
		border-radius : 3px;
		color : white;
		font-size: 12px;
	}
	BlButton:hovered{
		background-color : green500;
		box-shadow: 0px 1px 6px rgba(grey500,0.8);
	}
	BlButton:pressed{
		background-color : green400;
	}
	BlButton .ripple{
		transition : background-color 100ms linearColor;
		transition : radius 100ms linear;
		background-color : rgba(grey300, 0);
		radius : 5%;
	}
	
	
	'
]

{ #category : #examples }
PssExamples class >> example1 [
	(PssParser 
		parse:'
.foo.bar:hovered > .bar:focused, BlButton.blue .text, .box { 
	opacity: 0.50;
	background-color : rgba(grey500, 0.5);
	transition: width 2s linear;
	font-family: "Arial";
	font-size: 12pt;
	color: #333333 !important;
	padding: 10px 10px 10px 10px;
	width: 100%;
 }

.foo.bar:hovered > .bar:focused, BlButton.blue .text, .box { 

	background-color : grey500;
	transition: background-color 2s linear;
	font-family: "Arial";
	font-size: 12pt;
	color: #333333 !important;
	padding: 10px 10px 10px 10px;
	width: 100px;
 }

') inspect
]

{ #category : #examples }
PssExamples class >> example2 [
	(PssParser  
		parse:'
.foo.bar:hovered > .bar:focused, BlButton.blue .text, .box { 
	opacity: 0.50;

 }') inspect
]

{ #category : #examples }
PssExamples class >> example3WithMedia [
	(PssParser
		parse:'
.foo.bar:hovered > .bar:focused, BlButton.blue .text, .box { 
	opacity: 0.50;

 }
@media screen and (min-width : 150px){
	.foo.bar:hovered > .bar:focused, BlButton.blue .text, .box { 
		opacity: 1.0;
	 }

}

') inspect
]

{ #category : #examples }
PssExamples class >> example4 [
	^(PssParser
		parse:'
		
.test { 
	background-color : rgba(grey500, 0.5);
 }

')
]
