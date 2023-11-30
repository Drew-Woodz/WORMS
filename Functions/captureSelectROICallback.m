% Set ROI in capture panel button Callback
function captureSelectROICallback(src, event)
    % Get the parent figure from the src input argument
    fig = src.Parent.Parent;
    % Pause the video
    capture_play_pause_button = fig.UserData.capture_play_pause_button;
    if strcmp(capture_play_pause_button.UserData, 'play')
        capture_play_pause_button.UserData = 'pause';
        capture_play_pause_button.String = 'Play';
    end

    % If a previous ROI exists, delete it
    if isfield(fig.UserData, 'capture_roi') && isvalid(fig.UserData.capture_roi)
        delete(fig.UserData.capture_roi);
    end

    % Allow the user to draw a region of interest (ROI) on the current frame
    hold on;
    roi = drawpolygon(fig.UserData.capture_axes, 'LineWidth', 0.5, 'Color', 'r');
    hold off;

    % Listen for the 'ROIMoved' event and specify the callback function
    addlistener(roi, 'ROIMoved', @(src, evt) roiMovedCallback(src, evt, fig));
  
    % Convert drawn ROI to a binary mask
    vertices = roi.Position;
    videoFrame = fig.UserData.captureVideo.frames(:,:,:,1);
    % Clamp the vertices to be within the video frame dimensions
    vertices(:,1) = min(max(vertices(:,1), 1), size(videoFrame,2));
    vertices(:,2) = min(max(vertices(:,2), 1), size(videoFrame,1));
    mask = poly2mask(vertices(:,1), vertices(:,2), size(videoFrame,1), size(videoFrame,2));


    % Store the mask and the ROI in the UserData for later use
    fig.UserData.capture_mask = mask;
    fig.UserData.capture_roi = roi; % Store the drawn ROI
end