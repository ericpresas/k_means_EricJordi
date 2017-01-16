function[Centroids, Labels,X_train2 ] = clp_kmeans( X_train, n_clusters )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%Take the number of vectors of the database
[num_vectorfeat, dim] = size(X_train);

%Random centroids choice
perm = randperm(num_vectorfeat);
for i=1:n_clusters
    Centroids(i,:) = X_train(perm(i),:);
end


new_Centroids = zeros(n_clusters, dim);
stop=0;
Store_Centroids=cell(n_clusters);
while stop~=1 %Stop condition
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
    sizes_classes=[];
    for i=1:n_clusters
        if(isempty(find(Labels==i))==0)
            X_train2{i}=X_train(find(Labels==i),:);
            temp_size=X_train2{i};
            sizes_classes(i)=temp_size(1);
            num_vectorfeat2= size(X_train2{i});
            new_Centroids(i,:)=sum(X_train2{i})/(num_vectorfeat2(1));  
            m(i,:)= sum(X_train2{i}.*(1/num_vectorfeat));
        end
        Store_Centroids{i}=[Store_Centroids{i}; new_Centroids(i,:)];
    end
    if (new_Centroids-Centroids==0)
        stop=1;
    end
    Centroids = new_Centroids;

end

