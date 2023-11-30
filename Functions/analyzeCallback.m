% Analyze button callback function
function analyzeCallback(src, event)
    % Get the parent figure from the src input argument
    fig = src.Parent.Parent;

    % Check if a valid ROI exists in fig.UserData
    if isfield(fig.UserData, 'capture_roi') && isvalid(fig.UserData.capture_roi)
        performFFT(fig);
    else
        % Show an error notification to the user
        % indicating that an ROI needs to be selected first
        msgbox('Please select a Region of Interest (ROI) before analyzing.', 'Error', 'error');
    end
end