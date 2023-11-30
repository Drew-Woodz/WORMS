% Helper function to convert boolean to 'on'/'off'
function stateStr = boolToOnOff(stateBool)
    if stateBool
        stateStr = 'on';
    else
        stateStr = 'off';
    end
end