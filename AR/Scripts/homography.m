function [ final_image, H ] = homography( Image, Plot, I_corners, P_corners )
% H is the homography matrix i.e. Image pixels = H * plot pixels

% estimate homography
% Plot coordinates
y = P_corners(:, 1); 
x = P_corners(:, 2);
% Image coordinates
yp = I_corners(:, 1);
xp = I_corners(:, 2);

% compute Xp = H X

z = zeros(size(x)); o = ones(size(x));

ax = [-x, -y, -o, z, z, z, x.*xp, y.*xp, xp];
ay = [z, z, z, -x, -y, -o, x.*yp, y.*yp, yp];
A = [ax; ay];

[U, S, V] = svd(A);
H = V(:,size(V,2))';

% Homography Calculation
H = [H(1:3); H(4:6); H(7:9)];

H_inv = inv(H);

final_image = Image;
for i = min(yp): max(yp)
    for j = min(xp): max(xp)
        image_coordinates = H_inv * [ j, i, 1 ]';
        image_coordinates = floor(image_coordinates/image_coordinates(3));
        if(image_coordinates(2) < max(y) && image_coordinates(1) < max(x) &&...
           image_coordinates(2) > min(y) && image_coordinates(1) > min(x))
            final_image(i,j,:) = Plot(image_coordinates(2),image_coordinates(1),:);
    end
end



end

