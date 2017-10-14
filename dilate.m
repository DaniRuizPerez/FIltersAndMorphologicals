function  output = dilate(inputImage , strElType , strElSize);
close
%el 0 es negro
% si el 0,0 del elemento estructurante esta a 1 en la imagen hago un or del
% elemento y la seccion de la imagen
%el 0,0 de un elemento cuadrado es el del medio
sizeE = str2num(strElSize);

if mod(sizeE,2) == 0
    error = 'filterSize must be not be an odd number'
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
[sizex,sizey] = size(img)
%creo una nueva imagen que es la original con bordes negros a mayores
imgAmp = zeros(sizex+2*ElRadius,sizey+2*ElRadius);
imgAmp(ElRadius+1:sizex+ElRadius,ElRadius+1:sizey+ElRadius) = img;


output =  zeros(sizex+2*ElRadius,sizey+2*ElRadius);
%trabajamos sobre la imagen ampliada de la imagen de salida

for i=1+ElRadius:sizex+ElRadius;
    for j=1+ElRadius:sizey+ElRadius;
        sectionImage = imgAmp(i-ElRadius:i+ElRadius,j-ElRadius:j+ElRadius);
        %si hacemos un and elemento a elemento nos dice si algun elemento
        %que estaba a 1 en el filtro tambien esta a 1 en la seccion de la
        %imagen. 
        a = and(sectionImage,element);
        %si el elemento central esta a 1, dilatamos dibujando el elemento encima de la
        %seccion de la imagen
        if a(ElRadius+1,ElRadius+1) == 1;
            %hay que hacer un or de todo porque si no sobrescribimos los 0s
            %en la imagen final
            output(i-ElRadius:i+ElRadius,j-ElRadius:j+ElRadius) = or(or(sectionImage,element),output(i-ElRadius:i+ElRadius,j-ElRadius:j+ElRadius));    
        end   
    end
end
figure
%al devolver devolvemos la subimajen dentro de la ampliada
output = output(ElRadius+1:sizex+ElRadius,ElRadius+1:sizey+ElRadius);
imshow(output);
end





