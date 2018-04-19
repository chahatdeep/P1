function [ModelParams] = estimate( colorSamples )

RedBuoyData = double(cell2mat(colorSamples(1)));
GreenBuoyData = double(cell2mat(colorSamples(2)));
YellowBuoyData = double(cell2mat(colorSamples(3)));

options = statset('Display','final', 'MaxIter', 400);

objR = gmdistribution.fit(RedBuoyData,3,'Options',options);
objG = gmdistribution.fit(GreenBuoyData,3,'Options',options);
objY = gmdistribution.fit(YellowBuoyData,4,'Options',options);

covR = objR.Sigma;
covG = objG.Sigma;
covY = objY.Sigma;

PComponentsR = objR.PComponents;
PComponentsG = objG.PComponents;
PComponentsY = objY.PComponents;

meansR = objR.mu;
meansG = objG.mu;
meansY = objY.mu;


ModelParams = {meansR, covR, meansG, covG, meansY, covY };


% %For Red Buoy
% meanR = mean(colorSamplesR);
% varianceR = cov(colorSamplesR);
% 
% %For Green Buoy
% meanG = mean(colorSamplesG);
% varianceG = cov(colorSamplesG);
% 
% 
% %For Yellow Buoy
% meanY = mean(colorSamplesY);
% varianceY = cov(colorSamplesY);
% 
% %For final result
% ModelParams = {meanR, varianceR, meanG, varianceG, meanY, varianceY};

end

