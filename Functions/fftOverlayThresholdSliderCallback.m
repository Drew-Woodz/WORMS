% Callback function for the FFT overlay slider
function fftOverlayThresholdSliderCallback(src, ~, fig)
    % Get the slider value
    thresholdValue = get(src, 'Value');
    
    % Update the figure's UserData to store the threshold value
    fig.UserData.fft_overlay_threshold_slider.Value = thresholdValue;
    
    % You may need to refresh the video frame with the new threshold here

end
