function zoomin2(inputImage,zoom, mode) 

    if strcmp(mode, 'neighbor') == 1
        %se le asigna el valor del pixel vecino mas cercano
        img = imread(inputImage, 'jpg');
        img =double(rgb2gray(img));
        imshow(uint8(img));

        [sizex,sizey] = size(img);
        output = double(zeros(sizex*zoom,sizey*zoom));

        %recorro la imagen GRANDE
        for i=1:sizex*zoom
            for j=1:sizey*zoom
                a = round(i/zoom);
                b = round(j/zoom);

                %comprobamos que no se nos pase de los bordes
                %solo se podria pasar por la izda al ser 0, por la derecha
                %nunca, por eso hacemos maximo entre ese valor y 1
                a = max(a,1);
                b = max(b,1);

                output(i,j) = img(a,b);
            end
        end
        figure
        imshow(uint8(output));

    end

    if strcmp(mode,'bilinear') == 1
        %se tienen en cuenta los 4 mas cercanos ponderandolos
        img = imread(inputImage, 'jpg');
        img =double(rgb2gray(img));
        imshow(uint8(img));

        [sizex,sizey] = size(img);
        output = double(zeros(sizex*zoom,sizey*zoom));
        
        %recorro la imagen GRANDE
        for i=1:sizex*zoom
            for j=1:sizey*zoom

                %utilizamos floor para que a y b queden positivos
                a = i/zoom - floor(i/zoom);
                b = j/zoom - floor(j/zoom);

                %aplicamos los max para que no se salgan de rango
                %por la derecha nunca se sale de rango porque 
                %size*zoom/zoom siempre queda como mucho size
                floori = max(floor(i/zoom),1);
                floorj = max(floor(j/zoom),1);
                ceili = max(ceil(i/zoom),1);
                ceilj = max(ceil(j/zoom),1);
                
                %cojo los 4 puntos al rededor del pixel y los pondero por
                %su distancia en el eje x(b) y en el eje y(a) al pixel
                %orignal
                
                %a y b son las distancias al pixel de arriba a la izda.
                %cuanto mas pequeña sea esta distancia mas se tendria que
                %ponderar, por eso se multiplica por 1-a y 1-b.

                output(i,j) = (1-a)*[(1-b)* img(floori,floorj) + b*img(floori,ceilj)]...
                    + a*[(1-b) * img(ceili,floorj) + b*img(ceili,ceilj)];

            end
        end

        figure
        imshow(uint8(output));

    end
end