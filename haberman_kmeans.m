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
      dataset(i,4) = -1;
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


for a=1:10000 %CAMBIAR AQUEST LOOP PER UNA CONDICIÓ DE STOP
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
    Centroids = new_Centroids;
    
end
%_________________________________________________________________________
ploter(X_train3, n_clusters,'*',1);
ploter(Centroids, n_clusters,'filled',0);

