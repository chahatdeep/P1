function [im_training, im_test] = extract_frames(video,t)

vid=VideoReader(video); %Read Video
n = vid.NumberOfFrames; % Number of frames

% Get frames:
for i = 1:n
    frames = read(vid,i);
        imwrite(frames,['../Images/TrainingSet/Frames/' int2str(i), '.jpg']);
        im_training{} = frames
end

end
