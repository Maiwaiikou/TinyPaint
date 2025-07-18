Class {
	#name : 'PaintLayersElement',
	#superclass : 'BlElement',
	#instVars : [
		'iconButton',
		'name',
		'canva',
		'actionIcon',
		'isVisibleElement'
	],
	#category : 'TinyPaint-Paint',
	#package : 'TinyPaint',
	#tag : 'Paint'
}

{ #category : 'as yet unclassified' }
PaintLayersElement class >> addingIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/5610/5610959.png')
		   scaledToSize: self defaultSizeIcon) asElement
]

{ #category : 'as yet unclassified' }
PaintLayersElement class >> binIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/5028/5028066.png')
		   scaledToSize: self defaultSizeIcon) asElement
]

{ #category : 'as yet unclassified' }
PaintLayersElement class >> defaultSizeIcon [
	^ 20@20.
]

{ #category : 'as yet unclassified' }
PaintLayersElement class >> notVisibleIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/2767/2767146.png')
		   scaledToSize: self defaultSizeIcon) asElement
]

{ #category : 'as yet unclassified' }
PaintLayersElement class >> visibleIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/58/58554.png')
		   scaledToSize: self defaultSizeIcon) asElement
]

{ #category : 'accessing' }
PaintLayersElement >> actionIcon [

	^ actionIcon 
]

{ #category : 'accessing' }
PaintLayersElement >> actionIcon: aBlock [

	actionIcon := aBlock
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

	iconButton removeChildren.
	iconButton addChild: (isVisibleElement
			 ifTrue: [ self class visibleIcon ]
			 ifFalse: [ self class notVisibleIcon ]).
]

{ #category : 'accessing' }
PaintLayersElement >> iconButton [
	^ iconButton
]

{ #category : 'accessing' }
PaintLayersElement >> iconButton: anImage [
	iconButton removeChildren.
	iconButton addChild: anImage
]

{ #category : 'initialization' }
PaintLayersElement >> initialize [

	super initialize.
	self background: Color veryVeryLightGray.
	self border: (BlBorder paint: Color veryLightGray width: 1).
	isVisibleElement := true.
	actionIcon := [ self switchVisible ].
	self layout: BlFrameLayout new.
	"self layout: BlLinearLayout new.
	self layout beHorizontal."
	self constraintsDo: [ :c | c horizontal fitContent ].
	self height: 25.
	self initializeVisibleButton.
	self initializeName.
	self initializeRemoveButton
]

{ #category : 'accessing' }
PaintLayersElement >> initializeName [

	name := BlTextElement new.
	name constraintsDo: [ :c |
		c margin: (BlInsets
				 top: 8
				 right: 30
				 bottom: 3
				 left: 30).

		c frame horizontal alignCenter.
		c frame vertical alignCenter ].
	name text: 'Initial text' asRopedText.
	self addChild: name
]

{ #category : 'accessing' }
PaintLayersElement >> initializeRemoveButton [

	| removeButton |
	removeButton := BlElement new.
	removeButton size: self class defaultSizeIcon.
	removeButton addChild: self class binIcon.
	removeButton constraintsDo: [ :c |
		c margin: (BlInsets right: 3).
		c frame horizontal alignRight.
		c frame vertical alignCenter ].
	removeButton addEventFilterOn: BlClickEvent do: [ :anEvent |
		| saveParent |
		saveParent := self parent.
		self removeFromParent.
		saveParent removeLayer: canva.
		saveParent selectedLayer = self canva ifTrue: [
			saveParent selectedLayer: nil.
			saveParent switchLayer ] ].
	self addChild: removeButton
]

{ #category : 'accessing' }
PaintLayersElement >> initializeVisibleButton [

	iconButton := BlElement new.
	self correspondingIcon.
	iconButton size: self class defaultSizeIcon.
	iconButton constraintsDo: [ :c | c margin: (BlInsets left: 3). c frame horizontal alignLeft. c frame vertical alignCenter ].
	iconButton
		addEventFilterOn: BlClickEvent
		do: [ :anEvent | actionIcon value ].
	self addChild: iconButton
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
	self correspondingIcon.
]
