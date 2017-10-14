function output = erode(inputImage , strElType , strElSize)
close
%el 0 es negro
%si al pasar el operador morfologico, uno de los elementos que estan a 1 en
%el esta a 0 en la imagen, pongo a 0 el pixel en la imagen
%el 0 es el elemento del centro
%si en el elemento estructurante tengo un 0 en algun punto, me da igual lo
%que haya en la imagen en ese punto

sizeE = str2num(strElSize);

if mod(sizeE,2) == 0
    error = 'filterSize must be not be an odd number';
    return
end


img = imread(inputImage, 'jpg');
img = im2bw(img);
imshow(img)
ElRadius = floor(sizeE/2);


if (strcmp('square',strElType))
    element = ones(sizeE,sizeE);
    element
    
elseif (strcmp('cross',strElType))
    
     element = zeros(sizeE,sizeE);
     element(1+ElRadius,:) = 1;
     element(:,1+ElRadius) = 1;
     element

else
    error = 'bad parameters'
    return
end

[sizex,sizey] = size(img);
%creo una nueva imagen que es la original con bordes negros a mayores
imgAmp = zeros(sizex+2*ElRadius,sizey+2*ElRadius);
imgAmp(ElRadius+1:sizex+ElRadius,ElRadius+1:sizey+ElRadius) = img;


imshow(imgAmp)
%hay que inicializar a la imagen original porque vamos poniendo cachos en
%negro, necesitamos tener los elementos en blanco que erosionar
output = imgAmp;

for i=1+ElRadius:sizex+ElRadius;
    for j=1+ElRadius:sizey+ElRadius;
        %si hacemos la impliaccion filtro -> matriz, se puede expresar como
        %¬filtro or image
        %esto devuelve todo unos cuando no hay que erosionar, porque los
        %unos del filtro coinciden con todo unos en la imagen, y algun cero
        %cuando hay un uno que no coincide con un uno en la imagen.
        sectionImage = imgAmp(i-ElRadius:i+ElRadius,j-ElRadius:j+ElRadius);
        sol = or(~element,sectionImage);
        %nnz cuenta el numero de 1s
        %escribe un 1 o un 0 segun corresponda
        %si hay un 0 en el ee, pasa a 1, en el or siempre es 1
        output(i,j) = (nnz(sol) == sizeE^2);  
    end
end
figure;
%al devolver devolvemos la subimajen dentro de la ampliada
output = output(ElRadius+1:sizex+ElRadius,ElRadius+1:sizey+ElRadius);
imshow(output);
end






