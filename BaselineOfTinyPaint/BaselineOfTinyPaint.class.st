Class {
	#name : 'BaselineOfTinyPaint',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfTinyPaint',
	#package : 'BaselineOfTinyPaint'
}

{ #category : 'baselines' }
BaselineOfTinyPaint >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec baseline: 'Toplo' with: [ spec repository: 'github://pharo-graphics/Toplo:v0.6.0/src' ].
		spec package: 'TinyPaint' with: [ spec requires: #( 'Toplo' ) ] ]
]
