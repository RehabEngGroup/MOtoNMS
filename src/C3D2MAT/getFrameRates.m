function [VideoFrameRate, AnalogFrameRate] = getFrameRates(itf)

VideoFrameRate = itf.GetVideoFrameRate;
analogVideoRatio = itf.GetAnalogVideoRatio;
AnalogFrameRate = VideoFrameRate * analogVideoRatio;

%From The C3D File Format User Guide:
%Note that a single ANALOG:RATE value applies to all analog channels – 
%the C3D file format requires that all analog channels be recorded at a 
%single rate. This means that if the C3D file is used to store analog data 
%from a variety of different sources, all analog signals must be sampled at 
%the rate required by the source with the highest frequency components.