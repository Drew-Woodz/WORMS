% Make a copy of the capture clip for use in the FFT overlay in Data Panel
function fft_overlay_video = copyVideoForOverlay(capture_video, fig)
    % Verify that the necessary UserData fields are set
    if ~isfield(fig.UserData, 'fft_overlay_play_pause_button') || ...
       ~isfield(fig.UserData, 'fft_overlay_play_slider')
        error('Required UserData fields are not set in fig.');
    end

    % Copy the video data for overlay purposes
    fft_overlay_video = capture_video; % This creates a copy of the capture video

    % Ensure that the video is stored as a 4D matrix if not already
    if ~isfield(fft_overlay_video, 'frames') || isempty(fft_overlay_video.frames)
        fft_overlay_video.frames = read(fft_overlay_video.reader);
    end
    
    % If additional processing on fft_overlay_video is required, do it here
    
    % Update the slider 'Max' property
    fig.UserData.fft_overlay_play_slider.Max = size(fft_overlay_video.frames, 4);
    % Set the slider 'Value' to 1 to start at the first frame
    fig.UserData.fft_overlay_play_slider.Value = 1;
   
    fig.UserData.fft_overlay_video = fft_overlay_video;
    % Call the update function to load the initial frame
    updateFFTVideoFrame(fig.UserData.fft_overlay_play_slider, fig.UserData.fft_overlay_play_pause_button);

    return;
end