function output = histStrechFun(inputImage, minValue, maxValue) 
inputImage = double(inputImage);

[sizex,sizey] = size(inputImage);
[maxVal,maxInd] = max(inputImage(:));
[minVal,minInd] = min(inputImage(:));

for i=1:sizex
    for j=1:sizey
        inputImage(i,j) = minValue + (maxValue - minValue)*(inputImage(i,j)-minVal)/(maxVal-minVal);
    end
end


[maxVal,maxInd] = max(inputImage(:));
[minVal,minInd] = min(inputImage(:));

output = uint8(inputImage);
%imshow(uint8(inputImage));
end