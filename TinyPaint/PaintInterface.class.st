Class {
	#name : 'PaintInterface',
	#superclass : 'BlSpace',
	#instVars : [
		'canvas',
		'parametersContainer',
		'brush',
		'background',
		'pointList'
	],
	#category : 'TinyPaint-Paint',
	#package : 'TinyPaint',
	#tag : 'Paint'
}

{ #category : 'accessing' }
PaintInterface >> background [
	^ background
]

{ #category : 'accessing' }
PaintInterface >> background: aBackgroundPaint [

	background := aBackgroundPaint
]

{ #category : 'accessing' }
PaintInterface >> canvas [

	^ canvas
]

{ #category : 'initialization' }
PaintInterface >> defaultBackground [

	^ Color white
]

{ #category : 'initialization' }
PaintInterface >> initialize [

	super initialize.
	self title: 'Paint'.
	background := self defaultBackground.
	brush := PaintBrush new.
	pointList := OrderedCollection new.
	self initializeEventsBrush.
	self initializeCanvas.
	self initializeParametersContainer.
	self root background: canvas form.
	self extent:
		canvas extent x @ (canvas extent y + parametersContainer extent y).
	self resizable: false.
	self show
]

{ #category : 'initialization' }
PaintInterface >> initializeCanvas [

	canvas := FormCanvas extent: 505 @ 800.
	canvas fillColor: background.
	self initializeCanvasEvents
]

{ #category : 'initialization' }
PaintInterface >> initializeCanvasEvents [

	self initializeClickableEvents.
	self initializeDraggableEvents.
]

{ #category : 'initialization' }
PaintInterface >> initializeClickableEvents [

	self root addEventHandlerOn: BlClickEvent do: [ :evt |
		evt consume.
		evt position y > parametersContainer extent y ifTrue: [
			(brush isMultipleClickableAction: brush currentShape)
				ifTrue: [
					pointList add: evt position.
					brush doAction value: canvas value: pointList.
					pointList size > 1 ifTrue: [
						(self isNear: pointList last from: pointList first) ifTrue: [
							pointList removeAll ] ] ]
				ifFalse: [
					pointList removeAll.
					(brush isDraggableAction: brush currentShape) ifFalse: [
						brush doAction value: canvas value: evt ] ] ].
		self refreshCanva ]
]

{ #category : 'initialization' }
PaintInterface >> initializeDraggableEvents [

	| lastPoint |
	self root addEventHandlerOn: BlDragStartEvent do: [ :evt |
		evt consume.
		pointList removeAll.
		lastPoint := evt position ].
	self root addEventHandlerOn: BlDragEvent do: [ :evt |
		(brush isDraggableAction: brush currentShape) ifTrue: [
			brush doAction value: canvas value: lastPoint value: evt ].
		self refreshCanva.
		lastPoint := evt position ]
]

{ #category : 'initialization' }
PaintInterface >> initializeEventsBrush [
	brush announcer when: WrittingTextAnnouncer send: #refreshCanva  to: self. 
	self root addEventHandlerOn: BlMouseWheelEvent do: [ :evt |
		evt consume.
		evt isScrollDown
			ifTrue: [ brush decreaseWidth ]
			ifFalse: [ brush increaseWidth ] ]
]

{ #category : 'initialization' }
PaintInterface >> initializeParametersContainer [

	parametersContainer := PaintBoxParameters new
		                       brush: brush;
		                       colorCanva: background.
	self root addChild: parametersContainer
]

{ #category : 'initialization' }
PaintInterface >> isNear: aPoint from: anotherPoint [
	^ (aPoint x between: anotherPoint x - 10 and: anotherPoint x + 10)
		  and:
		  (aPoint y between: anotherPoint y - 10 and: anotherPoint y + 10)
]

{ #category : 'accessing' }
PaintInterface >> parametersContainer [
	^ parametersContainer
]

{ #category : 'as yet unclassified' }
PaintInterface >> refreshCanva [
	self invalidateAll.
	self hostSpaceDo: [ :hs |
		(hs renderer instVarNamed: #aeCanvas) resetFormCaches ]
]
