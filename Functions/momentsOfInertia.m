% Function for calculating the moments for motion correction
function moments = momentsOfInertia(videoFrames)

    % Get the dimensions of the frames and the total number of frames
    [height, width, ~, numFrames] = size(videoFrames);
    % Pre-allocate a matrix to store moments for each frame
    moments = zeros(numFrames, 3);    
    % x and y values of each pixel (center = 0)
    x = repmat((-floor(width/2):floor(width/2))', 1, height); 
    y = repmat(-floor(height/2):floor(height/2), width, 1); 
    
    % Transpose x and y to match the image coordinates
    x = x';
    y = y';
    
    % Create a mask to zero out the edge pixels
    mask = ones(height, width);
    mask(1:20,:) = 0; mask(end-19:end,:) = 0;
    mask(:,1:20) = 0; mask(:,end-19:end) = 0; 
    
    %     Debug
    %     disp(size(videoFrames(:,:,1,1)));  % Display the size of one frame
    %     disp(size(y));                     % Display the size of y
    %     disp(size(mask));                  % Display the size of mask

    % Apply the mask to x and y matrices
    x = x .* mask;
    y = y .* mask;
    
   
    % Loop through the pre-loaded video frames to calculate moments
    for i = 1:numFrames
        % Get the i-th frame from the pre-loaded video frames
        frame = videoFrames(:,:,:,i);
        
        % Validate if the frame is not empty
        if isempty(frame)
            warning(['Frame ' num2str(i) ' is empty.']);
            continue; % Skip to the next iteration
        end
    
        % Segment the image to get the binary mask
        BW = segmentImage(frame);
        
        % Apply the mask to the binary mask as well
        BW = BW .* mask;
            
        % Calculate the moments
        totalMass = sum(BW(:)); % Total number of white pixels
        moments(i,:) = [sum(sum(y .* BW))/totalMass, sum(sum(x .* BW))/totalMass, sum(sum(x .* y .* BW))/totalMass];
         
    end
    
end