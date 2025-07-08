Class {
	#name : 'PaintBoxParameters',
	#superclass : 'BlElement',
	#instVars : [
		'colorsContainer',
		'brushParametersContainer',
		'brush',
		'colorCanva'
	],
	#category : 'TinyPaint',
	#package : 'TinyPaint'
}

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> circleIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/319/319248.png')
		   scaledToSize: 20 @ 20) asElement
]

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> ecraserIcon [

	^ ((ZnEasy getPng:
		  'https://cdn-icons-png.flaticon.com/512/175/175076.png') scaledToSize: 20 @ 20) asElement
]

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> penIcon [

	^ ((ZnEasy getPng: 'https://cdn-icons-png.flaticon.com/512/98/98174.png')
		   scaledToSize: 20 @ 20) asElement
]

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> pipetteIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/912/912581.png')
		   scaledToSize: 20 @ 20) asElement
]

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> rectangleIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/1014/1014902.png')
		   scaledToSize: 20 @ 20) asElement
]

{ #category : 'adding' }
PaintBoxParameters >> addNewParameter: aBlock in: aContainer [

	aContainer addChild: (BlElement new
			 extent: 20 @ 20;
			 geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			 border: (BlBorder paint: Color lightGray width: 1);
			 addEventHandlerOn: BlClickEvent do:
			aBlock ;
			 yourself)
]

{ #category : 'adding' }
PaintBoxParameters >> addNewParameter: aBlock in: aContainer size: aPoint withIcon: icon [

	aContainer addChild: (BlElement new
			 extent: aPoint;
			 geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			 border: (BlBorder paint: Color lightGray width: 1);
			 addEventHandlerOn: BlClickEvent do: aBlock;
			 addChild: icon;
			 yourself)
]

{ #category : 'adding' }
PaintBoxParameters >> addNewParameter: aBlock in: aContainer withIcon: icon [

	aContainer addChild: (BlElement new
			 extent: 20 @ 20;
			 geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			 border: (BlBorder paint: Color lightGray width: 1);
			 addEventHandlerOn: BlClickEvent do: aBlock;
			addChild: icon;
			 yourself)
]

{ #category : 'accessing' }
PaintBoxParameters >> brush [

	^ brush
]

{ #category : 'accessing' }
PaintBoxParameters >> brush: aPaintBrush [

	brush := aPaintBrush
]

{ #category : 'accessing' }
PaintBoxParameters >> brushParametersContainer [

	^ brushParametersContainer
]

{ #category : 'accessing' }
PaintBoxParameters >> colorCanva [
	^ colorCanva
]

{ #category : 'accessing' }
PaintBoxParameters >> colorCanva: aColor [

	colorCanva := aColor.
]

{ #category : 'accessing' }
PaintBoxParameters >> colorsContainer [
	^ colorsContainer
]

{ #category : 'initialization' }
PaintBoxParameters >> initialize [

	super initialize.
	self layout: BlFrameLayout new.
	self initializeColorsContainer.
	self initializeBrushParametersContainer.
	self background: Color lightOrange.
	self minHeight: 70.
	self constraintsDo: [ :c | c horizontal matchParent ]
]

{ #category : 'initialization' }
PaintBoxParameters >> initializeBrushParametersContainer [
	brushParametersContainer := BlElement new background: Color white.
	brushParametersContainer layout:
		(BlGridLayout horizontal cellSpacing: 3).
	brushParametersContainer layout columnCount: 10.
	brushParametersContainer constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self
		addNewParameter: [ brush currentShape: #line ]
		in: brushParametersContainer
		withIcon: self class penIcon.
	self
		addNewParameter: [
			brush currentShape: #line.
			brush color: self colorCanva.
			brush picker setColor: brush color ]
		in: brushParametersContainer
		withIcon: self class ecraserIcon.
	self
		addNewParameter: [ brush currentShape: #pipette ]
		in: brushParametersContainer
		withIcon: self class pipetteIcon.
	self
		addNewParameter: [ brush currentShape: #rectangle ]
		in: brushParametersContainer
		withIcon: self class rectangleIcon.
	self
		addNewParameter: [ brush currentShape: #oval ]
		in: brushParametersContainer
		withIcon: self class circleIcon.
	self addChild: brushParametersContainer
]

{ #category : 'initialization' }
PaintBoxParameters >> initializeColorsContainer [

	colorsContainer := BlElement new background: Color white.
	colorsContainer layout: (BlGridLayout horizontal cellSpacing: 3).
	colorsContainer layout columnCount: 10.
	colorsContainer constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c frame horizontal alignRight ].
	(Color wheel: 20) withIndexDo: [ :each :index |
		self addNewParameter: [ brush color: each. brush picker setColor: each ] in: colorsContainer.
		colorsContainer children last background: each ].
	self
		addNewParameter: [
			| space |
			space := BlSpace new.
			brush picker setColor: brush color.
			(space root children includes: brush picker) ifFalse: [
				space root addChild: brush picker.
				brush picker whenLayoutedDoOnce: [
					space extent: brush picker size.
					space resizable: false ] ].
			space show ]
		in: colorsContainer.
	colorsContainer children last background: Color transparent.
	self addChild: colorsContainer
]
