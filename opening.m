function opening(inputImage , strElType , strElSize)
%primero erosionamos y luego dilatamos
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

eroding = 'eroding...'
eroded =  erode(inputImage , strElType , strElSize);
imwrite(eroded,'eroded.jpg','jpg');
opening = 'opening...'
opened = dilate('eroded' , strElType , strElSize);

imshow(img)
figure
imshow(opened)





end






