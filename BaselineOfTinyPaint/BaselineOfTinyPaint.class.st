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
		spec
			baseline: 'Bloc'
			with: [ spec repository: 'github://pharo-graphics/Bloc:v2.4.0/src' ].
		spec
			package: 'TinyPaint'
			with: [ spec requires: #( 'Bloc' ) ].
			]
]
