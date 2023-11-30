% Callback to ensure the slider value is 0 or an odd integer starting from 3
function adjustKernelSlider(src, ~)
    % Get the parent figure of the callback's source
    fig = src.Parent.Parent;
    
    % Get the kernel size label from the figure's UserData
    kernel_size_label = fig.UserData.kernel_size_label;

    % The values we want to allow (0, 3, 5, 7, 9, 11)
    allowedValues = [0, 3, 5, 7, 9, 11];
    
    % Find the closest allowed value to the current slider value
    [~, idx] = min(abs(allowedValues - src.Value));
    currentValue = allowedValues(idx);
    
    % Set the slider value to the closest allowed value
    src.Value = currentValue;

    % Update the label's string to reflect the slider value
    kernel_size_label.String = ['Kernel Size: ', num2str(currentValue)];
end