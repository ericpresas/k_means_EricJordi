function [ img_reco ] = recreate_image( Labels, Centroids )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
img_vec =ones(length(Labels), 3);
for i=1:length(Labels)
    img_vec(i,1)=uint8(Centroids(Labels(i),1));
     img_vec(i,2)=uint8(Centroids(Labels(i),2));
      img_vec(i,3)=uint8(Centroids(Labels(i),3));

end
k=1;
img_reco= ones(128,128,3);
for i=1:128
    for j=1:128
        img_reco(i,j,:)= uint8(img_vec(k,:));
        k=k+1;
    end
end


