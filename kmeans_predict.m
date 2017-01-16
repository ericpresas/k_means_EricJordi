function [mindist, Labels ] = kmeans_predict( X_test,Centroids,n_clusters )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

[num_vectorfeat, dim] = size(X_test);

    %Assign each feature point to a cluster
    for i=1:num_vectorfeat
        diff = X_test(i,:) - Centroids(1,:);
        dist(i,1) = sqrt(sum(diff * diff'));
        for j=2:n_clusters
            diff = X_test(i,:) - Centroids(j,:);
            dist(i,j) = sqrt(sum(diff * diff'));
        end
        d=dist(i,:);
        [mindist(i),Labels(i)]=min(d(:));
    end

end

