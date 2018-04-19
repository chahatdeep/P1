function [red,green,yellow] = readmultifiles
% Reading Green Bouy%
folder = '../../Images/TrainingSet/CroppedBuoys';
filePattern = fullfile(folder, 'g_*.jpg');
f=dir(filePattern);
files={f.name};
for k=1:numel(files)
    fullFileName = fullfile(folder, files{k});
    green{k}=imread(fullFileName);
end

% Reading Red Bouy%
folder = '../../Images/TrainingSet/CroppedBuoys';
filePattern = fullfile(folder, 'r_*.jpg');
f=dir(filePattern);
files={f.name};
for k=1:numel(files)
    fullFileName = fullfile(folder, files{k});
    red{k}=imread(fullFileName);
end

% Reading Yellow Bouy%
folder = '../../Images/TrainingSet/CroppedBuoys';
filePattern = fullfile(folder, 'y_*.jpg');
f=dir(filePattern);
files={f.name};
for k=1:numel(files)
    fullFileName = fullfile(folder, files{k});
    yellow{k}=imread(fullFileName);
end

end
