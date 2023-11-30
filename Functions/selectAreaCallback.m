function selectAreaCallback(src, event)
    % Get the current figure handle
    fig = src.Parent.Parent;
    
    % Pause the video if it's currently playing
    % stopVideoPlayback(fig);

    % If an old rectangle exists, delete it
    if isfield(fig.UserData, 'roi') && isvalid(fig.UserData.roi)
        delete(fig.UserData.roi);
    end

    % Ensure the current axes is the one displaying the video
    axes(fig.UserData.ui.videoPanel.video_axes); 

    % Let user draw a rectangle on the current video frame with thinner line
    h = drawrectangle('Parent', fig.UserData.ui.videoPanel.video_axes, 'LineWidth', 0.5); % Set line width to 0.5 for a thinner line
    
    
    % Store the rectangle handle for later use
    fig.UserData.roi = h;
    
    % Attach a callback to the rectangle for position changes
    addlistener(h, 'ROIMoved', @(src, event) updateTextBoxes(src, fig));

    % Update the text boxes with the rectangle's position
    updateTextBoxes(h, fig);
end