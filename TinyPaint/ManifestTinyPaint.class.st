"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestTinyPaint',
	#superclass : 'PackageManifest',
	#category : 'TinyPaint-Manifest',
	#package : 'TinyPaint',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestTinyPaint class >> ruleTempsReadBeforeWrittenRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#PaintInterface #initializeCanvasEvents #false)) #'2025-07-09T14:45:29.161509+02:00') )
]
