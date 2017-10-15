Filters and morphological operators
============

Collection of Matlab algorithms implemented by me that carry out the computer vision operations like the following.
This was a project for the Computer Vision course in my senior year of my undergrad in computer science at UDC (Spain).


## Histogram manipulations
The algorithm compress/stretches the histogram to fit the image into the new values

```
function outputImage = histStretch( inputImage , minValue ,maxValue )
```

## Interpolation
The function makes a 2x zoom to the image, with the nearest neighbor interpolation and bilinear interpolation.

```
function outputImage = zoomIn2( inputImage ,mode )
```

where ```mode='bilinear' | 'neighbor'```

## Spacial filtering: Highlighting and Smoothing
HighBoost algorithm, allowing to customize the size of the filter and the amplification rate.

```
function outputImage = highBoost ( inputImage , filterSize , A) 
```

MedianFilter algorithm, allowing to establish the filter size

```
function outputImage = medianFilter( inputImage , filterSize )
```

## Morphological operators
The operators erode, dilate, opening and closing are implemented, allowing to configure the type of the structural element and its size.

```
function outputImage = erode ( inputImage , strElType , strlElSize )
function outputImage = dilate ( inputImage , strElType , strlElSize)
function outputImage = opening ( inputImage , strElType , strlElSize)
function outputImage = closing ( inputImage , strElType , strlElSize)
```

where ```strElType = 'square' | 'cross'.```

## Edge detector
Canny edge detector, allowing to specify hysteresis threshold and Gaussian smoothing's sigma
```
function outputImage = edgeCanny ( inputImage , sigma , tlow , thigh )
```

## Corner detector
SUSAN corner detector, allowing to specify mask radius and threshold of intensity allowed with respect to the center of the mask

```
function outputImage = cornerSusan ( inputImage , r , t )
```


## Tools

The project was developed with Matlab


## Contact

Contact [Daniel Ruiz Perez](mailto:druiz072@fiu.edu) for requests, bug reports and good jokes.


## License

The software in this repository is available under the GNU General Public License, version 3. See the [LICENSE](https://github.com/DaniRuizPerez/EyeMovementDetection/blob/master/LICENSE) file for more information.
