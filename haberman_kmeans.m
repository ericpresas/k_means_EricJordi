clear all

%Import the dataset haberman.dat coosen from:
%http://sci2s.ugr.es/keel/dataset.php?cod=62

%Load dataset__________________________________________________________
[data,delimiterOut]=importdata('haberman.dat');
dimension=size(data);
n_features = 3;
n_clusters = 2;
n_samples=dimension(1) - 8; %there are 8 headerlines in the haberman.dat file
dataset = zeros(n_samples,4);
for i=1:n_samples
    splited_observation = strsplit(data{i+8},', ');
    if (splited_observation{4}=='positive')
      dataset(i,4) = 1;
    else
      dataset(i,4) = 2;
    end
    for j=1:n_features
        dataset(i,j) = str2double(splited_observation{1,j});
    end
end
%_________________________________________________________________________

%Split Train and Test datasets, Train datasets don't have to be labeled
%Train labels will be ignored

%Mix all database:
%Random partition of the DDBB
a = 40;
b = 60;
Percent_test = floor((b-a).*rand(1,1) + a)/100;

%Number features for test and train (for each cluster)
n_features_test=floor(n_samples*Percent_test);
n_features_train=n_samples-n_features_test;

X_train = zeros(n_features_train,4);
X_test = zeros(n_features_test,4);

last_position_train=1;
last_position_test=1;
for i=1:n_samples
 if (i <= n_features_train)
    X_train(i,:)= dataset(i, :);
 else
    X_test(i-n_features_train,:)= dataset(i, :);
 end
end

%Train k-means____________________________________________________________

%Take the number of vectors of the database
Centroids = zeros(n_clusters, n_features);

%Random centroids choice
perm = randperm(n_features_train);
for i=1:n_clusters
    Centroids(i,:) = X_train(perm(i),1:n_features);
end

new_Centroids = zeros(n_clusters, n_features);
iteration=1;
stop=0;
while stop~=1 %Stop condition
    
    %Assign each feature point to a cluster
    for i=1:n_features_train
        diff = X_train(i,1:n_features) - Centroids(1,:);
        dist(i,1) = sqrt(sum(diff * diff'));
        for j=2:n_clusters
            diff = X_train(i,1:n_features) - Centroids(j,:);
            dist(i,j) = sqrt(sum(diff * diff'));
        end
        d=dist(i,:);
        [mindist(i),Labels(i)]=min(d(:));
        Labels_orig(i)=X_train(i,4);
    end
    
    %Recalculate Centroids
    for i=1:n_clusters
        if(isempty(find(Labels==i))==0)
            X_train3{i}=X_train(find(Labels==i),:);
            X_train2=X_train(find(Labels==i),:);
            n_features_train2= size(X_train2);
            new_Centroids(i,:)=sum(X_train2(:,1:n_features))/(n_features_train2(1));      
        end    
    end
    if (new_Centroids-Centroids==0)
        stop=1;
    end
    Centroids=new_Centroids;
end
%_________________________________________________________________________
figure
ploter(X_train3, n_clusters,'*',1);
ploter(new_Centroids, n_clusters,'filled',0);

%Test k-means____________________________________________________________
Labels_orig = zeros(n_features_test, 1);
for i=1:n_features_test
    diff = X_test(i,1:n_features) - Centroids(1,:);
    dist(i,1) = sqrt(sum(diff * diff'));
    for j=2:n_clusters
        diff = X_test(i,1:n_features) - Centroids(j,:);
        dist(i,j) = sqrt(sum(diff * diff'));
    end
    d=dist(i,:);
    [mindist(i),Labels_test(i)]=min(d(:));
    
end
%_________________________________________________________________________
