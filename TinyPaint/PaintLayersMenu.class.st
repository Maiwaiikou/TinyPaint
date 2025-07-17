Class {
	#name : 'PaintLayersMenu',
	#superclass : 'BlElement',
	#instVars : [
		'layersContainers',
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
	self updateLayersContainers: aCanva.
]

{ #category : 'accessing' }
PaintLayersMenu >> createLayers [
	layersContainers removeChildren.
	layers do: [ :layer | self updateLayersContainers:layer ].
]

{ #category : 'accessing' }
PaintLayersMenu >> indexOfLayer: aLayer [
	layers withIndexDo: [ :ind :layer | layer = aLayer ifTrue: [ ^ ind ] ].
	^ 0
]

{ #category : 'initialization' }
PaintLayersMenu >> initialize [

	super initialize.
	layers := OrderedCollection new.
	self background: (Color black alpha: 0.08).
	self initializeLayersContainers.
	"self constraintsDo: [ :c |
		c horizontal fitContent.
		c vertical fitContent ]."
]

{ #category : 'initialization' }
PaintLayersMenu >> initializeLayersContainers [

	layersContainers := BlElement new.
	layersContainers layout: BlLinearLayout new.
	layersContainers layout beVertical.
	layersContainers minExtent: 500 @ 500.
	self addChild: layersContainers
]

{ #category : 'accessing' }
PaintLayersMenu >> layers [
	^ layers
]

{ #category : 'accessing' }
PaintLayersMenu >> layers: aCollection [

	layers := aCollection.
	self createLayers.
]

{ #category : 'as yet unclassified' }
PaintLayersMenu >> layersContainers [

	^ layersContainers
]

{ #category : 'accessing' }
PaintLayersMenu >> selectedLayer [
	^ selectedLayer
]

{ #category : 'accessing' }
PaintLayersMenu >> updateLayersContainers: aNewLayer [
	|layerElement|
	layerElement := PaintLayersElement new canva: aNewLayer; name: ('Layer ', (self indexOfLayer:aNewLayer) asString ).
	layersContainers addChild: layerElement.

	
]
