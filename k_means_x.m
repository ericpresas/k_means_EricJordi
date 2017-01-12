function [ Centroids, Labels ] = k_means_x( X, n_clusters )
%Take the number of vectors of the database
[num_vectorfeat, dim] = size(X);

%Randomització centres
Centroids=gauss_feat_creator( 3, n_clusters, 1 );

%Random permutation
perm = randperm(num_vectorfeat);

%BIG LOOOOP

    %Assign each feature point to a cluster
    for i=1:num_vectorfeat
        for j=1:n_clusters
            dist(i,j)=sqrt(sum( (X(i) - Centroids{j}) .^2));
        end
        d=dist(i,:);
        [mindist(i),Labels(i)]=min(d(:));
    end
    
    %Recalculate Centroids
    for i=1:num_vectorfeat
        k_features_index(i) = find(Labels(i)==1)
    end
    
    
    


end

