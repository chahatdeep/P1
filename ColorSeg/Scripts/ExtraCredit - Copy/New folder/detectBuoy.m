function [ temp ] = detectBuoy( FrameID, ModelParams )

%contourFrameID

%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% Thresholds for probabilites
threshR = 0.000001; %1.0e-59;
threshG = 0.000001; %1.0e-80;
threshY = 0.0001; %1.0e-180;

FrameID_R_prob = zeros(size(FrameID,1), size(FrameID,2));
FrameID_G_prob = zeros(size(FrameID,1), size(FrameID,2));
FrameID_Y_prob = zeros(size(FrameID,1), size(FrameID,2));

meanR = double(cell2mat(ModelParams(1)));
varianceR = double(cell2mat(ModelParams(2)));
meanG = double(cell2mat(ModelParams(3)));
varianceG = double(cell2mat(ModelParams(4)));
meanY = double(cell2mat(ModelParams(5)));
varianceY = double(cell2mat(ModelParams(6)));

detvR = det(varianceR);
detvG = det(varianceG);
detvY = det(varianceY);

meanR = meanR';
meanG = meanG';
meanY = meanY';

invCovR = inv(varianceR);
invCovG = inv(varianceG);
invCovY = inv(varianceY);

x1 = rgb2lab(FrameID);

for i = 1: size(FrameID, 1)
    for j = 1: size(FrameID, 2)
        
        x = double([x1(i,j,1), x1(i,j,2), x1(i,j,3)]');
        
        FrameID_R_prob(i,j) = (1/(sqrt(((2*pi)^3)*detvR)))*exp(-(0.5)*((x-meanR)'*invCovR*(x-meanR)));
        
        FrameID_G_prob(i,j) = (1/(sqrt(((2*pi)^3)*detvG)))*exp(-(0.5)*((x-meanG)'*invCovG*(x-meanG)));
        
        FrameID_Y_prob(i,j) = (1/(sqrt(((2*pi)^3)*detvY)))*exp(-(0.5)*((x-meanY)'*invCovY*(x-meanY)));
        
        if(FrameID_R_prob(i,j)>threshR)
            FrameID_R_prob(i,j) = 1;
        else
            FrameID_R_prob(i,j) = 0;
        end
        
        if(FrameID_G_prob(i,j)>threshG)
            FrameID_G_prob(i,j) = 1;
        else
            FrameID_G_prob(i,j) = 0;
        end
        
        if(FrameID_Y_prob(i,j)>threshY)
            FrameID_Y_prob(i,j) = 1;
        else
            FrameID_Y_prob(i,j) = 0;
        end
        
    end
end

% Contour detection

f = figure('Visible','off');

%imshow(FrameID_R_prob);
imshow(FrameID)

tempR = bwmorph(FrameID_R_prob,'erode', 1);
tempG = bwmorph(FrameID_G_prob,'erode', 1);
tempY = bwmorph(FrameID_Y_prob,'erode', 1);

%temp = bwmorph(temp, 'dilate');
%imshow(temp);

FrameID_R_prob = tempR;
FrameID_G_prob = tempG;
FrameID_Y_prob = tempY;

%temp = FrameID_G_prob;
%imshow(FrameID_R_prob);

statsR = regionprops('table',FrameID_R_prob,'Centroid','MajorAxisLength','MinorAxisLength');
centersR = statsR.Centroid;
diametersR = mean([statsR.MajorAxisLength statsR.MinorAxisLength],2);
radiiR = diametersR/2;
hold on
viscircles(centersR,radiiR,'Color','r');
hold off

statsG = regionprops('table',FrameID_G_prob,'Centroid','MajorAxisLength','MinorAxisLength');
centersG = statsG.Centroid;
diametersG = mean([statsG.MajorAxisLength statsG.MinorAxisLength],2);
radiiG = diametersG/2;
hold on
viscircles(centersG,radiiG,'Color','g');
hold off

statsY = regionprops('table',FrameID_Y_prob,'Centroid','MajorAxisLength','MinorAxisLength');
centersY = statsY.Centroid;
diametersY = mean([statsY.MajorAxisLength statsY.MinorAxisLength],2);
radiiY = diametersY/2;
hold on
viscircles(centersY,radiiY,'Color','y');
hold off

saveas(f, '../../Output/Part0/Temp/I.jpg');  % here you save the figure

temp = imread('../../Output/Part0/Temp/I.jpg');

%bw = FrameID_R_prob | FrameID_G_prob | FrameID_Y_prob;

% Save the binary images (it should have white blobs for each of the buoys) in
% Output/Part0/Frames/binary <FrameNo>.jpg.
%imwrite(FrameIDnew)

%Save the segmented images (input image with each buoy highlighted by corre-
%sponding color contours) in Output/Part0/Frames/output <FrameNo>.jpg.

%Save the plot of single 1-D Gaussian Model (for each of the buoy) in
%Output/Part0/<Color> 1gaussD.jpg (Color code - R (Red), G (Green) and Y (Yel-
%low) buoy).


end

