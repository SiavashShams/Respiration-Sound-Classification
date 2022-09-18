% CLASSIFYHEARTSOUNDS_CODEGEN_SCRIPT   Generate static library
%  classifyHeartSounds from classifyHeartSounds.
% 
% Script generated from project 'classifyHeartSounds.prj' on 14-Dec-2016.
% 
% See also CODER, CODER.CONFIG, CODER.TYPEOF, CODEGEN.
% Copyright 2017 The MathWorks, Inc.
%% Create configuration object of class 'coder.EmbeddedCodeConfig'.
cfg = coder.config('lib','ecoder',true);
cfg.GenerateCodeMetricsReport = true;
cfg.GenCodeOnly = true;   % if false, will generate .exe

%% Define argument types for entry-point 'classifyHeartSounds'.
ARGS = cell(1,1);
ARGS{1} = cell(2,1);
ARGS{1}{1} = coder.typeof(0,[Inf  1],[1 0]);
ARGS{1}{2} = coder.typeof(0);

%% Invoke MATLAB Coder.
% this version will generate mex file in current directory which is what
% the sample app requires (plotPredictions.m). Compiled individual files
% will be saved in codegen\mex
codegen -I .\HelperFunctions classifyHeartSounds -args ARGS{1} 

% this version generates c code meant for stand-alone apps. Compiled
% individual files will be saved in codegen\lib
%codegen -config cfg -I .\HelperFunctions classifyHeartSounds -args ARGS{1}
