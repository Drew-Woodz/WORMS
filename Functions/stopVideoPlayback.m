% Play Pause video helper function
function stopVideoPlayback(fig)
    play_pause_button = fig.UserData.play_pause_button;
    if strcmp(play_pause_button.UserData, 'play')
        play_pause_button.UserData = 'pause';
        play_pause_button.String = 'Play'; 
    end
end