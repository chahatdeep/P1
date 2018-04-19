function [ temp ] = detectBuoy( FrameID, ModelParams )

%contourFrameID

%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

% Thresholds for probabilites
threshR = 0.00001; %1.0e-59;
threshG = 0.00001; %1.0e-80;
threshY = 0.001; %1.0e-180;

meanR = double(cell2mat(ModelParams(1)));
varianceR = double(cell2mat(ModelParams(2)));

meanG = double(cell2mat(ModelParams(3)));
varianceG = double(cell2mat(ModelParams(4)));

meanY = double(cell2mat(ModelParams(5)));
varianceY = double(cell2mat(ModelParams(6)));

detvR1 = det(varianceR(:,:,1)); detvR2 = det(varianceR(:,:,2)); detvR3 = det(varianceR(:,:,3));
detvR = [detvR1, detvR2, detvR3];

detvG1 = det(varianceG(:,:,1)); detvG2 = det(varianceG(:,:,2)); detvG3 = det(varianceG(:,:,3));
detvG = [detvG1, detvG2, detvG3];

detvY1 = det(varianceY(:,:,1)); detvY2 = det(varianceY(:,:,2)); detvY3 = det(varianceY(:,:,3)); detvY4 = det(varianceY(:,:,4)); 
detvY = [detvY1, detvY2, detvY3, detvY4];

%detvY = det(varianceY);

meanR = meanR';
meanG = meanG';
meanY = meanY';

invCovR = varianceR;
invCovR(:,:,1) = inv(varianceR(:,:,1));
invCovR(:,:,2) = inv(varianceR(:,:,2));
invCovR(:,:,3) = inv(varianceR(:,:,3));

invCovG = varianceG;
invCovG(:,:,1) = inv(varianceG(:,:,1));
invCovG(:,:,2) = inv(varianceG(:,:,2));
invCovG(:,:,3) = inv(varianceG(:,:,3));

invCovY = varianceY;
invCovY(:,:,1) = inv(varianceY(:,:,1));
invCovY(:,:,2) = inv(varianceY(:,:,2));
invCovY(:,:,3) = inv(varianceY(:,:,3));
invCovY(:,:,4) = inv(varianceY(:,:,4));

%invCovY = inv(varianceY);

FrameID_R_prob = zeros(size(FrameID,1), size(FrameID,2), size(meanR, 2) );
FrameID_G_prob = zeros(size(FrameID,1), size(FrameID,2), size(meanG, 2) );
FrameID_Y_prob = zeros(size(FrameID,1), size(FrameID,2), size(meanY, 2) );

FrameID_R_probf = zeros(size(FrameID,1), size(FrameID,2));
FrameID_G_probf = zeros(size(FrameID,1), size(FrameID,2));
FrameID_Y_probf = zeros(size(FrameID,1), size(FrameID,2));


x1 = rgb2lab(FrameID);

% nR = size(detvR);
% disp(nR)
% 
% nG = size(detvG);
% disp(nG)
% 
% nY = size(detvY);
% disp(nY)

disp(size(detvY))

for i = 1: size(FrameID, 1)
    for j = 1: size(FrameID, 2)
        
        x = double([x1(i,j,1), x1(i,j,2), x1(i,j,3)]');
        
        for k = 1: size(meanR, 2)
            FrameID_R_prob(i,j,k) = (1/(sqrt(((2*pi)^3)*detvR(k))))*exp(-(0.5)*((x-meanR(:,k))'*invCovR(:,:,k)*(x-meanR(:,k))));
            FrameID_R_probf(i,j) = FrameID_R_probf(i,j) + FrameID_R_prob(i,j,k);
        end
            
        for k = 1: size(meanG, 2)
            FrameID_G_prob(i,j,k) = (1/(sqrt(((2*pi)^3)*detvG(k))))*exp(-(0.5)*((x-meanG(:,k))'*invCovG(:,:,k)*(x-meanG(:,k))));
            FrameID_G_probf(i,j) = FrameID_G_probf(i,j) + FrameID_G_prob(i,j,k);
        end
        
        for k = 1: size(meanY, 2)
            FrameID_Y_prob(i,j,k) = (1/(sqrt(((2*pi)^3)*detvY(k))))*exp(-(0.5)*((x-meanY(:,k))'*invCovY(:,:,k)*(x-meanY(:,k))));
            FrameID_Y_probf(i,j) = FrameID_Y_probf(i,j) + FrameID_Y_prob(i,j,k);
        end
            
        if(FrameID_R_probf(i,j)>threshR)
            FrameID_R_probf(i,j) = 1;
        else
            FrameID_R_probf(i,j) = 0;
        end
        
        if(FrameID_G_probf(i,j)>threshG)
            FrameID_G_probf(i,j) = 1;
        else
            FrameID_G_probf(i,j) = 0;
        end
        
        if(FrameID_Y_probf(i,j)>threshY)
            FrameID_Y_probf(i,j) = 1;
        else
            FrameID_Y_probf(i,j) = 0;
        end
        
    end
end

% Contour detection

FrameID_R_prob = FrameID_R_probf;
FrameID_G_prob = FrameID_G_probf;
FrameID_Y_prob = FrameID_Y_probf;
 
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

