function  highBoost(inputImage , filterSize , A)
if mod(filterSize,2) == 0
    error = 'filterSize must be not be an odd number'
    return
end

img = imread(inputImage, 'jpg');
img =double(rgb2gray(img));
filterRadius = floor(filterSize/2);

filter = double(ones(filterSize,filterSize))*(-1);
%filter(ceil(filterSize/2),ceil(filterSize/2)) = A + filterSize^2-1;
filter(ceil(filterSize/2),ceil(filterSize/2)) = A*filterSize^2-1;

[sizex,sizey] = size(img);

output = double(zeros((sizex),(sizey)));

for i=filterRadius+1:sizex-filterRadius
    for j=filterRadius+1:sizey-filterRadius
        output(i,j)= sum(sum(img(i-filterRadius:i+filterRadius,j-filterRadius:j+filterRadius) .* filter));
    end
end
%divido entre A para normalizar
%output=( output /A);
output = histStrechFun(output,0,255);
imshow(uint8(output));

end