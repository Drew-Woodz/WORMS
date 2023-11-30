% Create the Preprocess Checkbox callback function
function preprocessCheckboxCallback(src, ~, fig)
    % Get the state of the checkbox
    preprocessEnabled = src.Value;
    
    % Enable or disable the kernel size slider and label based on the checkbox state
    set(fig.UserData.kernel_size_slider, 'Enable', boolToOnOff(preprocessEnabled));
    set(fig.UserData.kernel_size_label, 'Enable', boolToOnOff(preprocessEnabled));
    
    % Enable or disable the sharpen slider and label based on the checkbox state
    set(fig.UserData.sharpen_slider, 'Enable', boolToOnOff(preprocessEnabled));
    set(fig.UserData.sharpen_label, 'Enable', boolToOnOff(preprocessEnabled));
    
    % Enable or disable the background subtraction checkbox based on the checkbox state
    set(fig.UserData.background_sub_checkbox, 'Enable', boolToOnOff(preprocessEnabled));
end