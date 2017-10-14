function histStrech(inputImage, minValue, maxValue) 
% comprime o estira el histograma en funcion de los parámetros
img = imread(inputImage, 'jpg');
imgStrech =double(rgb2gray(img));

[sizex,sizey] = size(imgStrech);
[oldMaxVal,maxInd] = max(imgStrech(:));
[oldMinVal,minInd] = min(imgStrech(:));

%recorro la imagen y aplico la ecuacion para normalizar el valor
for i=1:sizex
    for j=1:sizey
        imgStrech(i,j) = minValue...
            + (maxValue - minValue)*(imgStrech(i,j)-oldMinVal)/(oldMaxVal-oldMinVal);
    end
end

oldMaxVal
oldMinVal

max(max(imgStrech))
min(min(imgStrech))

imshow(uint8(imgStrech));
end