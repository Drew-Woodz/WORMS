% Function for Capture clips play/pause action
function playPauseCaptureVideo(src, event, capture_play_slider)
    fig = src.Parent.Parent; % get the figure handle

    capture_video = fig.UserData.captureVideo; % fetch the capture video data
    capture_imh = fig.UserData.capture_imh;  % Get the image handle directly from UserData
    
    % Check if the button is currently set to 'play'
    if strcmp(src.UserData, 'play')
        % Set UserData to 'pause'
        src.UserData = 'pause';
        src.String = 'Play'; % Change the button label to 'Play'
        return; % Exit the function to ensure playback stops
    end
    
    % If the button was not set to 'play', proceed with playback:
    
    % Set UserData to 'play'
    src.UserData = 'play';
    src.String = 'Pause'; % Change the button label to 'Pause'
    
    % Ensure the calculated CurrentTime is within valid range
    newTime = max(0, (capture_play_slider.Value - 1) / (capture_video.reader.NumFrames - 1) * capture_video.reader.Duration);
    capture_video.reader.CurrentTime = min(newTime, capture_video.reader.Duration - 1/capture_video.reader.FrameRate);

    % Start playing the video
    while isvalid(src) && strcmp(src.UserData, 'play')
        % Read the next frame
        frameIdx = round(capture_video.reader.CurrentTime * capture_video.reader.FrameRate) + 1;
        frameIdx = min(max(frameIdx, 1), capture_video.reader.NumFrames);  % Clamp frame index to valid range
                        
        % Retrieve the next frame from memory
        frame = capture_video.frames(:,:,:,frameIdx);
    
        % Update the image handle
        capture_imh.CData = frame;
        
        % Calculate the slider value
        slider_value = capture_video.reader.CurrentTime / capture_video.reader.Duration * (capture_video.reader.NumFrames - 1) + 1;
        
        % Clamp the slider value to the valid range
        slider_value = min(max(slider_value, capture_play_slider.Min), capture_play_slider.Max);
        
        % Update the slider value
        capture_play_slider.Value = slider_value;
        
        % Allow time for GUI to update
        drawnow;
        pause(1 / capture_video.reader.FrameRate);

        % Calculate the next frame's time
        nextFrameTime = capture_video.reader.CurrentTime + 1/capture_video.reader.FrameRate;
        
        % Check if the next frame's time exceeds the video's total duration
        if nextFrameTime >= capture_video.reader.Duration
            capture_video.reader.CurrentTime = 0; % Reset to the beginning if end is reached
        else
            capture_video.reader.CurrentTime = nextFrameTime;
        end

        pause(0.01); % Add a short pause after the drawnow
        
        % Update the frame display
        fig.UserData.capture_timebox.String = sprintf('Frame: %d', frameIdx);
        
        % Restart the video if it reaches the end
        if ~hasFrame(capture_video.reader)
            capture_video.reader.CurrentTime = 0; % Reset to the beginning
        end
    end
end