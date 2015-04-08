function rotatedDataOpenSim=rotatingMotionDirection(direction,data)
%
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
if iscell(direction)
    direction=direction{1};
end


switch lower(direction)
    
    case {'backward', '90left', '90right'}
        
        rotParam=defineMotionDirectionRotParamOpenSim(direction);
        
        rotatedDataOpenSim=RotateCS(data, rotParam);
        
    case {'forward', 'unconventional'} %no rotation in these cases
        
        rotatedDataOpenSim=data;
        
    otherwise
        
        disp(' ')
        error('ErrorTests:convertTest', ...
              ['----------------------------------------------------------------\nWARNING: WRONG motion direction! Motion directions for all trials MUST be selected among the following values: [forward, backward, 90left, 90right, unconvention]. \nPlease, refer to the user manual and check the acquisition.xml file']);
end