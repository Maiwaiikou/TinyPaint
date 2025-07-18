Class {
	#name : 'PaintLayersMenu',
	#superclass : 'BlElement',
	#instVars : [
		'layers',
		'selectedLayer'
	],
	#category : 'TinyPaint-Paint',
	#package : 'TinyPaint',
	#tag : 'Paint'
}

{ #category : 'accessing' }
PaintLayersMenu >> addLayer: aCanva [

	layers add: aCanva.
	self addNewLayerElement: aCanva.
]

{ #category : 'accessing' }
PaintLayersMenu >> addNewLayerElement: aCanva [

	| layerElement |
	layerElement := PaintLayersElement new
		                canva: aCanva;
		                name:
			                'Layer ' , (self indexOfLayer: aCanva) asString.
	layerElement constraintsDo: [ :c | c horizontal matchParent ].
	layerElement
		addEventFilterOn: BlClickEvent
		do: [ selectedLayer := aCanva ].
	self addChild: layerElement
]

{ #category : 'accessing' }
PaintLayersMenu >> createLayers [

	| buttonNewLayer newCanva |
	self removeChildren.
	buttonNewLayer := PaintLayersElement new
		                  name: 'New Layer';
		                  iconButton: PaintLayersElement addingIcon;
		                  actionIcon: [  ].
	buttonNewLayer removeChild: (buttonNewLayer children last).
	buttonNewLayer addEventHandlerOn: BlClickEvent do: [ :anEvent |
		newCanva := FormCanvas extent: 505 @ 800.
		newCanva fillColor: Color transparent.
		self addLayer: newCanva ].
	self addChild: buttonNewLayer.
	layers do: [ :layer | self addNewLayerElement: layer ]
]

{ #category : 'accessing' }
PaintLayersMenu >> indexOfLayer: aLayer [

	layers withIndexDo: [ :layer :ind | layer = aLayer ifTrue: [ ^ ind ] ].
	^ 0
]

{ #category : 'initialization' }
PaintLayersMenu >> initialize [

	super initialize.
	layers := OrderedCollection new.
	self background: (Color black alpha: 0.08).
	self layout: BlLinearLayout new.
	self layout beVertical.
	self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ].
	self createLayers.
]

{ #category : 'accessing' }
PaintLayersMenu >> layers [
	^ layers
]

{ #category : 'accessing' }
PaintLayersMenu >> layers: anOrderedCollection [

	layers := anOrderedCollection.
	self createLayers
]

{ #category : 'accessing' }
PaintLayersMenu >> removeLayer: aCanva [

	layers remove: aCanva ifAbsent: [  ].
	self updateLayersName.
]

{ #category : 'accessing' }
PaintLayersMenu >> selectedLayer [
	^ selectedLayer
]

{ #category : 'as yet unclassified' }
PaintLayersMenu >> updateLayersName [
	| childrenCopy |
	childrenCopy := children copy.
	childrenCopy removeAt: 1.
	childrenCopy do: [ :layer | layer name:
			                'Layer ' , (self indexOfLayer: layer canva) asString. ].

	
]
