% Callback for Render Button
function renderCallback(src, event)
    % Get the current figure handle
    fig = src.Parent.Parent;
    
    % Fetch the rectangle coordinates from the text boxes
    x1y1_str = fig.UserData.x1y1_textbox.String;
    x2y2_str = fig.UserData.x2y2_textbox.String;
    
    % Split the strings by comma to extract coordinates
    x1y1_coordinates = str2double(strsplit(x1y1_str, ','));
    x2y2_coordinates = str2double(strsplit(x2y2_str, ','));
    
    x1 = x1y1_coordinates(1);
    y1 = x1y1_coordinates(2);
    x2 = x2y2_coordinates(1);
    y2 = x2y2_coordinates(2);
    
    % Fetch the start and end frames
    start_frame = str2double(fig.UserData.start_frame_textbox.String);
    end_frame = str2double(fig.UserData.end_frame_textbox.String);

    % Fetch the original video data
    video = fig.UserData.video;

    % Ensure valid frame range
    if start_frame < 1 || end_frame > video.reader.NumFrames || start_frame > end_frame
        error('Invalid frame range specified.');
    end
    
    % Ensure valid ROI
    if x1 < 1 || x2 > size(video.frames, 2) || y1 < 1 || y2 > size(video.frames, 1) || x1 >= x2 || y1 >= y2
        error('Invalid region of interest specified.');
    end

    % Create a video writer object to write the new cropped video
    newVideoFilename = 'cropped_video.avi';
    v = VideoWriter(newVideoFilename);
    open(v);
    
    % Loop through the specified frame range
    for frameIdx = start_frame:end_frame
        % Extract the frame
        frame = video.frames(:,:,:,frameIdx);
        % Crop the frame based on the specified region
        croppedFrame = imcrop(frame, [x1 y1 x2-x1 y2-y1]);
        % Write the cropped frame to the new video file
        writeVideo(v, croppedFrame);
    end
    
    % Close the video writer object
    close(v);
        
    % Load the new cropped video into the capture_video slot
    capture_video = initializeVideoComponents(newVideoFilename);
    % disp(['Number of frames in capture video: ', num2str(capture_video.reader.NumFrames)]);
    capture_video.reader.CurrentTime = 0;

    % Fetch status of motion correction checkbox
    motionCorrectionEnabled = fig.UserData.motion_correct_checkbox.Value;
    
    % Check if the Motion Correction checkbox is checked
    if motionCorrectionEnabled == 1
        % Ensure the number of pixels in both width and height are odd
        [height, width, ~, ~] = size(capture_video.frames);
        if mod(width, 2) == 0
            capture_video.frames = capture_video.frames(:, 1:end-1, :, :); 
        end
        if mod(height, 2) == 0
            capture_video.frames = capture_video.frames(1:end-1, :, :, :);
        end
        
        % Get the moments of the frames
        moments = momentsOfInertia(capture_video.frames);

        % Get the stabilized frames
        stabilizedFrames = momentsStabilization(capture_video.frames, moments);
    
        % Replace the frames in the capture video with the stabilized ones
        capture_video.frames = stabilizedFrames;
    end
    
    fig.UserData.captureVideo = capture_video;


    % Update the slider's properties for the new video
    capture_sliderMax = max(2, capture_video.reader.NumFrames);
    fig.UserData.capture_play_slider.Max = capture_sliderMax;
    fig.UserData.capture_play_slider.Value = 1; % Reset to the first frame
    
    % Update the frame display
    fig.UserData.capture_timebox.String = sprintf('Frame: 1');

    % Update the capture video display with the first frame of the new video
    fig.UserData.capture_imh.CData = capture_video.firstFrame;  % Update the existing image handle
    axis(fig.UserData.capture_axes, 'tight'); % Reset the axes limits

end


