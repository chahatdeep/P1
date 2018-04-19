%% Extract images from a video sequence:

video_file_name = '../detectbuoy.avi';

test_images = 20;

[training, test] = extract_frames(video_file_name, test_images);

  