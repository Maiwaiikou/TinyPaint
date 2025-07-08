Class {
	#name : 'PaintInterface',
	#superclass : 'BlSpace',
	#instVars : [
		'canvas',
		'parametersContainer',
		'brush',
		'background'
	],
	#category : 'TinyPaint',
	#package : 'TinyPaint'
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
	self initializeEventsBrush.
	self initializeCanvas.
	self initializeParametersContainer.
	self root background: canvas form.
	self extent:
		canvas extent x @ (canvas extent y + parametersContainer size y).
	self resizable: false.
	self show
]

{ #category : 'initialization' }
PaintInterface >> initializeCanvas [

	| lastPoint |
	canvas := FormCanvas extent: 500 @ 800.
	canvas fillColor: background.

	self root addEventHandlerOn: BlClickEvent do: [ :evt |
		evt consume.
		(brush isDraggableAction: brush currentShape) ifFalse: [
			brush doAction value: canvas value: evt ] ].
	self root addEventHandlerOn: BlDragStartEvent do: [ :evt |
		evt consume.
		lastPoint := evt position ].
	self root addEventHandlerOn: BlDragEvent do: [ :evt |
		(brush isDraggableAction: brush currentShape) ifTrue: [
			brush doAction value: canvas value: lastPoint value: evt ].
		self invalidateAll.
		self hostSpaceDo: [ :hs |
			(hs renderer instVarNamed: #aeCanvas) resetFormCaches ].
		lastPoint := evt position ]
]

{ #category : 'initialization' }
PaintInterface >> initializeEventsBrush [

	self root addEventHandlerOn: BlMouseWheelEvent do: [ :evt |
		evt consume.
		evt isScrollDown
			ifTrue: [
				brush decreaseWidth.]
			ifFalse: [
				brush increaseWidth.] ]
]

{ #category : 'initialization' }
PaintInterface >> initializeParametersContainer [

	parametersContainer := PaintBoxParameters new
		                       brush: brush;
		                       colorCanva: background.
	self root addChild: parametersContainer
]

{ #category : 'accessing' }
PaintInterface >> parametersContainer [
	^ parametersContainer
]
