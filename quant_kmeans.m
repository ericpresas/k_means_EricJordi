clear all
% Creation of a Gaussian Database:
dim = 3;
n_clusters = 128;
num_feat = 128*128;
%db_gaussian = gauss_feat_creator( dim, n_clusters, num_feat );
%figure('name','Scatter Plot')


%Mix all database:
%Random partition of the DDBB
a = 0;
b = 100;
Percent_test = 0;
stop=[0 0 ; 0 0];

%Number features for test and train (for each cluster)
%num_feat_test=floor(num_feat*Percent_test);
%num_feat_train=num_feat-num_feat_test;
%last_position_train=1;
%last_position_test=1;
%for i=1:n_clusters
% X_test= db_gaussian{i,1}(1:num_feat_test, :);
% X_train = db_gaussian{i,1}(num_feat_test:num_feat, :);
 %last_position_test=last_position_test+num_feat_test;
 %last_position_train=last_position_train+num_feat_train;
%end

%K-MEANS____________________________________________________________
%LLEGIM IMATGE I COLOQUEM ELS PIXELS EN UN VECTOR
 img = imread('lena_color.png');
 img=imresize(img,0.25);
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
    new_Centroids(i,:)=ones(1,dim);
end


while norm(new_Centroids-Centroids)>0
    %Assign each feature point to a cluster
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
   
    %Recalculate Centroids
    for i=1:n_clusters
        if(isempty(find(Labels==i))==0)
            X_train2{i}=X_train(find(Labels==i),:);
            num_vectorfeat2= size(X_train2{i});
            new_Centroids(i,:)=sum(X_train2{i})/(num_vectorfeat2(1));

        end   
    end
    Centroids = new_Centroids;
   
end

%_________________________________________________________________________
%ploter(X_train2, n_clusters,'*',1);
%ploter(Centroids, n_clusters,'filled',0);