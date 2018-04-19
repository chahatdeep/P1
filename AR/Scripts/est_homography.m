function [ H ] = est_homography(video_pts, logo_pts)

% est_homography estimates the homography to transform each of the
% video_pts into the logo_pts
% Inputs:
%     video_pts: a 4x2 matrix of corner points in the video
%     logo_pts: a 4x2 matrix of logo points that correspond to video_pts
% Outputs:
%     H: a 3x3 homography matrix such that logo_pts(x') ~ H*video_pts(x)
%video_pts = [video_pts, 1]'; logo_pts = [logo_pts, 1]'; % each now a 3x4 matrix with column vectors

%

x = video_pts(:, 1); y = video_pts(:, 2);

xp = logo_pts(:, 1); yp = logo_pts(:, 2);

%ax = zeros(size(x)); ay = zeros(size(y));

z = zeros(size(x)); o = ones(size(x));

ax = [-x, -y, -o, z, z, z, x.*xp, y.*xp, xp];

ay = [z, z, z, -x, -y, -o, x.*yp, y.*yp, yp];

A = [ax; ay];

%%%%

[U, S, V] = svd(A);

H = V(:,size(V,2))';

H = [H(1:3); H(4:6); H(7:9)];

end

