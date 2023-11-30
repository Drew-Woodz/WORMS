% Updates all fft data displays when called
function updateFFTDisplay(src, ~, fig)

    % Extract min and max positions of the ROI
    roiMin = min(fig.UserData.capture_roi.Position);
    roiMax = max(fig.UserData.capture_roi.Position);

    % Set the axis limits based on the ROI
    axisLimits = [roiMin(1) roiMax(1) roiMin(2) roiMax(2)];

    % Get the current slider value and round it to an integer to get the frame index
    frameIdx = round(src.Value);
    frameIdx = min(frameIdx, size(fig.UserData.fftData, 3));

    % Fetch the fftData from the figure's UserData
    fftData = fig.UserData.fftData;

    % Fetch the frequency data from the figure's UserData
    freq = fig.UserData.freq;

    %
    averagedFFTData = squeeze(mean(mean(fftData, 1), 2));
    

    % Check if the current index is a peak
    if frameIdx > 1 && frameIdx < length(averagedFFTData) && ...
       averagedFFTData(frameIdx) > averagedFFTData(frameIdx - 1) && ...
       averagedFFTData(frameIdx) > averagedFFTData(frameIdx + 1)
        isPeak = true;
        [bestPeak, amp] = findPeak(freq, averagedFFTData, frameIdx);
    else
        isPeak = false;
    end

    % Display the FFT data as an image for the given frame index
    if isfield(fig.UserData, 'fft_axes')
        axes(fig.UserData.fft_axes);
        imagesc(fftData(:,:,frameIdx), 'Parent', fig.UserData.fft_axes);
        set(fig.UserData.fft_axes, 'CLim', [0, max(fftData(:))]);
        colormap(fig.UserData.fft_axes, jet);  % Set the colormap to 'jet'
        set(fig.UserData.fft_axes, 'XLim', axisLimits(1:2), 'YLim', axisLimits(3:4));
        
        cb = colorbar('peer', fig.UserData.fft_axes); % Add colorbar to fft_axes
        cb.Ticks = []; % Remove the tick labels from the colorbar
        title(sprintf('Frequency: %.2fHz', freq(frameIdx)));  % Label the frequency
        
        % set(fig.UserData.fft_axes, 'XLim', [roiMin(1), roiMax(1)], 'YLim', [roiMin(2), roiMax(2)]);
        set(fig.UserData.fft_axes, 'XTick', [], 'YTick', []); % Remove axis ticks and labels
        axis equal;
    else
        error('fft_axes not found in fig.UserData.');
    end

    % Update the data_axes with the averaged FFT data
    if isfield(fig.UserData, 'data_axes')
        axes(fig.UserData.data_axes);

        % Display PPM
        if isPeak
            plot(freq, averagedFFTData, 'LineWidth', 2);
            title('FFT Amplitude vs. Frequency');
            xlabel(sprintf('Frequency: %.2fHz\nPPM: %.2f', freq(frameIdx),bestPeak*60));
            ylabel('Amplitude');
        else
            plot(freq, averagedFFTData, 'LineWidth', 2);
            title('FFT Amplitude vs. Frequency');
            xlabel(sprintf('Frequency: %.2fHz\nPPM: %.2f', freq(frameIdx),freq(frameIdx)*60));
            ylabel('Amplitude');
        end

        % Find the maximum amplitude to determine y-axis limits
        maxAmplitude = max(averagedFFTData);
        amplitudeBuffer = 0.1 * maxAmplitude;  % 10% buffer above the maximum


        % Add a vertical line indicating the current frequency
        hold on;
        yLimits = [0, maxAmplitude + amplitudeBuffer];  % New y-axis limits with buffer
        ylim(yLimits);  % Apply the new y-axis limits
        plot([freq(frameIdx), freq(frameIdx)], yLimits, 'r--', 'LineWidth', 1.5);

        % Find amplitude at the current frequency
        amplitudeAtCurrentFreq = averagedFFTData(frameIdx);
        plot(freq(frameIdx), amplitudeAtCurrentFreq, 'ro');

        % Display the label in the top right corner of the plot
        if isPeak
            % Display both the actual frequency and the interpolated peak frequency
            peakLabel = sprintf('Freq: %.2fHz\nPeak Freq: %.2fHz\nAmp: %.2f', freq(frameIdx), bestPeak, amp);
        else
            % Display only the actual frequency
            peakLabel = sprintf('Freq: %.2fHz\nAmp: %.2f', freq(frameIdx), amplitudeAtCurrentFreq);
        end
        
        text('Units', 'normalized', 'Position', [0.95 0.95], 'String', peakLabel, ...
             'VerticalAlignment', 'top', 'HorizontalAlignment', 'right', ...
             'BackgroundColor', [0.8, 0.8, 0.8, 0.7], 'EdgeColor', 'black', 'LineWidth', 0.1, 'FontSize', 10);
        hold off;
    else
        error('data_axes not found in fig.UserData.');
    end
end
