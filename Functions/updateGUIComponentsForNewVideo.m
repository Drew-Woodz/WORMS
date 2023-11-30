% Reset handles for new video
function updateGUIComponentsForNewVideo(fig, video)
    % Update the image handle with the first frame
    ax = findobj(fig, 'Type', 'axes', 'Parent', fig.UserData.ui.videoPanel.video_panel);
    cla(ax);
    fig.UserData.imh = imshow(video.firstFrame, 'Parent', ax);
    
    % Adjust slider properties for the new video
    fig.UserData.play_slider.Max = video.reader.NumFrames - 1;
    fig.UserData.play_slider.Value = 1;

    % Update the time and frame display
    fig.UserData.timebox.String = sprintf('Frame: 1');
end