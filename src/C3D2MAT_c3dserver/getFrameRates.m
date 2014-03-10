function [VideoFrameRate, AnalogFrameRate] = getFrameRates(itf)
%
% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2012-2014 Alice Mantoan, Monica Reggiani
%
% MOtoNMS is free software: you can redistribute it and/or modify it under 
% the terms of the GNU General Public License as published by the Free 
% Software Foundation, either version 3 of the License, or (at your option)
% any later version.
%
% Matlab MOtion data elaboration TOolbox for NeuroMusculoSkeletal applications
% is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
% without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
% PARTICULAR PURPOSE.  See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along 
% with MOtoNMS.  If not, see <http://www.gnu.org/licenses/>.
%
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%

VideoFrameRate = itf.GetVideoFrameRate;
analogVideoRatio = itf.GetAnalogVideoRatio;
AnalogFrameRate = VideoFrameRate * analogVideoRatio;

%From The C3D File Format User Guide:
%Note that a single ANALOG:RATE value applies to all analog channels – 
%the C3D file format requires that all analog channels be recorded at a 
%single rate. This means that if the C3D file is used to store analog data 
%from a variety of different sources, all analog signals must be sampled at 
%the rate required by the source with the highest frequency components.