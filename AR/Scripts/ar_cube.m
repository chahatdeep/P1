function [proj_points, t, R] = ar_cube(H,render_points,K)
%% ar_cube
% Estimate your position and orientation with respect to a set of 4 points on the ground
% Inputs:
%    H - the computed homography from the corners in the image
%    render_points - size (N x 3) matrix of world points to project
%    K - size (3 x 3) calibration matrix for the camera
% Outputs: 
%    proj_points - size (N x 2) matrix of the projected points in pixel
%      coordinates
%    t - size (3 x 1) vector of the translation of the transformation
%    R - size (3 x 3) matrix of the rotation of the transformation

% YOUR CODE HERE: Extract the pose from the homography

h1 = H(:,1); h2 = H(:,2); h3 = H(:,3);

Rp = [h1, h2, cross(h1,h2)];

[U,~,V] = svd(Rp);

R = U*[1,0,0;0,1,0;0,0,det(U*V')]*V';

t = h3./sqrt( sum( H(:,1).^2 ) );

N = size(render_points,1);

proj_points = zeros(N, 2);

for i=1:N

    X_im = K * (R * render_points(i, :)' + t);

    proj_points(i, :) = [X_im(1)./X_im(3), X_im(2)./X_im(3)];

end;

% %YOUR CODE HERE: Project the points using the pose
% 
% render_points = [render_points'; ones(1,N)];
% 
% proj_points = K*[R,t]*render_points;
% 
% proj_points = [proj_points(1,:)./proj_points(3,:); proj_points(2,:)./proj_points(3,:)];
% 
% proj_points = proj_points';


    
end
