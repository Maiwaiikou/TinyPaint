Class {
	#name : 'PaintLayersElement',
	#superclass : 'BlElement',
	#instVars : [
		'visibleButton',
		'name',
		'canva',
		'isVisibleElement'
	],
	#category : 'TinyPaint-Paint',
	#package : 'TinyPaint',
	#tag : 'Paint'
}

{ #category : 'as yet unclassified' }
PaintLayersElement class >> notVisibleIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/2767/2767146.png')
		   scaledToSize: 20 @ 20) asElement
]

{ #category : 'as yet unclassified' }
PaintLayersElement class >> visibleIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/58/58554.png')
		   scaledToSize: 20 @ 20) asElement
]

{ #category : 'testing' }
PaintLayersElement >> canva [
	^ canva
]

{ #category : 'testing' }
PaintLayersElement >> canva: aCanva [
	canva := aCanva
]

{ #category : 'accessing' }
PaintLayersElement >> correspondingIcon [

	visibleButton removeChildren.
	isVisibleElement
		ifTrue: [ visibleButton addChild: self class visibleIcon ]
		ifFalse: [ visibleButton addChild: self class notVisibleIcon ]
	"visibleButton addChild: (isVisible
			 ifTrue: [ self class visibleIcon ]
			 ifFalse: [ self class notVisibleIcon ])"
]

{ #category : 'accessing' }
PaintLayersElement >> initialize [

	super initialize.
	self background: (Color black alpha: 0.5).
	self border: (BlBorder paint: Color black width: 1).
	isVisibleElement := true.
	self layout: BlLinearLayout new.
	self layout beHorizontal.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self initializeVisibleButton.
	self initializeName
]

{ #category : 'accessing' }
PaintLayersElement >> initializeName [

	name := BlTextElement new.
	name constraintsDo: [ :c | c margin: (BlInsets all: 5) ].
	name text: 'Initial text' asRopedText.
	self addChild: name
]

{ #category : 'accessing' }
PaintLayersElement >> initializeVisibleButton [

	visibleButton := BlElement new.
	self correspondingIcon.
	visibleButton border: (BlBorder paint: Color blue width: 1).
	visibleButton extent: 20 @ 20.

	visibleButton addEventFilterOn: BlClickEvent do: [ :anEvent |
		self switchVisible.].
	self addChild: visibleButton
]

{ #category : 'accessing' }
PaintLayersElement >> isVisibleElement [
	^ isVisibleElement
]

{ #category : 'testing' }
PaintLayersElement >> isVisibleElement: aBoolean [

	isVisibleElement := aBoolean.
	self correspondingIcon
]

{ #category : 'accessing' }
PaintLayersElement >> name [
 ^ name
]

{ #category : 'accessing' }
PaintLayersElement >> name: aString [

	name text: aString asRopedText
]

{ #category : 'as yet unclassified' }
PaintLayersElement >> switchVisible [

	isVisibleElement := isVisibleElement
		             ifTrue: [ false ]
		             ifFalse: [ true ].
	self correspondingIcon
]
