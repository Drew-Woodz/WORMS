% Function to update area when area is moved
function updateTextBoxes(src, fig)
    % Get the position of the drawn rectangle
    pos = src.Position;
    
    % Calculate the coordinates
    x1 = round(pos(1));  % Rounding ensures we get an integer value
    y1 = round(pos(2));
    x2 = round(pos(1) + pos(3));
    y2 = round(pos(2) + pos(4));
    
    % Update the X1Y1 and X2Y2 text boxes with the rectangle's position
    x1y1 = fig.UserData.x1y1_textbox;
    x2y2 = fig.UserData.x2y2_textbox;
    
    x1y1.String = sprintf('%d,%d', x1, y1); % Updated to integer format
    x2y2.String = sprintf('%d,%d', x2, y2); % Updated to integer format
end