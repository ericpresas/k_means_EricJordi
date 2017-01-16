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
elseif(method==2)
    b= [];
    for i=1:n
      b=[ a{i}(:,1), a{i}(:,2), a{i}(:,3)];
      plot3(b(:,1),b(:,2),b(:,3),'linewidth',10)
      hold on
    end
elseif(method==3)

    for i=1:n
      plot3(a(:,1),a(:,2),a(:,3),'linewidth',10)
      hold on
    end
    
end

