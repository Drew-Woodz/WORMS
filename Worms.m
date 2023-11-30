% WORMS version 8
% 11/20/2023
% Refer to README for usage instructions
%
%% Run me %%

% Get the full path of the current script
currentScript = mfilename('fullpath');

% Get the directory of the current script
[currentDir, ~, ~] = fileparts(currentScript);

% Construct paths to the function directories
functionsPath = fullfile(currentDir, 'Functions');
utilitiesPath = fullfile(currentDir, 'Utilities');

% Add these directories to the MATLAB path
addpath(functionsPath);
addpath(utilitiesPath);

InitUIPos;
InitPANEL;






















