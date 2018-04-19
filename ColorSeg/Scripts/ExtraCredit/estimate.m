function [ModelParams] = estimate( colorSamples )

RedBuoyData = double(cell2mat(colorSamples(1)));%/255.0;
GreenBuoyData = double(cell2mat(colorSamples(2)));%/255.0;
YellowBuoyData = double(cell2mat(colorSamples(3)));%/255.0;

colorSamplesR_LAB = RedBuoyData; %rgb2lab(RedBuoyData);
colorSamplesG_LAB = GreenBuoyData; %rgb2lab(GreenBuoyData);
colorSamplesY_LAB = YellowBuoyData; %rgb2lab(YellowBuoyData);

%disp( max(max(colorSamplesR_LAB(:,2))) )

colorSamplesR = colorSamplesR_LAB(:, 2); %RedBuoyData(:,1);
colorSamplesG = colorSamplesG_LAB(:, 2); %GreenBuoyData(:,2);
colorSamplesY = colorSamplesY_LAB(:, 1); %(YellowBuoyData(:,1)+YellowBuoyData(:,2))/2;

%For Red Buoy
meanR = mean(colorSamplesR);
std_devR = std(colorSamplesR);
varianceR = std_devR^2;
ModelParamsR = [meanR, varianceR];

%For Green Buoy
meanG = mean(colorSamplesG);
std_devG = std(colorSamplesG);
varianceG = std_devG^2;
ModelParamsG = [meanG, varianceG];


%For Yellow Buoy
meanY = mean(colorSamplesY);
std_devY = std(colorSamplesY);
varianceY = std_devY^2;
ModelParamsY = [meanY, varianceY];

%For final result
ModelParams = [ModelParamsR, ModelParamsG, ModelParamsY];

end

