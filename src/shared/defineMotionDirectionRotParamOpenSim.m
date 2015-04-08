function motionDirectionRotations=defineMotionDirectionRotParamOpenSim(direction)
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

switch lower(direction)
    
    case 'backward'
        
        RotX = 0;
        RotY = 1;
        RotZ = 0;
        Rot1 = 180;
        Rot2 = 0;
        
        
    case '90right'
        
        RotX = 0;
        RotY = 1;
        RotZ = 0;
        Rot1 = -90;
        Rot2 = 0;
        
    case '90left'
        
        RotX = 0;
        RotY = 1;
        RotZ = 0;
        Rot1 = 90;
        Rot2 = 0;
        
        
end

motionDirectionRotations.RotX = RotX;
motionDirectionRotations.RotY = RotY;
motionDirectionRotations.RotZ = RotZ;
motionDirectionRotations.Rot1deg = Rot1;
motionDirectionRotations.Rot2deg = Rot2;