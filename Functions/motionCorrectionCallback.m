% Callback for motion correction checkbox
function motionCorrectionCallback(src, ~)
    fig = src.Parent.Parent;  % Find the parent figure of the callback's source
    fig.UserData.motion_correct_checkbox.Value = src.Value;
end