function [ sorted_corners, id, miniTag ] = warpAndCheck( Image, corners )
%sorted corners indicate that the corners are in clockwise order and the
%top left corner is the first corner

%We make the assumption that the ARTag is square in shape and do a
%projection of the Image pixels to 200 x 200

threshold = 200;

gray = rgb2gray(Image);

s = 80;

y = corners(:, 1); 
x = corners(:, 2);
pseudocorners = [ 1, 1; 1, s; s, s; s, 1 ];
yp = pseudocorners(:, 1);
xp = pseudocorners(:, 2);

z = zeros(size(x)); o = ones(size(x));

ax = [-x, -y, -o, z, z, z, x.*xp, y.*xp, xp];
ay = [z, z, z, -x, -y, -o, x.*yp, y.*yp, yp];
A = [ax; ay];

%%%%
[U, S, V] = svd(A);
H = V(:,size(V,2))';
% Homography Calculation
H = [H(1:3); H(4:6); H(7:9)];

H_inv = inv(H);

test_image = zeros(s);
%imshow(test_image);

for row = 1:s %min(y):max(y)
    for column = 1:s %min(x):max(y)
        X_dash = [row; column; 1];
        X = H_inv * X_dash;
        X = floor(X/X(3));
        if(gray( X(2), X(1)) > threshold)
            %White
            test_image(row, column) = 1;
        else
            %Black
            test_image(row, column) = 0;
        end
        %test_image(row, column) = gray( X(2), X(1) );  
        %gray(X(2),X(1)) = 255;
    end
end

%imshow(gray);
%imshow(test_image);
test_image = im2bw(test_image);



[ orientationCW, id, miniTag ] = ARTagDetector( test_image );
%imshow(miniTag)

%imshow(miniTag)

if(orientationCW == 0)
    sorted_corners = corners;
elseif (orientationCW == 90)
    sorted_corners = [ corners(4,:); corners(1,:); corners(2,:); corners(3,:) ];
elseif (orientationCW == 180)
    sorted_corners = [ corners(3,:); corners(4,:); corners(1,:); corners(2,:) ];
elseif (orientationCW == 270)
    sorted_corners = [ corners(2,:); corners(3,:); corners(4,:); corners(1,:) ];
end

