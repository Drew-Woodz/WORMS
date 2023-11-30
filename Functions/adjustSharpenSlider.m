% Sharpen Slider callback function
function adjustSharpenSlider(src, ~)
    % Get the parent figure of the callback's source
    fig = src.Parent.Parent;
    
    % Get the sharpen label from the figure's UserData
    sharpen_label = fig.UserData.sharpen_label;

    % Get the current value of the sharpen slider
    currentValue = src.Value;

    % Update the label's string to reflect the slider value
    sharpen_label.String = ['Sharpen: ', num2str(currentValue, '%.2f')];
end