clear all
% Creation of a Gaussian Database:
dim = 3;
n_clusters = 2;
num_feat = 60;
db_gaussian = gauss_feat_creator( dim, n_clusters, num_feat );
figure('name','Scatter Plot')


%Mix all database:
%Random partition of the DDBB
a = 40;
b = 60;
Percent_test = floor((b-a).*rand(1,1) + a)/100;

%Number features for test and train (for each cluster)
num_feat_test=floor(num_feat*Percent_test);
num_feat_train=num_feat-num_feat_test;
last_position_train=1;
last_position_test=1;
for i=1:n_clusters
 X_test= db_gaussian{i,1}(1:num_feat_test, :);
 X_train = db_gaussian{i,1}(num_feat_test:num_feat, :);
 last_position_test=last_position_test+num_feat_test;
 last_position_train=last_position_train+num_feat_train;
end

%K-MEANS____________________________________________________________

%Take the number of vectors of the database
[num_vectorfeat, dim] = size(X_train);

%Random centroids choice
perm = randperm(num_vectorfeat);
for i=1:n_clusters
    Centroids(i,:) = X_train(perm(i),:);
end


for a=1:10000 %CAMBIAR AQUEST LOOP PER UNA CONDICIÓ DE STOP
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
ploter(X_train2, n_clusters,'*',1);
ploter(Centroids, n_clusters,'filled',0);

    
   
    
    
    
    
    
    