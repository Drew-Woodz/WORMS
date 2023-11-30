% Motion correction Function takes the moments and corrects the frame pos
function stabilizedFrames = momentsStabilization(videoFrames, moments)
    % Get the dimensions of the frames and the total number of frames
    [height, width, channels, numFrames] = size(videoFrames);
    
    % Pre-allocate a 4D array to store stabilized video frames
    stabilizedFrames = zeros(height, width, channels, numFrames, 'uint8');
    
    % Calculate the mean position based on moments
    meanX = mean(moments(:,2));
    meanY = mean(moments(:,1));

    % Smooth the moments to reduce jitter
    windowSize = 5; % Adjust as needed
    moments(:,1) = movmean(moments(:,1), windowSize);
    moments(:,2) = movmean(moments(:,2), windowSize);
    
    % Loop through each frame to apply the correction
    for i = 1:numFrames
        % Calculate the shift needed for x and y direction
        shiftX = round(meanX - moments(i,2));
        shiftY = round(meanY - moments(i,1));
        
        % Create a transformation structure
        tform = affine2d([1 0 0; 0 1 0; shiftX shiftY 1]);
        
        % Apply the transformation to the current frame
        outputView = imref2d([height, width]);
        stabilizedFrame = imwarp(videoFrames(:,:,:,i), tform, 'OutputView', outputView);
        
        % Store the stabilized frame in the pre-allocated 4D array
        stabilizedFrames(:,:,:,i) = uint8(stabilizedFrame);
    end
end