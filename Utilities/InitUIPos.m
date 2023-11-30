% Define positions for GUI elements [xPos, yPos, width, height]
% Video Panel
ui.videoPanel.video_panel_pos = [0 0 1/3 1];
    ui.videoPanel.video_axes_pos = [0.1, 0.3, 0.8, 0.6];
    ui.videoPanel.open_video_btn_pos = [0.01, 0.95, 0.15, 0.04];
    ui.videoPanel.x1y1_textbox_pos = [0.75, 0.2, 0.15, 0.04];
    ui.videoPanel.x2y2_textbox_pos = [0.75, 0.155, 0.15, 0.04];
    ui.videoPanel.set_start_btn_pos = [0.25, 0.2, 0.15, 0.04];
    ui.videoPanel.set_end_btn_pos = [0.25, 0.155, 0.15, 0.04];
    ui.videoPanel.start_frame_textbox_pos = [0.40, 0.2, 0.15, 0.04];
    ui.videoPanel.end_frame_textbox_pos = [0.40, 0.155, 0.15, 0.04];
    ui.videoPanel.render_btn_pos = [0.55, 0.155, 0.2, 0.04];
    ui.videoPanel.play_slider_panel_pos = [0.40, 0.245, 0.35, 0.04];
        ui.videoPanel.play_slider_pos = [0 0 1 1];
    ui.videoPanel.select_area_btn_pos = [0.75, 0.245, 0.15, 0.04];
    ui.videoPanel.timebox_pos = [0.0, 0.25, 0.25, 0.03];
    ui.videoPanel.motion_correct_text_pos = [0.0, 0.195, 0.2, 0.04];
    ui.videoPanel.motion_correct_checkbox_pos = [0.2, 0.2, 0.05, 0.04];
    ui.videoPanel.play_pause_button_pos =  [0.25, 0.245, 0.15, 0.04];
    ui.videoPanel.clear_area_btn_pos = [0.55, 0.2, 0.2, 0.04];

% Capture Panel
ui.capturePanel.capture_panel_pos = [1/3 0 1/3 1];
    ui.capturePanel.capture_axes_pos = [0.1, 0.6, 0.8, 0.35];
    ui.capturePanel.capture_slider_panel_pos = [0.40, 0.55, 0.35, 0.04];
        ui.capturePanel.capture_play_slider_pos = [0 1 1 1];
    ui.capturePanel.capture_play_pause_button_pos =  [0.25, 0.55, 0.15, 0.04];
    ui.capturePanel.capture_analyze_btn_pos = [0.25, 0.5, 0.15, 0.04]; 

    ui.capturePanel.capture_timebox_pos = [0.0, 0.55, 0.25, 0.03];
    ui.capturePanel.capture_select_roi_btn_pos = [0.40, 0.5, 0.15, 0.04];
    ui.capturePanel.capture_clear_roi_btn_pos = [0.55, 0.5, 0.15, 0.04]; 
    ui.capturePanel.fft_axes_pos = [0.1, 0.1, 0.8, 0.30];
    ui.capturePanel.fft_slider_panel_pos = [0.2, 0.05, 0.50, 0.04];
        ui.capturePanel.fft_play_slider_pos = [0 0 1 1];

    ui.capturePanel.preprocess_checkbox_pos = [0.025, 0.505, 0.2, 0.03];
    ui.capturePanel.kernel_size_label_pos = [0.0, 0.47, 0.2, 0.03];
    ui.capturePanel.kernel_size_slider_pos = [0.025, 0.45, 0.2, 0.02];
    ui.capturePanel.sharpen_slider_label_pos = [0.52, 0.47, 0.25, 0.03];
    ui.capturePanel.sharpen_slider_pos = [0.52, 0.45, 0.25, 0.02];
    ui.capturePanel.background_sub_checkbox_pos = [0.25, 0.45, 0.25, 0.04];

    ui.capturePanel.fft_overlay_threshold_slider_pos = [0.90, 0.1, 0.05, 0.30];

% Data Panel
ui.dataPanel.data_panel_pos = [2/3 0 1/3 1];
    ui.dataPanel.data_axes_pos = [0.2, 0.65, 0.6, 0.3];
    ui.dataPanel.data_fft_axes_pos = [0.1, 0.08, 0.8, 0.40]; % Below the capture video
    ui.dataPanel.fft_overlay_play_pause_button_pos = [0.30, 0.01, 0.15, 0.04];
    ui.dataPanel.fft_overlay_slider_panel_pos = [0.45, 0.01, 0.35, 0.04];
    ui.dataPanel.fft_overlay_timebox_pos = [0.05, 0.02, 0.25, 0.03];