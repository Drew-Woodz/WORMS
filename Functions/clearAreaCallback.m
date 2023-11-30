% Clear select area button callback
function clearAreaCallback(src, event)
    % Get the current figure handle
    fig = src.Parent.Parent;

    % If the rectangle exists, delete it
    if isfield(fig.UserData, 'roi') && isvalid(fig.UserData.roi)
        delete(fig.UserData.roi);
    end

    % Reset the text boxes
    x1y1 = fig.UserData.x1y1_textbox;
    x2y2 = fig.UserData.x2y2_textbox;
    
    x1y1.String = 'X1,Y1'; % Default string indicating the expected format
    x2y2.String = 'X2,Y2'; % Default string indicating the expected format
end