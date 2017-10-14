function closing(inputImage , strElType , strElSize)
%primero dilatamos y luego erosionamos
close

sizeE = str2num(strElSize);

if mod(sizeE,2) == 0
    error = 'filterSize must be not be an odd number'
    return
end

img = imread(inputImage, 'jpg');
img = im2bw(img);
imshow(img)


if (~strcmp('square',strElType) && ~strcmp('cross',strElType))
    error = 'bad parameters'
    return
end

%erosion y leugo dilatacion


opening = 'opening...'
dilated = dilate(inputImage , strElType , strElSize);
imwrite(dilated,'dilated.jpg','jpg');
eroding = 'eroding...'
closed =  erode('dilated' , strElType , strElSize);

imshow(img)
figure
imshow(closed)


end






