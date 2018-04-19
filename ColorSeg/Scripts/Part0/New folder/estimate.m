function [ModelParams] = estimate( colorSamples )

RedBuoyData = double(cell2mat(colorSamples(1)));
GreenBuoyData = double(cell2mat(colorSamples(2)));
YellowBuoyData = double(cell2mat(colorSamples(3)));

colorSamplesR = RedBuoyData(:,1);
colorSamplesG = GreenBuoyData(:,2);
colorSamplesY = (YellowBuoyData(:,1)+YellowBuoyData(:,2))/2;

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

