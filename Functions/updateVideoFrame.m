% Function update Video Panel Frames
function updateVideoFrame(src, timebox, play_pause_button)
    fig = play_pause_button.Parent.Parent; % get the figure handle
    video = fig.UserData.video; % fetch the video data
    imh = fig.UserData.imh;  % Get the image handle directly from UserData
    
    % Pause the video if it is playing
    if strcmp(play_pause_button.UserData, 'play')
        play_pause_button.UserData = 'pause';
        play_pause_button.String = 'Play'; % Change the button label to 'Play'
    end
    
    % Calculate frame index based on slider value
    frameIdx = round(src.Value);
    frameIdx = min(max(frameIdx, 1), video.reader.NumFrames);  % Clamp frame index to valid range
    
    % Retrieve the corresponding frame from memory
    frame = video.frames(:,:,:,frameIdx);

    % Update the image handle
    imh.CData = frame;

    % Update the frame display
    timebox.String = sprintf('Frame: %d', frameIdx);

end