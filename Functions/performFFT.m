% Function to extract frequency information from selected roi 
% FFT Magic happens here
% Preprocessing happens here
function performFFT(fig)
    % Load the capture video and mask
    video = fig.UserData.captureVideo.frames;
    mask = fig.UserData.capture_mask;

    % Validate the mask dimensions
    if size(mask,1) ~= size(video,1) || size(mask,2) ~= size(video,2)
        error('Mask dimensions do not match video dimensions.');
    end

    % Convert the video to a 3D matrix using only the Green channel
    greenChannelVideo = squeeze(video(:,:,2,:));  % 3D matrix with time in 3rd dimension

    % Preprocess if needed
    if fig.UserData.preprocess_checkbox.Value
        % Retrieve preprocessing values
        kSize = fig.UserData.kernel_size_slider.Value;
        sharpenValue = fig.UserData.sharpen_slider.Value;
        backgroundSub = fig.UserData.background_sub_checkbox.Value;
    end
    
    % Apply the mask and preprocessing to each frame
    for i = 1:size(greenChannelVideo, 3)
        currentFrame = greenChannelVideo(:,:,i);
        currentFrame = currentFrame .* cast(mask, class(currentFrame));

        if fig.UserData.preprocess_checkbox.Value
            % Apply a filter using convolution
            if kSize > 0
                kernel = fspecial('average', [kSize kSize]);
                currentFrame = conv2(currentFrame, kernel, 'same');
            end

            % Sharpening
            if sharpenValue > 0
                currentFrame = imsharpen(currentFrame, 'Amount', sharpenValue);
            end

            % Background subtraction (if enabled)
            if backgroundSub
                currentFrame = currentFrame - mean(currentFrame(:));
            end
        end

        greenChannelVideo(:,:,i) = currentFrame;
    end

    % Perform FFT on the video along the time dimension
    fftData = abs(fft(greenChannelVideo, [], 3));

    % Compute the frequency range
    numFrames = size(greenChannelVideo, 3);
    fs = 30; % Sampling frequency (30 frames per second) [This should be inferred from clip if possible]
    freq = (0:numFrames-1) * fs / numFrames;

    % Retaining only the positive frequencies (first half of FFT data)
    fftData = fftData(:,:,1:ceil(numFrames/2));
    freq = freq(1:ceil(numFrames/2));

    % Filter out frequencies below 1 Hz
    validIndices = freq >= 1;
    fftData = fftData(:,:,validIndices);
    freq = freq(validIndices);

    % Store the FFT data and frequency range in the figure's UserData
    fig.UserData.fftData = fftData;
    fig.UserData.freq = freq;

    % Update FFT slider properties
    fft_sliderMax_new = size(fftData, 3);
    fftSlder = findobj(fig, 'Tag', 'fft_slider');
    if isempty(fftSlder)
        error('FFT slider with tag fft_slider not found.');
    end

    % Keep the user on the same frequency frame (or there abouts)
    currentFreqIdx = round(fftSlder.Value);
    currentFreq = fig.UserData.freq(currentFreqIdx);

    % Update slider range and value
    set(fftSlder, 'Min', 1, 'Max', fft_sliderMax_new, 'SliderStep', [1/(fft_sliderMax_new-1), 10/(fft_sliderMax_new-1)]);
    
    % Find the index of the frequency closest to the previously viewed frequency
    [~, frameIdx] = min(abs(fig.UserData.freq - currentFreq));
    set(fftSlder, 'Value', frameIdx);

    % Copy the current captureVideo for use in overlay
    fig.UserData.fft_overlay_video = copyVideoForOverlay(fig.UserData.captureVideo, fig);
   
    % Call updateFFTDisplay to update all visualizations
    updateFFTDisplay(fftSlder, [], fig);

end
