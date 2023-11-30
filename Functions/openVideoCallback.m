% Open Video Button Callback
function openVideoCallback(src, event)
    fig = src.Parent.Parent; % get the figure handle
    
    % Stop any ongoing video playback
    stopVideoPlayback(fig);
    
    [fi, pa] = uigetfile('*.*');
    if isequal(fi, 0) || isequal(pa, 0)
        return;  % User cancelled the file selection
    end

    clip_file = fullfile(pa, fi);
    
    % Check if video file exists
    if ~exist(clip_file, 'file')
        error(['The video clip file ' clip_file ' does not exist.']);
    end

    % Initialize video reader object
    video.reader = VideoReader(clip_file);
    
    % Reset video reader to the beginning
    video.firstFrame = readFrame(video.reader);

    % Load the video frames into memory
    video.frames = read(video.reader);
    
    % Update the video structure in UserData
    fig.UserData.video = video;

    % Update GUI components for the new video
    updateGUIComponentsForNewVideo(fig, video);
end