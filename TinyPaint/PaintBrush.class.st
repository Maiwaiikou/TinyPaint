"
I'm a brush for paint, I can handle multiples shapes in order to draw anything fast. I'm compose with two color, the second one is for the border of some shape. We can edit my width in order to make a big line or point.
"
Class {
	#name : 'PaintBrush',
	#superclass : 'Object',
	#instVars : [
		'color',
		'secondColor',
		'selectedColor',
		'width',
		'shapes',
		'currentShape',
		'picker',
		'announcer'
	],
	#category : 'TinyPaint-Paint',
	#package : 'TinyPaint',
	#tag : 'Paint'
}

{ #category : 'enumerating' }
PaintBrush >> addShape: aSymbol willDo: aBlock [
	shapes at: aSymbol put: aBlock
]

{ #category : 'accessing' }
PaintBrush >> announcer [
	^ announcer ifNil: [ announcer:= Announcer new ].
]

{ #category : 'accessing' }
PaintBrush >> color [

	^ color
]

{ #category : 'accessing' }
PaintBrush >> color: aColor [

	color := aColor
]

{ #category : 'as yet unclassified' }
PaintBrush >> correspondingColorSelected [

	selectedColor = #color
		ifTrue: [ ^ color ].
	^ secondColor 
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
	color := picker color.
	secondColor := Color black.
	selectedColor := #color.
	width := 5.
	self initializeDefaultShapes
]

{ #category : 'initialization' }
PaintBrush >> initializeClickableShapes [

	self addShape: #pipette willDo: [ :canva :anEvent |
		| pipetteColor |
		pipetteColor := canva form colorAt: anEvent position.
		picker setColor: pipetteColor.
		self updateSelectedColor ].
	self addShape: #bucket willDo: [ :canva :anEvent |
		| aPointsList |
		self updateSelectedColor.
		aPointsList := OrderedCollection new.
		self sameColorArround: anEvent position canva: canva in: aPointsList.
		aPointsList do: [ :point | canva form colorAt: point put: color ]
		"oldColor := canva form colorAt: anEvent position.
		canva form mapColor: oldColor to: color" ].
	self addShape: #polygon willDo: [ :canva :aListOfPoint |
		self updateSelectedColor.
		canva
			drawPolygon: aListOfPoint
			color: color
			borderWidth: width
			borderColor: secondColor ].
	self addShape: #text willDo: [ :canva :anEvent |
		| space input text |
		self updateSelectedColor.
		text := ''.
		input := ToTextField new withSaveCapability.
		space := BlSpace new.
		(space root children includes: input) ifFalse: [
			space root addChild: input ].
		input whenLayoutedDoOnce: [
			space extent: input size.
			space resizable: false ].
		space show.
		input
			addEventHandlerOn: ToAlbumSaveRequestedEvent
			do: [ :saveRequested |
				saveRequested accepted: true.
				text := saveRequested editorElement text copy.
				canva
					drawString: text
					from: 1
					to: text size
					at: anEvent position
					font: nil
					color: color.
				self notifyWrittingText.
				space close ].
		input whenCancelRequestedDo: [ :cancelRequested | space close ] ]
]

{ #category : 'initialization' }
PaintBrush >> initializeDefaultShapes [
	
	self initializeClickableShapes.
	self initializeDraggableShapes.
]

{ #category : 'initialization' }
PaintBrush >> initializeDraggableShapes [

	self addShape: #line willDo: [ :canva :aPoint :anEvent |
		self updateSelectedColor.
		canva
			line: aPoint
			to: anEvent position
			width: width
			color: color ].
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
			borderColor: secondColor ].
]

{ #category : 'accessing' }
PaintBrush >> isAllowedShape: aSymbol [
	^ shapes keys anySatisfy: [ :k | k = aSymbol ]
]

{ #category : 'testing' }
PaintBrush >> isDraggableAction: aSymbol [

	(self isAllowedShape: aSymbol) ifFalse: [ ^ false ].
	^ (shapes at: aSymbol) argumentNames includesAll: #( #aPoint #anEvent )
]

{ #category : 'testing' }
PaintBrush >> isMultipleClickableAction: aSymbol [

	(self isAllowedShape: aSymbol) ifFalse: [ ^ false ].
	^ (shapes at: aSymbol) argumentNames includes: #aListOfPoint
]

{ #category : 'as yet unclassified' }
PaintBrush >> nearestPoints: aPoint [

	| pointsList |
	pointsList := OrderedCollection new.
	aPoint x - 1 to: aPoint x + 1 do: [ :i |
		aPoint y - 1 to: aPoint y + 1 do: [ :j | (i >= 0 and: [ j >= 0 ]) ifTrue: [
                pointsList add: i @ j.
            ]. ] ].
	^ pointsList
]

{ #category : 'as yet unclassified' }
PaintBrush >> notifySelectedColorChanged [
	self announcer announce: SelectedColorChangedAnnouncer new.
	
]

{ #category : 'as yet unclassified' }
PaintBrush >> notifyWrittingText [

	self announcer announce: WrittingTextAnnouncer new
]

{ #category : 'accessing' }
PaintBrush >> picker [
	^ picker
]

{ #category : 'as yet unclassified' }
PaintBrush >> sameColorArround: aPoint canva: aCanva in: aCollection [

	| visited |
	self flag: #ToMakeFaster.
	visited := Set new.
	(aCollection includes: aPoint) ifTrue: [ ^ aCollection ].
	aCollection add: aPoint.
	visited add: aPoint.

	(self nearestPoints: aPoint) do: [ :anotherPoint |
		(aCollection includes: anotherPoint) ifFalse: [
			(aCanva form colorAt: anotherPoint) = (aCanva form colorAt: aPoint)
				ifTrue: [
					(visited includes: anotherPoint) ifFalse: [
						self
							sameColorArround: anotherPoint
							canva: aCanva
							in: aCollection.
						visited add: anotherPoint ] ] ] ].
	^ aCollection
]

{ #category : 'accessing' }
PaintBrush >> secondColor [
	^ secondColor
]

{ #category : 'accessing' }
PaintBrush >> secondColor: aColor [
	secondColor := aColor
]

{ #category : 'accessing' }
PaintBrush >> selectedColor [
	^ selectedColor
]

{ #category : 'accessing' }
PaintBrush >> selectedColor: aSymbol [

	selectedColor := aSymbol
]

{ #category : 'as yet unclassified' }
PaintBrush >> updateAction: aBlock shape: aSymbol [
	(self isAllowedShape: aSymbol) ifFalse: [ ^self ].
	shapes at: aSymbol put: aBlock.
]

{ #category : 'accessing' }
PaintBrush >> updateSelectedColor [

	selectedColor = #color ifTrue: [
		color := picker colorWithAlpha.
		] ifFalse:[
	secondColor := picker colorWithAlpha].
	self notifySelectedColorChanged.
]

{ #category : 'accessing' }
PaintBrush >> width [
	^ width
]

{ #category : 'accessing' }
PaintBrush >> width: aNumber [
	width := aNumber
]
