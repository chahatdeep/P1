function [ overlayed ] = overlayCube(I, sorted_corners, K)

% Inputs: Homography Matrix, Intrinsic Calibration
% Output: Cube generated image

cube_corners = [ 0, 0; 0, 1; 1, 1; 1, 0 ];

[~, H ] = homography( I, zeros(100), sorted_corners, cube_corners );
% H is the homography matrix i.e. Image pixels = H * cube pixels

final_image = I;
for i = 0: 1
    for j = 0: 1
        image_coordinates = K * H * [ j, i, 1 ]';
        image_coordinates = floor(image_coordinates/image_coordinates(3));
        if(image_coordinates(2) < size(I,1) && image_coordinates(1) < size(I,2) &&...
           image_coordinates(2) > 1 && image_coordinates(1) > 1)
            final_image(image_coordinates(2),image_coordinates(1),:) = [255, 0, 0];
        end
    end
end

for i = 0: 1
    for j = 0: 1
        image_coordinates = K * H * [ j/2, i/2, 1 ]';
        image_coordinates = floor(image_coordinates/image_coordinates(3));
        if(image_coordinates(2) < size(I,1) && image_coordinates(1) < size(I,2) &&...
           image_coordinates(2) > 1 && image_coordinates(1) > 1)
            final_image(image_coordinates(2),image_coordinates(1),:) = [255, 0, 0];
        end
    end
end

overlayed = final_image;

end

