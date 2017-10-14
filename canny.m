function canny (inputImage, sigma,tLow,tHigh)
%canny2('lenna',1,10,40)

%con la supresion no maxima solo tengo en cuenta la direccion del pixel que
%estoy mirando, no miroq ue los pixeles en esa direccion tengan tambien la
%misma direccion

filterSize = 5;
filterRadius = floor(filterSize/2);
img = imread(inputImage, 'jpg');

subplot(2,3,1)
imshow(img)
title('Original');

img =double(rgb2gray(img));

%aplicamos el filtro gausiano, por defecto ponemos el filtersize a 5
output = gausian(inputImage,filterSize,sigma);

subplot(2,3,2)
imshow(uint8(output));
title('Gaussiano');

[sizex,sizey] = size(output);
output = double(output);

%mascaras de sobel para detectar los bordes
sobel1 = double([-1 0 1 ; -2 0 2 ; -1 0 1]);
sobel2 = double([-1 -2 -1 ; 0 0 0 ; 1 2 1]);
imX = double(ones(sizex,sizey)*eps);
imY = double(ones(sizex,sizey)*eps);
%convolucionamos las matrices para detectar los bordes en X y en Y
%no convolucionamos los primeros filterRadius elementos ya que quedarian
%bordes al rededor de la imagen
for i=2+filterRadius:sizex-filterRadius
    for j=2+filterRadius:sizey-filterRadius
        imX(i,j) = sum(sum (output(i-1:i+1,j-1:j+1) .* sobel1));
        imY(i,j) = sum(sum (output(i-1:i+1,j-1:j+1) .* sobel2));
    end
end


%calculos las matrices magnitud y orientacion de bordes
magnitud = sqrt(imX .^2 + imY .^2);
orientacion = atan(imX./(imY+eps));

output = histStrechFun(magnitud,0,255);

subplot(2,3,3)
imshow(output)
title('Magnitud');

subplot(2,3,4)
imshow(orientacion)
title('Orientacion');


%reemplazo la matriz de orientaciones por las direcciones en las que tengo
%que mirar los pixeles 
for i=1:size(orientacion,1)
    for j=1:size(orientacion,2)
        if orientacion(i,j) >0.7854
            orientacion(i,j) = 1;
        end
        if orientacion(i,j) <= 0.7854 && orientacion(i,j) > 0
            orientacion(i,j) = 2;
        end
        if orientacion(i,j) <= 0.0 && orientacion(i,j) > -0.7854
            orientacion(i,j) = 3;
        end
        if orientacion(i,j) <-0.7854
            orientacion(i,j) = 4;
        end
    end
end


%amplio la matriz de magnitudes con bordes de 0s de 1 pixel de grosor
magAmp = zeros(sizex+2,sizey+2);
magAmp(2:sizex+1,2:sizey+1) = magnitud;
%inicializo la matriz en la que pondre los bordes
output = zeros(sizex,sizey);

%recorro la matriz de orientaciones, calculando los pixeles a los que
%tengo que mirar en base a las direcciones de los bordes
for i=1:size(orientacion,1)
    for j=1:size(orientacion,2)
        ia = i+1;
        ja = j+1;
        
        switch orientacion(i,j)
           %cojemos la perpendicular!!!!!!
            case 2
                %pixeles N y S
                if magAmp(ia,ja) > magAmp(ia+1,ja)&& magAmp(ia,ja) > magAmp(ia-1,ja)
                   output(i,j) = magnitud(i,j);
                end
            
            case 1
                %pixeles NE y SO
                if magAmp(ia,ja) > magAmp(ia-1,ja-1)&& magAmp(ia,ja) > magAmp(ia+1,ja+1)
                   output(i,j) = magnitud(i,j);
                end
            
            case 4
                %pixeles E y O
                if magAmp(ia,ja) > magAmp(ia,ja+1)&& magAmp(ia,ja) > magAmp(ia,ja-1)
                    output(i,j) = magnitud(i,j);
                end
                
            case 3
                %pixeles SE y NO
                if magAmp(ia,ja) > magAmp(ia-1,ja+1)&& magAmp(ia,ja) > magAmp(ia+1,ja-1)
                    output(i,j) = magnitud(i,j);
                end
     
        end
    end
