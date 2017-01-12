function [ db ] = gauss_feat_creator( dim, n_clusters, num_feat )
%Inputs: data dimension (dim)
%        number of classes (n_clusters)
%        number of features (num_feat)
%Output: Gaussian DataBase (db)
%generem la sigma igual per totes les gaussianes 
a = rand(3,3);
SIGMA = a'*a;
db = cell(n_clusters, 1) ;

for i=1:n_clusters
    %generem vector mitja aleatori:
    mu = 3*floor(rand(1,dim)*4) - 3; % first dimension means
    %creem la gaussiana
    db{i} = mvnrnd(mu, SIGMA,num_feat); 
end
end

