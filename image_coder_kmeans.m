clear all
% Creation of a Gaussian Database:
dim = 3;
n_clusters = 64;
num_feat = 128*128;
%db_gaussian = gauss_feat_creator( dim, n_clusters, num_feat );
%figure('name','Scatter Plot')


%Mix all database:
%Random partition of the DDBB
a = 0;
b = 100;
Percent_test = 0;

%K-MEANS____________________________________________________________
%LLEGIM IMATGE I COLOQUEM ELS PIXELS EN UN VECTOR
 img = imread('lena_color.png');
 img=imresize(img,0.25);
 figure(1);
 imshow(img);
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
 
 
%Take the number of vectors of the database
num_vectorfeat=128*128;
dim=3;

%Random centroids choice
perm = randperm(num_vectorfeat);
for i=1:n_clusters
    Centroids(i,:) = X_train(perm(i),:);
    old_Centroids(i,:)=ones(1,dim);
end
error=[]
cont=1;
while abs(norm(Centroids-old_Centroids))>0
    %Assign each feature point to a cluster
    norm(Centroids-old_Centroids)
    for i=1:num_vectorfeat
        diff = X_train(i,:) - Centroids(1,:);
        dist(i,1) = sqrt(sum(diff * diff'));
        for j=2:n_clusters
            diff = X_train(i,:) - Centroids(j,:);
            dist(i,j) = sqrt(sum(diff * diff'));
        end
        d=dist(i,:);
        [mindist(i),Labels(i)]=min(d(:));
    end
    error(cont)=mean(mindist);
    cont=cont+1
    %Recalculate Centroids
    for i=1:n_clusters
        if(isempty(find(Labels==i))==0)
            X_train2{i}=X_train(find(Labels==i),:);
            num_vectorfeat2= size(X_train2{i});
            new_Centroids(i,:)=sum(X_train2{i})/(num_vectorfeat2(1));

        end    
    end
    old_Centroids=Centroids;
    Centroids = new_Centroids;
    
end
result = recreate_image( Labels, Centroids );
figure(2);
imshow(uint8(result));
%_________________________________________________________________________
%ploter(X_train2, n_clusters,'*',1);
%ploter(Centroids, n_clusters,'filled',0);

    
   
    
    
    
    
    
    