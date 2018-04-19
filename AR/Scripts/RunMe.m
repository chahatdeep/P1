% Author: Karan Bhargava

clc;
close all;
% Part 1

corners1 = [126, 311; 135, 338; 152, 317; 144, 287];
corners2 = [538, 954; 532, 1011; 568, 1023; 576, 961];
corners3 = [164, 864; 159, 902; 181, 914; 185, 877];

f = '../Data/multipleTags.mp4'
v = VideoReader(f);
I = readFrame(v); %video = read(v,1);

%I = imread('../Data/Capture.jpg');

% clockwise direction
%corners = [156, 248; 153, 188; 110, 212; 114, 270];

[sorted_corners1, id1, Tag1] = warpAndCheck(I, corners1);
[sorted_corners2, id2, Tag2] = warpAndCheck(I, corners2);
[sorted_corners3, id3, Tag3] = warpAndCheck(I, corners3);

% Part 2

L = imread('../Data/lena.png');
l_corners = [1, 1; 1, size(L,1); size(L,2), size(L,1); size(L,2), 1];

[L_on_I, H1] = homography(I, L, sorted_corners1, l_corners);
[L_on_I, H2] = homography(L_on_I, L, sorted_corners2, l_corners);
[L_on_I, H3] = homography(L_on_I, L, sorted_corners3, l_corners);

imshow(L_on_I);

%%%% Part 3
%%%% imshow(cube_on_I)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Form Intrinsic calibration
f = 630;
fx = 629.302552;
fy = 635.529018;
cx = 960; %330.766408; %960; %
cy = 540; %251.004731; %540; %

%Camera.k1: 0.128631
%Camera.k2: -0.604829
%Camera.p1: -0.000466h y
%Camera.p2: 0.000742

K = [fx, 0, cx;
     0, fy, cy;
     0,  0,  1];
%K = [fy, 0, cy;
%     0, fx, cx;
%     0,  0,  1];
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project Cube

points =  [sorted_corners2(:,1), sorted_corners2(:,2)];

sorted_corners2 = [points, ones(4,1)];

sorted_corners2 = ([1,0,0; 0,1,0]*(K \ sorted_corners2'))';

%sorted_corners2 = [sorted_corners2(:,2), sorted_corners2(:,1), ones(4,1)];
cube_points = [0, 0; 1, 0; 1, 1; 0, 1];

H = est_homography(cube_points, sorted_corners2);

points = [H*[cube_points, ones(4,1)]']';
points = points(:,1:2)./points(:,3);

render_points = 0.30*[0,0,1; 0,1,1; 1,1,1; 1,0,1; 0,0,2; 0,1,2; 1,1,2; 1,0,2];

[points, t, R] = ar_cube(H,render_points,K)

imshow(I)

for i = 1:size(points, 1)
    y = points(i,1);
    x = points(i,2);
    hold on; % Prevent image from being blown away.
    plot(x,y,'r+', 'MarkerSize', 10);
end

hold off
%imshow(overlayCube(I, sorted_corners2, K))

%im = insertShape(im, 'Line', [points_botlayer(1,1:2), points_toplayer(1,1:2)], 'LineWidth', 3, 'Color','white');



