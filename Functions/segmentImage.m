% Segmentation helper function for moments of inertia function
function [BW,maskedImage] = segmentImage(X)
    % Check if the image is multi-channel and convert to grayscale if necessary
    if size(X, 3) > 1
        X = rgb2gray(X);  % Convert to grayscale
    end

    
    X = imflatfield(X, 30);
    % Adjust data to span data range.
    X = imadjust(X);
    
    % Threshold image with manual threshold
    BW = im2gray(X) > 150;
    
    % Erode mask with default
    radius = 2;
    decomposition = 0;
    se = strel('disk', radius, decomposition);
    BW = imerode(BW, se);
    
    % Dilate mask with default
    radius = 15;
    decomposition = 0;
    se = strel('disk', radius, decomposition);
    BW = imdilate(BW, se);
    
    % Fill holes
    BW = imfill(BW, 'holes');
    
    % Create masked image.
    maskedImage = X;
    maskedImage(~BW) = 0;
end
