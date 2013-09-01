function R = axisAngle2rotMat(axis, angle)
    kx = axis(:,1);
    ky = axis(:,2);
    kz = axis(:,3);
    cT = cos(angle);
    sT = sin(angle);
    vT = 1 - cos(angle);
    
    R(1,1,:) = kx.*kx.*vT + cT;
    R(1,2,:) = kx.*ky.*vT - kz.*sT;
    R(1,3,:) = kx.*kz.*vT + ky.*sT;
    
    R(2,1,:) = kx.*ky.*vT + kz.*sT;
    R(2,2,:) = ky.*ky.*vT + cT;
    R(2,3,:) = ky.*kz.*vT - kx.*sT;
    
    R(3,1,:) = kx.*kz.*vT - ky.*sT;
    R(3,2,:) = ky.*kz.*vT + kx.*sT;
    R(3,3,:) = kz.*kz.*vT + cT;
end