end
subplot(2,3,5)
output =  histStrechFun(output, 0, 255); 
imshow(uint8(output))
title('Supresion no máxima');
size(output)

visitados = zeros(sizex,sizey);
visitados1 = zeros(sizex,sizey);

%en la cola voy metiendo las coordenadas que tengo que ir mirando
%como el borde esta a negro nunca me paso

%%voy mirando cada uno de los pixeles, si es mayor que thigh,lo  meto en la
%%cola. saco elementos de la cola y miro los pixeles a los que apunta su
%%direccion, y si son mayores que tlow, los meto en la cola y hago lo mismo

for i=1:sizex
    for j=1:sizey
        if output(i,j) > tHigh
            visitados(i,j) = 1;
           % visitados1(i,j) = 1;
            cola(1,1) = i;
            cola(2,1) = j;
            cola;
            while(size(cola,2) ~= 0)
                pi = cola(1,1);
                pj = cola(2,1);
                %elimino el primer elemento de la cola
                cola = cola(1:2,2:size(cola,2));
                
                if (output(pi,pj) > tLow)
                    switch orientacion(pi,pj)
                        
                        case 1
                            %vertical
                            if(visitados(pi+1,pj) == 0 && output(pi+1,pj) ~= 0)
                                cola(1,size(cola,2)+1) = pi+1;
                                cola(2,size(cola,2)) = pj;
                                visitados(pi+1,pj) = 1;

                            end
                            if(visitados(pi-1,pj) == 0 && output(pi-1,pj) ~= 0)
                                cola(1,size(cola,2)+1) = pi-1;
                                cola(2,size(cola,2)) = pj;
                                visitados(pi-1,pj) = 1;
                            end
                        case 3
                            %horizontal
                            if(visitados(pi,pj+1) == 0 && output(pi,pj+1) ~= 0)
                                cola(1,size(cola,2)+1) = pi;
                                cola(2,size(cola,2)) = pj+1;
                                visitados(pi,pj+1) = 1;

                            end
                            if(visitados(pi,pj-1) == 0 && output(pi,pj-1) ~= 0)
                                cola(1,size(cola,2)+1) = pi;
                                cola(2,size(cola,2)) = pj-1;
                                visitados(pi,pj-1) = 1;
                            end
                            case 2
                            %NE
                            if(visitados(pi-1,pj+1) == 0 && output(pi-1,pj+1) ~= 0)
                                cola(1,size(cola,2)+1) = pi-1;
                                cola(2,size(cola,2)) = pj+1;
                                visitados(pi-1,pj+1) = 1;

                            end
                            if(visitados(pi+1,pj-1) == 0 && output(pi+1,pj-1) ~= 0)
                                cola(1,size(cola,2)+1) = pi+1;
                                cola(2,size(cola,2)) = pj-1;
                                visitados(pi+1,pj-1) = 1;
                            end
                           case 4
                            %NO
                            if(visitados(pi+1,pj+1) == 0 && output(pi+1,pj+1) ~= 0)
                                cola(1,size(cola,2)+1) = pi+1;
                                cola(2,size(cola,2)) = pj+1;
                                visitados(pi+1,pj+1) = 1;

                            end
                            if(visitados(pi-1,pj-1) == 0 && output(pi-1,pj-1) ~= 0)
                                cola(1,size(cola,2)+1) = pi-1;
                                cola(2,size(cola,2)) = pj-1;
                                visitados(pi-1,pj-1) = 1;
                            end 

                    end

                end
            end
            
        end 
    end
end

subplot(2,3,6)
imshow(visitados);
title('Histéresis');
%figure
%imshow(visitados);
%figure
%imshow(visitados1);
%a = visitados == visitados1;
%ismember(0,a)

%figure
%subplot(1,1,1)
%imshow(visitados)

end