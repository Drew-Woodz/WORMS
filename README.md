```
###################################################################

██╗    ██╗ ██████╗ ███████╗ ███╗   ███╗███████╗
██║    ██║██╔═══██╗██╔═══██╗████╗ ████║██╔════╝
██║ █╗ ██║██║   ██║███████╔╝██╔████╔██║███████╗
██║███╗██║██║   ██║██║   ██╗██║╚██╔╝██║╚════██║
╚███╔███╔╝╚██████╔╝██║   ██║██║ ╚═╝ ██║███████║
 ╚══╝╚══╝  ╚═════╝ ╚═╝   ╚═╝╚═╝     ╚═╝╚══════╝
                                                

--WORMS ANALYSIS APPLICATION
By Andrew Lockwood
11/13/2023
andrew.lockwood578@myci.csuci.edu
Developed using MATLAB R2022b
Senior Capstone Project CSUCI
#################################################################
```

## Application Overview

The Worms Analysis Application is a MATLAB-based tool designed for scientists and researchers working in the field of microscopy. This particular version is designed for use in nematode research. This application facilitates the loading, processing, and analysis of microscopy videography, allowing for the selection of specific areas of interest and frames for detailed frequency domain examination. It is equipped with features for video preprocessing, motion correction, and Fourier Transform (FFT) analysis, making it a versatile tool for detecting and quantifying harmonic motion in said microscopy.

## Features
Motion Correction: 
Corrects for the motion of the subject within the video using ( and correcting for) the moments of the subjects, to ensure stable and accurate analysis.

### Video Preprocessing: 
Includes options for background subtraction, convolution, and other preprocessing methods.

### FFT Analysis and Frequency Visualization: 
Provides tools for conducting FFT analysis and visualizing frequency components in the video.

## Installation and Setup: 
Unzip WORMS into the desired Matlab workspace. The worms.m script along with all related subscripts and functions.

Run worms.m in MATLAB. This will launch a GUI in a figure window for interacting with the application.

Ensure that you have MATLAB installed with the necessary toolboxes for video processing. Use the latest version of Matlab for best results.

## Usage Instructions
**Open Video:** Begin by loading a video file of your subject, such as a nematode.

**Select Area of Interest:** Use the GUI to select a rectangular area of interest and specify the frame window (e.g., frames 1-90) for analysis.

**Press the Render button:** Create a clipped video in the capture panel when ready. (Area must be selected)

**Process Video:** In the capture panel, you can further specify an ROI using a polygon tool to mask specific pixels. "Select ROI button."

**Preprocessing:** If desired, choose from available preprocessing features, including background subtraction, convolution, and motion correction.

**Analysis and Visualization:** Use the Analyze button to perform FFT analysis on the processed video and visualize the frequency components. (ROI must be defined)
Use the threshold slider to increase or decrease the intensities of the selected frequency that you want overlayed on the clipped video for visualization.

**Troubleshooting Tips:** If you encounter any issues, we recommend restarting the application with a clean MATLAB workspace. This resolves 99% of common issues.

**Contact Information:** For support or feedback, please contact the author at: andrew.lockwood578@myci.csuci.edu

**Acknowledgments:** Special thanks to Dr. Brian Rasnow for endless technical guidance and invaluable support in developing this application. Additionally, we appreciate Dr. Willaim Barber's insights into digital image processing and his significant contributions to the motion correction methodology.
