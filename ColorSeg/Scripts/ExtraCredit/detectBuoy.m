function [ temp ] = detectBuoy( FrameID, ModelParams )

% contourFrameID
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% Thresholds for probabilites
threshR = 0.001;
threshG = 0.005;
threshY = 0.0000001;

% Detect Red Buoy

FrameID_R_prob = zeros(size(FrameID,1), size(FrameID,2));
FrameID_G_prob = zeros(size(FrameID,1), size(FrameID,2));
FrameID_Y_prob = zeros(size(FrameID,1), size(FrameID,2));

meanR = ModelParams(1);
varianceR = ModelParams(2);
meanG = ModelParams(3);
varianceG = ModelParams(4);
meanY = ModelParams(5);
varianceY = ModelParams(6);

x = rgb2lab(FrameID);

xlab = rgb2lab(FrameID);

xycbcr = rgb2ycbcr(FrameID);

Cb = double(xycbcr(:,:,2));

b = double(xlab(:,:,3));

newCS = (134.0 - Cb).*b;

for i = 1: size(FrameID, 1)
    for j = 1: size(FrameID, 2)
        % Preprocessing
        
        xR = double(xlab(i,j,2)); %double(FrameID(i,j,1));
        xG = double(xlab(i,j,2)); %double(FrameID(i,j,2));
        xY = double(newCS(i,j)); %(double(FrameID(i,j,1))+double(FrameID(i,j,2)))/2;
        
        FrameID_R_prob(i,j) = exp(-((xR-meanR)^2)/(2*varianceR));
        FrameID_R_prob(i,j) = (1/(sqrt(2*pi*varianceR)))*FrameID_R_prob(i,j);
        
        FrameID_G_prob(i,j) = exp(-((xG-meanG)^2)/(2*varianceG));
        FrameID_G_prob(i,j) = (1/(sqrt(2*pi*varianceG)))*FrameID_G_prob(i,j);
        
        FrameID_Y_prob(i,j) = exp(-((xY-meanY)^2)/(2*varianceY));
        FrameID_Y_prob(i,j) = (1/(sqrt(2*pi*varianceY)))*FrameID_Y_prob(i,j);
        
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

temp = FrameID_R_prob;

imshow(FrameID_R_prob);
%imshow(FrameID)
tempR = bwmorph(FrameID_R_prob,'erode', 1);
tempG = bwmorph(FrameID_G_prob,'erode', 1);
tempY = bwmorph(FrameID_Y_prob,'erode', 1);

%temp = bwmorph(temp, 'dilate');
%imshow(temp);

FrameID_R_prob = tempR;
FrameID_G_prob = tempG;
FrameID_Y_prob = tempY;

%imshow(FrameID_R_prob);
imshow(FrameID);

%imshow(FrameID_Y_prob);

statsR = regionprops('table',FrameID_R_prob,'Centroid','MajorAxisLength','MinorAxisLength');
centersR = statsR.Centroid;
diametersR = (statsR.MinorAxisLength + statsR.MajorAxisLength)/2;
%mean([statsR.MajorAxisLength statsR.MinorAxisLength],2);
radiiR = diametersR./2;
hold on
viscircles(centersR,radiiR,'Color','r');
hold off

statsG = regionprops('table',FrameID_G_prob,'Centroid','MajorAxisLength','MinorAxisLength');
centersG = statsG.Centroid;
diametersG = mean([statsG.MajorAxisLength statsG.MinorAxisLength],2);
radiiG = diametersG./2;
hold on
viscircles(centersG,radiiG,'Color','g');
hold off

statsY = regionprops('table',FrameID_Y_prob,'Centroid','MajorAxisLength','MinorAxisLength');
centersY = statsY.Centroid;
diametersY = mean([statsY.MajorAxisLength statsY.MinorAxisLength],2);
radiiY = diametersY./2;
hold on
viscircles(centersY,radiiY,'Color','y');
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%baseFileName =  sprintf('../Output/Multiple_Lena/%d.jpg', i);
%fullFileName = fullfile(baseFileName); % or if you want to save in workspace, write name of the figure file you want to save. 

%%imwrite(f, fullFileName);
%saveas(f, temp);

saveas(f, '../../Output/Part0/Temp/I.jpg');  % here you save the figure

temp = imread('../../Output/Part0/Temp/I.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

