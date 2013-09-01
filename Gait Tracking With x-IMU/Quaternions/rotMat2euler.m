function euler = rotMat2euler(R)
    % from paper: "Adaptive Filter for a Miniature MEMS Based Attitude and
    % Heading Reference System" by Wang et al, IEEE.
    
    phi = atan2(R(3,2,:), R(3,3,:) );
    theta = -atan(R(3,1,:) ./ sqrt(1-R(3,1,:).^2) );    
    psi = atan2(R(2,1,:), R(1,1,:) );

    euler = [phi(1,:)' theta(1,:)' psi(1,:)'];  
end

