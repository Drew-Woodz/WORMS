% Set start frame textbox callback function
function setStartCallback(src, event)
    % Get the current figure handle
    fig = src.Parent.Parent;
    sliderValue = round(fig.UserData.play_slider.Value); % Current frame index based on slider value
    start_frame_textbox = fig.UserData.start_frame_textbox;
    start_frame_textbox.String = sprintf('%d', sliderValue);
end
