# TinyPaint

This project is a version of Paint but in Pharo and using Bloc, Toplo and Coypul elements.

## Open the project

```Smalltalk
PaintInterface new open
```

## BUG REPORTED

Rectangle and circle size is defined by 0@0 extent: our position in drag and drop for an unknown reason (Must be to find) so I need to check it.
Fill bucket is long when it's a large amount of pixel, we need a mapColor: aListOfPoint to: newColor such as the mapColor in FormCanvas which do it for each pixel from a color to a new color.
Layers aren't finish yet so it still buggy.
