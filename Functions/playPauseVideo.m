% Function for Video Panel play/pause action
function playPauseVideo(src, event, play_slider, timebox)
    fig = src.Parent.Parent; % get the figure handle

    video = fig.UserData.video; % fetch the video data
    imh = fig.UserData.imh;  % Get the image handle directly from UserData
    
    % Check if the button is currently set to 'play'
    if strcmp(src.UserData, 'play')
        % Set UserData to 'pause'
        src.UserData = 'pause';
        src.String = 'Play'; % Change the button label to 'Play'
        return; % Exit the function to ensure playback stops
    end
    
    % If the button was not set to 'play', proceed with playback:
    
    % Clear the drawn rectangle
    if isfield(fig.UserData, 'roi') && isvalid(fig.UserData.roi)
        delete(fig.UserData.roi);
    end

    % Reset the text boxes
    x1y1 = fig.UserData.x1y1_textbox;
    x2y2 = fig.UserData.x2y2_textbox;
    
    x1y1.String = 'X1,Y1';
    x2y2.String = 'X2,Y2';
    
    % Set UserData to 'play'
    src.UserData = 'play';
    src.String = 'Pause'; % Change the button label to 'Pause'
    
    % Ensure the calculated CurrentTime is within valid range
    newTime = max(0, (play_slider.Value - 1) / (video.reader.NumFrames - 1) * video.reader.Duration);
    video.reader.CurrentTime = min(newTime, video.reader.Duration - 1/video.reader.FrameRate);

    % Start playing the video
    while isvalid(src) && strcmp(src.UserData, 'play')
        % Read the next frame
        frameIdx = round(video.reader.CurrentTime * video.reader.FrameRate) + 1;
        frameIdx = min(max(frameIdx, 1), video.reader.NumFrames);  % Clamp frame index to valid range
                        
        % Retrieve the next frame from memory
        frame = video.frames(:,:,:,frameIdx);
    
        % Update the image handle
        imh.CData = frame;
        
        % Calculate the slider value
        slider_value = video.reader.CurrentTime / video.reader.Duration * (video.reader.NumFrames - 1) + 1;
        
        % Clamp the slider value to the valid range
        slider_value = min(max(slider_value, play_slider.Min), play_slider.Max);
        
        % Update the slider value and text box
        play_slider.Value = slider_value;
        timebox.String = sprintf('Frame: %d', round(slider_value));
        % disp(['Playing from Time: ', num2str(video.reader.CurrentTime), ' s, Frame: ', num2str(round(slider_value))]);

        
        % Allow time for GUI to update
        drawnow;
        pause(1 / video.reader.FrameRate);

        % Calculate the next frame's time
        nextFrameTime = video.reader.CurrentTime + 1/video.reader.FrameRate;
        
        % Check if the next frame's time exceeds the video's total duration
        if nextFrameTime >= video.reader.Duration
            video.reader.CurrentTime = 0; % Reset to the beginning if end is reached
        else
            video.reader.CurrentTime = nextFrameTime;
        end
        % pause(0.01); % Add a short pause after the drawnow
        
        % Restart the video if it reaches the end
        if ~hasFrame(video.reader)
            video.reader.CurrentTime = 0; % Reset to the beginning
        end
    end
end

