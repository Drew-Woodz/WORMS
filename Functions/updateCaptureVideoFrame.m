% Capture video frame update function
function updateCaptureVideoFrame(src, play_pause_button)
    fig = play_pause_button.Parent.Parent; % get the figure handle
    capture_video = fig.UserData.captureVideo; % fetch the capture video data
    capture_imh = fig.UserData.capture_imh;  % Get the image handle directly from UserData
    
    % Pause the capture video if it is playing
    if strcmp(play_pause_button.UserData, 'play')
        play_pause_button.UserData = 'pause';
        play_pause_button.String = 'Play'; % Change the button label to 'Play'
    end
    
    % Calculate frame index based on slider value
    frameIdx = round(src.Value);
    frameIdx = min(max(frameIdx, 1), capture_video.reader.NumFrames);  % Clamp frame index to valid range
    
    % Retrieve the corresponding frame from memory
    frame = capture_video.frames(:,:,:,frameIdx);

    % Update the capture time and frame display
    currentTime = (frameIdx - 1) / capture_video.reader.FrameRate;
    fig.UserData.capture_timebox.String = sprintf('Time: %.2f\n s, Frame: %d', currentTime, frameIdx);

    % Update the image handle
    capture_imh.CData = frame;
end
