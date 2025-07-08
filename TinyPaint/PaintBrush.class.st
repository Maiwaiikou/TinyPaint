Class {
	#name : 'PaintBrush',
	#superclass : 'Object',
	#instVars : [
		'color',
		'secondColor',
		'width',
		'shapes',
		'currentShape',
		'picker'
	],
	#category : 'TinyPaint',
	#package : 'TinyPaint'
}

{ #category : 'enumerating' }
PaintBrush >> addShape: aSymbol willDo: aBlock [
	shapes at: aSymbol put: aBlock
]

{ #category : 'accessing' }
PaintBrush >> color [

	^ color
]

{ #category : 'accessing' }
PaintBrush >> color: aColor [

	color := aColor
]

{ #category : 'accessing' }
PaintBrush >> currentShape [
	^ currentShape
]

{ #category : 'accessing' }
PaintBrush >> currentShape: aSymbol [
	(self isAllowedShape: aSymbol ) ifFalse: [ ^self ].
	currentShape := aSymbol.
	
]

{ #category : 'as yet unclassified' }
PaintBrush >> decreaseWidth [
	width > 1 ifFalse: [ ^ self ].
	self width: width -1.
]

{ #category : 'as yet unclassified' }
PaintBrush >> doAction [

	^ (shapes at: currentShape)
]

{ #category : 'as yet unclassified' }
PaintBrush >> increaseWidth [

	width < 100 ifFalse: [ ^ self ].
	self width: width + 1
]

{ #category : 'initialization' }
PaintBrush >> initialize [

	super initialize.
	shapes := Dictionary new.
	currentShape := #line.
	picker := BlColorPicker new.
	color := Color black.
	secondColor := Color black.
	width := 5.
	self initializeDefaultShapes
]

{ #category : 'initialization' }
PaintBrush >> initializeDefaultShapes [

	self addShape: #line willDo: [ :canva :aPoint :anEvent |
		self updateSelectedColor.
		canva
			line: aPoint
			to: anEvent position
			width: width
			color: color ].
	self addShape: #pipette willDo: [ :canva :anEvent |
		| pipetteColor |
		pipetteColor := canva form colorAt: anEvent position.
		picker setColor:pipetteColor ].
	self addShape: #rectangle willDo: [ :canva :aPoint :anEvent |
		self updateSelectedColor.
		canva
			drawRectangle: (aPoint extent: anEvent position)
			color: color
			borderWidth: width
			borderColor: secondColor ].
	self addShape: #oval willDo: [ :canva :aPoint :anEvent |
		self updateSelectedColor.
		canva
			drawOval: (aPoint extent: anEvent position)
			color: color
			borderWidth: width
			borderColor: secondColor ]
]

{ #category : 'accessing' }
PaintBrush >> isAllowedShape: aSymbol [
	^ shapes keys anySatisfy: [ :k | k = aSymbol ]
]

{ #category : 'testing' }
PaintBrush >> isDraggableAction: aSymbol [

	(self isAllowedShape: aSymbol) ifFalse: [ ^ false ].
	^ (shapes at: aSymbol) argumentCount >= 3.
]

{ #category : 'accessing' }
PaintBrush >> picker [
	^ picker
]

{ #category : 'accessing' }
PaintBrush >> secondColor [
	^ secondColor
]

{ #category : 'accessing' }
PaintBrush >> secondColor: aColor [
	secondColor := aColor
]

{ #category : 'as yet unclassified' }
PaintBrush >> updateAction: aBlock shape: aSymbol [
	(self isAllowedShape: aSymbol) ifFalse: [ ^self ].
	shapes at: aSymbol put: aBlock.
]

{ #category : 'accessing' }
PaintBrush >> updateSelectedColor [
	color := picker colorWithAlpha.
]

{ #category : 'accessing' }
PaintBrush >> width [
	^ width
]

{ #category : 'accessing' }
PaintBrush >> width: aNumber [
	width := aNumber
]
