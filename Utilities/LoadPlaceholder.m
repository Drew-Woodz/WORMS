%% Load Placeholders %%

% Load the placeholder video
video_video = initializeVideoComponents('placeholder.avi');
capture_video = initializeVideoComponents('CapturePlaceHolder.avi');
fft_overlay_video = initializeVideoComponents('CapturePlaceHolder.avi');

% Store the video structure in the UserData of the figure
fig.UserData.video = video_video;
fig.UserData.captureVideo = capture_video;
fig.UserData.fft_overlay_video = fft_overlay_video;