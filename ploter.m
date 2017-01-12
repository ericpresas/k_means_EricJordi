function [ ] = ploter( a, n, points , method)
%     a: Features(matrix or cell with matrix)
%Method: 0---> for matrix features(centroids)
%        1---> for cells with matrix features
%Points: Appareance of points

if (method==1)
    for i=1:n
            scatter3( a{i}(:,1),a{i}(:,2),a{i}(:,3),points)
            hold on
    end
elseif (method==0) 
    for i=1:n
            scatter3( a(i,1),a(i,2),a(i,3),points)
            hold on
    end  
end

