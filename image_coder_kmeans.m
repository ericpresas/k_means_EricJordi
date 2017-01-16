clear all
% dimensió=3(RGB)
dim = 3;
%nombre de colors (clusters) amb els que representarem la imatge
n_clusters = 16;
%farem un resize per deixar-les de 128*128pixels
num_feat = 128*128;



%LLEGIM LES IMATGES I COLOQUEM ELS PIXELS EN UN VECTOR
 img = imread('lena_color.png');
 img=imresize(img,[128 128]);
 figure(1);
 imshow(img);
  img2 = imread('vista_aeria_ripoll.jpg');
img2=imresize(img2,[128 128]) ;
 figure(3);
 imshow(img2);
z=1;
 X_train=[];
 for i=1:128
     for j=1:128
         X_train(z,1)=img(i,j,1);
         X_train(z,2)=img(i,j,2);
         X_train(z,3)=img(i,j,3);
         
         z=z+1;
         
     end
 end
 
 z=1;
 X_test=[];
 for i=1:128
     for j=1:128
         X_test(z,1)=img2(i,j,1);
         X_test(z,2)=img2(i,j,2);
         X_test(z,3)=img2(i,j,3);
         
         z=z+1;
         
     end
 end
 
%CRIDEM LA FUNCIÓ CLP_KMEANS AMB ELS VECTORS DE LA PRIMERA IMATGE
%(lenna.png) I LA FUNCIÓ KMEANS_PREDICT AMB ELS VECTORS DE LA SEGONA IMATGE
%I ELS CENTROIDES TROBATS EN TRAIN.


[Centroids, Labels_train,X_train ] = clp_kmeans( X_train, n_clusters );
[mindist, Labels_test ] = kmeans_predict( X_test,Centroids,n_clusters );

%Reconstrucció de la imatge i representació de les imatges quantificades
result = recreate_image( Labels_train, Centroids );
figure(2);
imshow(uint8(result));

result2 = recreate_image( Labels_test, Centroids );
figure(4);
imshow(uint8(result2));
%_________________________________________________________________________
%ploter(X_train2, n_clusters,'*',1);
%ploter(Centroids, n_clusters,'filled',0);

    
   
    
    
    
    
    
    