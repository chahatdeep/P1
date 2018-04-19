function [ orientationCW, id, miniTag ] = ARTagDetector( Image )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
I = Image;
Xsize = size(I,1);
Ysize = size(I,2);

dX = Xsize/8;
dY = Ysize/8;

miniTag = zeros(8);

threshold = (dX*dY)/2;

for y = 1:8
    for x = 1:8
        M = I(((y-1)*dY + 1):y*dY, ((x-1)*dX + 1):x*dX);
        if( sum(sum(M)) > threshold )
            %White
            miniTag(y,x) = 1;
        else
            %Black
            miniTag(y,x) = 0;
        end
    end
end

% Align Tag Correctly
if(miniTag(6,6)==1)
    % All is well
    orientationCW = 0;
elseif(miniTag(6,3)==1)
    % Rotate clockwise by 270 degrees
    miniTag = imrotate(miniTag, 90);
    orientationCW = 90;
elseif(miniTag(3,3)==1)
    % Rotate clockwise by 180 degrees
    miniTag = imrotate(miniTag, 180);
    orientationCW = 180;
else
    % Rotate clockwise by 90 degrees
    miniTag = imrotate(miniTag, 270);
    orientationCW = 270;
end

id = miniTag(4:5,4:5);
id = id(1,1) + 2*id(1,2) + 4*id(2,2) + 8*id(2,1);

end

