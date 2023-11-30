% Update the fft overlay frame
function updateFFTVideoFrame(src, play_pause_button)
    fig = play_pause_button.Parent.Parent; % get the figure handle
    fft_overlay_video = fig.UserData.fft_overlay_video; % fetch the fft overlay video data

    
    fft_overlay_imh = fig.UserData.fft_overlay_imh;  % Get the image handle directly from UserData
    
    % Pause the capture video if it is playing
    if strcmp(play_pause_button.UserData, 'play')
        play_pause_button.UserData = 'pause';
        play_pause_button.String = 'Play'; % Change the button label to 'Play'
    end
    
    % Calculate frame index based on slider value
    frameIdx = round(src.Value);
    frameIdx = min(max(frameIdx, 1), fft_overlay_video.reader.NumFrames);  % Clamp frame index to valid range
    
    % Retrieve the corresponding frame from memory
    frame = fft_overlay_video.frames(:,:,:,frameIdx);

    % Update the capture time and frame display
    currentTime = (frameIdx - 1) / fft_overlay_video.reader.FrameRate;
    fig.UserData.fft_ovelay_timebox.String = sprintf('Time: %.2f\n s, Frame: %d', currentTime, frameIdx);

    % Add the thresholded overlay to the frame before drawing.
    % Retrieve the threshold value from the slider
    threshold_slider = findobj('Tag', 'threshold_slider');
    % Ensure threshold_slider is a valid object with the 'Value' property
    if isempty(threshold_slider) || ~isvalid(threshold_slider) || ~isprop(threshold_slider, 'Value')
        error('Threshold slider is not correctly defined or does not have a "Value" property.');
    end
    % fetch the fftData and normalize it
    maxValue = max(fig.UserData.fftData(:));
    normalized_fftData = fig.UserData.fftData / maxValue;
    fftFrameIndx = fig.UserData.fft_play_slider.Value;
    % Fetch the normalized fftData for the current frame
    fft_frame_data = normalized_fftData(:,:,fftFrameIndx);
    
    % Apply threshold to create the binary mask
    % Ensure fft_frame_data is a numeric array
    if ~isnumeric(fft_frame_data)
        error('fft_frame_data is not a numeric array.');
    end

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
    
    % Update the image handle
    fft_overlay_imh.CData = overlay_frame;
end