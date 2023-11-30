% Clear the ROI in capture panel button Callback
function captureClearROICallback(src, event)
    % Get the current figure handle
    fig = src.Parent.Parent;

    % If the ROI exists, delete it
    if isfield(fig.UserData, 'capture_roi') && isvalid(fig.UserData.capture_roi)
        delete(fig.UserData.capture_roi);
    end
end