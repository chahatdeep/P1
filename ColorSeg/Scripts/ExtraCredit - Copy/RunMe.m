clc;
clear;
close all;

colorSamples = colorDistribution();

ModelParams = estimate(colorSamples);

for i = 172:200
    filename = [sprintf('../../Images/TestSet/Frames/%d', i) '.jpg'];
    FrameID = imread(filename);
    [temp] = detectBuoy(FrameID, ModelParams);
    f = figure('Visible','off');
    imshow(temp)     
    filename = [sprintf('../../Output/ExtraCredit/Frames/%d', i) '.jpg'];
    saveas(f, filename)
end