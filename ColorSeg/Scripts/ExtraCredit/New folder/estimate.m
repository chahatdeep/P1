function [ModelParams] = estimate( colorSamples )

RedBuoyData = double(cell2mat(colorSamples(1)));
GreenBuoyData = double(cell2mat(colorSamples(2)));
YellowBuoyData = double(cell2mat(colorSamples(3)));

colorSamplesR_LAB = RedBuoyData; %rgb2lab(RedBuoyData);
colorSamplesG_LAB = GreenBuoyData; %rgb2lab(GreenBuoyData);
colorSamplesY_LAB = YellowBuoyData; %rgb2lab(YellowBuoyData);

%disp( max(max(colorSamplesR_LAB(:,2))) )

colorSamplesR = colorSamplesR_LAB; %(:, 2); %RedBuoyData(:,1);
colorSamplesG = colorSamplesG_LAB; %(:, 2); %GreenBuoyData(:,2);
colorSamplesY = colorSamplesY_LAB; %(:, 3); %(YellowBuoyData(:,1)+YellowBuoyData(:,2))/2;

%For Red Buoy
meanR = mean(colorSamplesR);
varianceR = cov(colorSamplesR);

%For Green Buoy
meanG = mean(colorSamplesG);
varianceG = cov(colorSamplesG);


%For Yellow Buoy
meanY = mean(colorSamplesY);
varianceY = cov(colorSamplesY);

%For final result
ModelParams = {meanR, varianceR, meanG, varianceG, meanY, varianceY};

end

