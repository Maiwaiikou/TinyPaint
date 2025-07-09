Class {
	#name : 'PaintBoxParameters',
	#superclass : 'BlElement',
	#instVars : [
		'colorsContainer',
		'brushParametersContainer',
		'brush',
		'colorCanva',
		'brushColorContainer'
	],
	#category : 'TinyPaint-Paint',
	#package : 'TinyPaint',
	#tag : 'Paint'
}

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> circleIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/319/319248.png')
		   scaledToSize: self defautIconSize) asElement
]

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> defautIconSize [

	^ 30 @ 30
]

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> ecraserIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/175/175076.png')
		   scaledToSize: self defautIconSize) asElement
]

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> paintBucketIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/1/1729.png')
		   scaledToSize: self defautIconSize) asElement
]

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> penIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/98/98174.png')
		   scaledToSize: self defautIconSize) asElement
]

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> pipetteIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/912/912581.png')
		   scaledToSize: self defautIconSize) asElement
]

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> polygonIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/136/136834.png')
		   scaledToSize: self defautIconSize) asElement
]

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> rainbowIcon [

	^ ((ZnEasy getJpeg:
		    'https://t3.ftcdn.net/jpg/03/82/84/80/360_F_382848035_DJrwRnkhrzyGYQQC1ybzJUMoxiGuKexO.jpg')
		   scaledToSize: self defautIconSize + 10 @ 10) asElement
]

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> rectangleIcon [

	^ ((ZnEasy getPng:
		    'https://cdn-icons-png.flaticon.com/512/1014/1014902.png')
		   scaledToSize: self defautIconSize) asElement
]

{ #category : 'as yet unclassified' }
PaintBoxParameters class >> textInputIcon [

	^ ((ZnEasy getPng:
		    'https://cdn1.iconfinder.com/data/icons/interface-elements-1/24/text-field-512.png')
		   scaledToSize: self defautIconSize) asElement
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
PaintBoxParameters >> addNewParameter: aBlock in: aContainer size: aPoint [

	aContainer addChild: (BlElement new
			 extent: aPoint;
			 geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			 border: (BlBorder paint: Color lightGray width: 1);
			 addEventHandlerOn: BlClickEvent do: aBlock;
			 yourself)
]

{ #category : 'adding' }
PaintBoxParameters >> addNewParameter: aBlock in: aContainer size: aPoint withIcon: icon [

	aContainer addChild: (BlElement new
			 extent: aPoint;
			 geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			background: Color white;
			 border: (BlBorder paint: Color lightGray width: 1);
			 addEventHandlerOn: BlClickEvent do: aBlock;
			 addChild: icon;
			 yourself)
]

{ #category : 'adding' }
PaintBoxParameters >> addNewParameter: aBlock in: aContainer withIcon: icon [

	aContainer addChild: (BlElement new
			 extent: 30 @ 30;
			 geometry: (BlRoundedRectangleGeometry cornerRadius: 3);
			background: Color white;
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

	brush := aPaintBrush.
	self updateBackgroundColorContainer.
	brush announcer when: SelectedColorChangedAnnouncer send: #updateBackgroundColorContainer to: self.
]

{ #category : 'initialization' }
PaintBoxParameters >> brushColorContainer [
	^ brushColorContainer
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
	self layout: BlLinearLayout new.
	self initializeBrushParametersContainer.
	self initializeBrushColorContainer.
	self initializeColorsContainer.
	self background: Color lightOrange.
	self minHeight: 70.
	self constraintsDo: [ :c | c horizontal matchParent. c vertical fitContent ]
]

{ #category : 'initialization' }
PaintBoxParameters >> initializeBrushColorContainer [

	brushColorContainer := BlElement new.
	brushColorContainer layout: BlLinearLayout new.
	brushColorContainer constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self
		addNewParameter: [
			brush selectedColor: #color.
			brush picker setColor: brush correspondingColorSelected ]
		in: brushColorContainer
		size: 30 @ 65.
	self
		addNewParameter: [
			brush selectedColor: #secondColor.
			brush picker setColor: brush correspondingColorSelected ]
		in: brushColorContainer
		size: 30 @ 65.
	brushColorContainer childrenDo: [ :child |
		child constraintsDo: [ :c | c margin: (BlInsets top: 3.5 bottom: 3.5) ] ].
	self addChild: brushColorContainer
]

{ #category : 'initialization' }
PaintBoxParameters >> initializeBrushParametersContainer [

	brushParametersContainer := BlElement new.
	brushParametersContainer layout:
		(BlGridLayout horizontal cellSpacing: 4).
	brushParametersContainer layout columnCount: 6.
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
			brush picker setColor: brush color.
			self updateBackgroundColorContainer ]
		in: brushParametersContainer
		withIcon: self class ecraserIcon.
	self
		addNewParameter: [ brush currentShape: #pipette ]
		in: brushParametersContainer
		withIcon: self class pipetteIcon.
	self
		addNewParameter: [ brush currentShape: #bucket ]
		in: brushParametersContainer
		withIcon: self class paintBucketIcon.
	self
		addNewParameter: [ brush currentShape: #rectangle ]
		in: brushParametersContainer
		withIcon: self class rectangleIcon.
	self
		addNewParameter: [ brush currentShape: #oval ]
		in: brushParametersContainer
		withIcon: self class circleIcon.
	self
		addNewParameter: [ brush currentShape: #polygon ]
		in: brushParametersContainer
		withIcon: self class polygonIcon.
	self
		addNewParameter: [ brush currentShape: #text ]
		in: brushParametersContainer
		withIcon: self class textInputIcon.
	self addChild: brushParametersContainer
]

{ #category : 'initialization' }
PaintBoxParameters >> initializeColorsContainer [

	colorsContainer := BlElement new.
	colorsContainer layout: (BlGridLayout horizontal cellSpacing: 3).
	colorsContainer layout columnCount: 10.
	colorsContainer constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent.
		c frame horizontal alignRight ].
	(Color wheel: 20) withIndexDo: [ :each :index |
		self
			addNewParameter: [
				brush picker setColor: each.
				brush updateSelectedColor ]
			in: colorsContainer.
		colorsContainer children last background: each ].
	self
		addNewParameter: [
			| space |
			space := BlSpace new.
			brush picker setColor: brush correspondingColorSelected.
			(space root children includes: brush picker) ifFalse: [
				space root addChild: brush picker.
				brush picker whenLayoutedDoOnce: [
					space extent: brush picker size.
					space resizable: false ] ].
			space show. ]
		in: colorsContainer
		size: 20 @ 20
		withIcon: self class rainbowIcon.
	self addChild: colorsContainer
]

{ #category : 'as yet unclassified' }
PaintBoxParameters >> updateBackgroundColorContainer [
	brushColorContainer children first background: brush color.
	brushColorContainer children second background: brush secondColor
	
]
