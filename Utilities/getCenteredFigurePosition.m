% Find the size and center of the screen before creating the Figure
function pos = getCenteredFigurePosition(figWidth, figHeight)
    % Get the screen size
    screen_size = get(0, 'ScreenSize');

    % Calculate the desired width and height
    width = min(max(figWidth, 1350), screen_size(3));
    height = min(max(figHeight, 600), screen_size(4));

    % Calculate the left and bottom positions to center the figure
    left = (screen_size(3) - width) / 2;
    bottom = (screen_size(4) - height) / 2;

    pos = [left, bottom, width, height];
end