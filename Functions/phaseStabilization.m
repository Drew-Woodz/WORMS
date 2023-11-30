function stabilizedVideo = phaseStabilization(videoObj)
    % Check if video object is valid
    if ~isobject(videoObj)
        error('The input is not a valid video object.');
    end

    % Getting the first frame and setting it as the reference frame
    videoObj.CurrentTime = 0;
    refFrame = readFrame(videoObj);
    refGray = rgb2gray(refFrame);

    % Creating a struct to hold the stabilized frames
    stabilizedFrames = struct('cdata', zeros(size(refFrame), 'uint8'), 'colormap', []);

    index = 0;
    while hasFrame(videoObj)
        index = index + 1;
        videoFrame = readFrame(videoObj);
        grayFrame = rgb2gray(videoFrame);

        % Computing the transformation to register the current frame to the reference frame
        tform = imregcorr(grayFrame, refGray, 'translation', Window = false);
        % tform = imregcorr(grayFrame, refGray, 'rigid', Window = false);
        % tform = imregcorr(grayFrame, refGray, 'similarity', Window = false);
        registered = imwarp(videoFrame, affine2d(tform.T), 'OutputView', imref2d(size(refFrame)));

        % Storing the stabilized frame in the struct
        stabilizedFrames(index).cdata = registered;
    end

    % Converting the struct back to a video object
    stabilizedVideo = VideoWriter('temp.avi', 'Uncompressed AVI');
    open(stabilizedVideo);

    for k = 1:length(stabilizedFrames)
        writeVideo(stabilizedVideo, stabilizedFrames(k).cdata);
    end

    close(stabilizedVideo);

    % Reading the written file to a video object to return
    stabilizedVideo = VideoReader('temp.avi');

end