function  medianFilter(inputImage , filterSize)
if mod(filterSize,2) == 0
    error = 'filterSize must be not be an odd number'
    return
end

img = imread(inputImage, 'jpg');
img =double(rgb2gray(img));
%imshow(uint8(img));
filterRadius = floor(filterSize/2);

[sizex,sizey] = size(img);

output = double(zeros((sizex),(sizey)));

for i=filterRadius+1:sizex-filterRadius
    for j=filterRadius+1:sizey-filterRadius
        output(i,j)= median(median(img(i-filterRadius:i+filterRadius,j-filterRadius:j+filterRadius)));
    end
end

imshow(uint8(output));

end