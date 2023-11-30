% Function for FFT overlay play/pause action
function playPauseFFToverlayVideo(src, event, fft_overlay_play_slider)

    fig = src.Parent.Parent; % get the figure handle
    % fetch the fftData and normalize it
    maxValue = max(fig.UserData.fftData(:));
    normalized_fftData = fig.UserData.fftData / maxValue;
    fftFrameIndx = fig.UserData.fft_play_slider.Value;
    % fftOverLayThresholdSlider = fig.UserData.fft_overlay_threshold_slider;
    
    % Fetch the FFT overlay video data
    fft_overlay_video = fig.UserData.fft_overlay_video;
    % Get the image handle for the FFT overlay video
    fft_overlay_imh = fig.UserData.fft_overlay_imh;
    
    % Check if the button is currently set to 'play'
    if strcmp(src.UserData, 'play')
        % Set UserData to 'pause', change button label, and exit function
        src.UserData = 'pause';
        src.String = 'Play';
        return;
    end
    
    % If not 'play', set to 'play', change button label, and start playback
    src.UserData = 'play';
    src.String = 'Pause';
    
    % Ensure the calculated CurrentTime is within valid range
    newTime = max(0, (fft_overlay_play_slider.Value - 1) / (fft_overlay_video.reader.NumFrames - 1) * fft_overlay_video.reader.Duration);
    fft_overlay_video.reader.CurrentTime = min(newTime, fft_overlay_video.reader.Duration - 1/fft_overlay_video.reader.FrameRate);

    % Start playing the video
    while isvalid(src) && strcmp(src.UserData, 'play')
        % Read the next frame
        frameIdx = round(fft_overlay_video.reader.CurrentTime * fft_overlay_video.reader.FrameRate) + 1;
        frameIdx = min(max(frameIdx, 1), fft_overlay_video.reader.NumFrames);  % Clamp frame index to valid range
                        
        % Retrieve the next frame from memory
        frame = fft_overlay_video.frames(:,:,:,frameIdx);
    
        % Add the thresholded overlay to the frame before drawing.
        % Retrieve the threshold value from the slider
        threshold_slider = findobj('Tag', 'threshold_slider');
        
        % Fetch the normalized fftData for the current frame
        fft_frame_data = normalized_fftData(:,:,fftFrameIndx);
        
        % Apply threshold to create the binary mask
        binary_mask = fft_frame_data >= threshold_slider.Value;
        
        % Create a mask where fftData is below the threshold (to keep the original values)
        mask = ~binary_mask;
        
        % Use logical indexing to directly modify the original frame's green and blue channels
        % where the mask is true (i.e., fftData is below the threshold)
        overlay_frame = frame;
        overlay_frame(:,:,2) = overlay_frame(:,:,2) .* uint8(mask);  % green channel
        overlay_frame(:,:,3) = overlay_frame(:,:,3) .* uint8(mask);  % blue channel
        
        % Now, set the red channel to 255 where the binary_mask is true (i.e., fftData is above the threshold)
        overlay_frame(:,:,1) = overlay_frame(:,:,1) .* uint8(mask) + uint8(binary_mask) * 255;  % red channel
        
        % Update the image handle with the overlay frame
        fft_overlay_imh.CData = overlay_frame;
        
        % Calculate the slider value
        slider_value = fft_overlay_video.reader.CurrentTime / fft_overlay_video.reader.Duration * (fft_overlay_video.reader.NumFrames - 1) + 1;
        
        % Clamp the slider value to the valid range
        slider_value = min(max(slider_value, fft_overlay_play_slider.Min), fft_overlay_play_slider.Max);
        
        % Update the slider value
        fft_overlay_play_slider.Value = slider_value;

        % Allow time for GUI to update
        drawnow;
        pause(1 / fft_overlay_video.reader.FrameRate);

        % Calculate the next frame's time
        nextFrameTime = fft_overlay_video.reader.CurrentTime + 1/fft_overlay_video.reader.FrameRate;
        
        % Check if the next frame's time exceeds the video's total duration
        if nextFrameTime >= fft_overlay_video.reader.Duration
            fft_overlay_video.reader.CurrentTime = 0; % Reset to the beginning if end is reached
        else
            fft_overlay_video.reader.CurrentTime = nextFrameTime;
        end

        pause(0.01); % Add a short pause after the drawnow
        
        % Update the frame display
        fig.UserData.fft_overlay_timebox.String = sprintf('Frame: %d', frameIdx);
        
        % Restart the video if it reaches the end
        if ~hasFrame(fft_overlay_video.reader)
            fft_overlay_video.reader.CurrentTime = 0; % Reset to the beginning
        end
    end
end