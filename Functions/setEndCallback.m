% Set endframe textbox callback function
function setEndCallback(src, event)
    % Get the current figure handle
    fig = src.Parent.Parent;
    sliderValue = round(fig.UserData.play_slider.Value); % Current frame index based on slider value
    end_frame_textbox = fig.UserData.end_frame_textbox;
    end_frame_textbox.String = sprintf('%d', sliderValue);
end