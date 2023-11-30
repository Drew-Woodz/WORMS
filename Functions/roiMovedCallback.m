% This function is called whenever the ROI is moved
function roiMovedCallback(src, evt, fig)

    % Recompute the mask based on the new ROI position
    vertices = src.Position;
    videoFrame = fig.UserData.captureVideo.frames(:,:,:,1);
    vertices(:,1) = min(max(vertices(:,1), 1), size(videoFrame,2));
    vertices(:,2) = min(max(vertices(:,2), 1), size(videoFrame,1));
    mask = poly2mask(vertices(:,1), vertices(:,2), size(videoFrame,1), size(videoFrame,2));

    % Update the mask and the ROI in the figure's UserData
    fig.UserData.capture_mask = mask;
    fig.UserData.capture_roi = src; % Update the stored ROI

end