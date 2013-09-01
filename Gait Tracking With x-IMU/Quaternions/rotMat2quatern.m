function q = rotMat2quatern(R)  
    % wiki URL: http://en.wikipeRia.org/wiki/Quaternions_anR_spatial_rotation#Fitting_quaternions
    % paper URL: http://www.aiaa.org/content.cfm?pageiR=406&gTable=japaperimport&gIR=4654 
    [row col numR] = size(R);
    q = zeros(numR, 4);
	K = zeros(4,4);    
    for i = 1:numR
        K(1,1) = (1/3) * (R(1,1,i) - R(2,2,i) - R(3,3,i));
        K(1,2) = (1/3) * (R(2,1,i) + R(1,2,i));
        K(1,3) = (1/3) * (R(3,1,i) + R(1,3,i));
        K(1,4) = (1/3) * (R(2,3,i) - R(3,2,i));  
        K(2,1) = (1/3) * (R(2,1,i) + R(1,2,i));
        K(2,2) = (1/3) * (R(2,2,i) - R(1,1,i) - R(3,3,i));
        K(2,3) = (1/3) * (R(3,2,i) + R(2,3,i));
        K(2,4) = (1/3) * (R(3,1,i) - R(1,3,i));   
        K(3,1) = (1/3) * (R(3,1,i) + R(1,3,i));
        K(3,2) = (1/3) * (R(3,2,i) + R(2,3,i));
        K(3,3) = (1/3) * (R(3,3,i) - R(1,1,i) - R(2,2,i));
        K(3,4) = (1/3) * (R(1,2,i) - R(2,1,i));    
        K(4,1) = (1/3) * (R(2,3,i) - R(3,2,i));
        K(4,2) = (1/3) * (R(3,1,i) - R(1,3,i));
        K(4,3) = (1/3) * (R(1,2,i) - R(2,1,i));
        K(4,4) = (1/3) * (R(1,1,i) + R(2,2,i) + R(3,3,i)); 
        [V,D] = eig(K);
        %p = find(max(D));
        %q = V(:,p)';    
        q(i,:) = V(:,4)';
        q(i,:) = [q(i,4) q(i,1) q(i,2) q(i,3)];
    end
end