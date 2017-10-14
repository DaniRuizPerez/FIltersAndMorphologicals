function output =  gausian (inputImage,filterSize, sigma)

img = imread(inputImage, 'jpg');
img =double(rgb2gray(img));

[sizex,sizey] = size(img);

filterRadius = floor(filterSize/2);
filter = double(ones(filterSize,filterSize));

for i = 1:filterSize
    for j =1:filterSize
        x = j-filterRadius-1;
        y = filterRadius - i + 1;
        filter(i,j) = (exp(-(x^2+y^2)/(2*sigma^2)))/(2*pi*sigma^2);
    end
end

%amplio la imagen y multiplico por 127 porque es lo que queda entre blanco
%y negro, para que los bordes no salgan tan marcados
imgAmp = ones(sizex+2*filterRadius,sizey+2*filterRadius)*127;
imgAmp(filterRadius+1:sizex+filterRadius,filterRadius+1:sizey+filterRadius) = img;

output = double(zeros((sizex),(sizey)));

for i=1:sizex
    for j=1:sizey
        output (i,j) = sum(sum (imgAmp(i:i+2*filterRadius,j:j+2*filterRadius) .* filter));
    end
end

%output = histStrechFun(output,0,255);
imshow(output)
end