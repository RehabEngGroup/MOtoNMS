function [RJC,LJC]=MidPoint(markers)
%JC Computation as Mid Point between two points
%
%DESCRIPTION
%INPUT
%markers = mat struct with required markers trajectories from static 
%          acquisition 
%Markers correspondence is obtained by order position and is defined in
%the choosen 'method'.xml file (ConfigurationFile folder) as below: 
%<Input>
%   <MarkerFullNames>
% 	   <Marker>Left First Point</Marker>
%      <Marker>Right First Point</Marker>
%      <Marker>Left Second Point</Marker>
%      <Marker>Right Second Point</Marker>
%   </MarkerFullNames>
%</Input>
%
%OUTPUT
%[RJC,LJC]=Right and Left Joint Center global position for each time istant

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

LJC=((markers{1}+markers{3})/2);
RJC=((markers{2}+markers{4})/2);