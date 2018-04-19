clc;
clear;
close all;

colorSamples = colorDistribution();
ModelParams = estimate(colorSamples);

FrameID = imread('../../Images/TestSet/Frames/21.jpg');

[temp] = detectBuoy(FrameID, ModelParams);

%imshow(contourFrameID)

