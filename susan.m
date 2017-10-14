function susan(inputImage,r,t)
%susan('susanfigures1',3,13)
% con esos mismos parametros, bordes perfectos con el umbral a 3/4 en ved
% de 2/4
%susan('susanfigure2',3,40)

%susan('susan',3,150)

img = imread(inputImage, 'jpg');
imcpy = img;
img =uint8(rgb2gray(img));

[sizex,sizey] = size(img);

%subplot(1,2,1)
%imshow(img);

%si queremos que el centro sea un unico punto, el diametro tiene que ser
%impar
%como siempre va a ser par, le restamos 1 

filter = zeros(r*2-1);
for i = 1 : r*2-1
  for j = 1 : r*2-1
    filter(i, j) = (i-r)^2 + (j-r)^2 < r^2;
  end;
end;

%imshow(filter)

imgAmp = zeros(sizex+2*r,sizey+2*r);
imgAmp(r+1:sizex+r,r+1:sizey+r) = img;


%hago una mascara igual que filter pero todos sus valores estan a la
%intensidad del pixel central. lo resto a la multipliucacion de la imagen
%por la mascara y si el valor absoluto de la diferencia entre los pixeles
%de las dos mascaras es menor que el umbral, entonces tiene el mismo color

susan = zeros (sizex,sizey);
polygon = [];
for i = r+1 : sizex + r
  for j = r+1 : sizey + r
      count = 0;
      filterAux = filter;
      sectionImage = imgAmp(i-r+1:i+r-1,j-r+1:j+r-1);
      mult = filter.*sectionImage;
      filterAux = filterAux .* mult(r,r);
      resta = mult - filterAux;
      
      for g = 1:r*2-1
          for h = 1:r*2-1
              if abs(resta(g,h)) < t 
                  count = count+1;
              end
          end
      end
      
      if (count < (r*2-1)^2*2/4) && count > 0
            polygon = [polygon ; int32([j-r-2 i-r-2 4 4])]; 
            susan(i-r,j-r) = 1;

      end
  end
end

%subplot(1,2,2)
%imshow(susan)


shapeInserter = vision.ShapeInserter('Shape','Rectangles','BorderColor','Custom', 'CustomBorderColor', uint8([255 0 0]));
I = imcpy;
final = step(shapeInserter, I, polygon);

imshow(final); 





