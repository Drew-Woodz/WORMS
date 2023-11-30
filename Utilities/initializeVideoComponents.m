% Function to pre generate a video object before its been loaded
function video = initializeVideoComponents(filename)
    video = struct();
    video.filename = filename;
    video.reader = VideoReader(video.filename);
    video.frames = read(video.reader); % Load the entire video into memory
    video.reader.CurrentTime = 0;
    video.firstFrame = video.frames(:,:,:,1); % Use the first frame from the loaded video
end