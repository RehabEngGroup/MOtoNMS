function globalToOpenSimRotations = globalToOpenSimRotParametersCreator(GlobalReferenceSystem)
%globalToOpenSimRotParametersCreator
%compute global to OpenSim Rotations Parameters
%
% Convention for global reference system:
% 1st axis: direction of motion
% 2nd axis: vertical axis
% 3rd axis: right hand rule
% Assumption:1st axis assumed to be in the same versus of OpenSim 1st axis,
% that should be the positive direction of motion

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
switch GlobalReferenceSystem
    
    case 'XYZ'       %OpenSim
        
        RotX = 0;
        RotY = 0;
        RotZ = 0;
        Rot1 = 0;
        Rot2 = 0;
               
    case 'XZY'      %UWA
        
        RotX = 1;
        RotY = 0;
        RotZ = 0;
        Rot1 = 90;
        Rot2 = 0;
               
    case 'ZYX'      %UNIPD
        
        RotX = 0;
        RotY = 1;
        RotZ = 0;
        Rot1 = -90;
        Rot2 = 0;        
               
    case 'ZXY'      
        
        RotX = 1;
        RotY = 0;
        RotZ = 2;
        Rot1 = -90;
        Rot2 = -90;
        
    case 'YXZ'      
        
        RotX = 0;
        RotY = 2;
        RotZ = 1;
        Rot1 = -90;
        Rot2 = 180;        
               
    case 'YZX'      
        
        RotX = 1;
        RotY = 2;
        RotZ = 0;
        Rot1 = 90;
        Rot2 = 90;        
end

globalToOpenSimRotations.RotX = RotX;
globalToOpenSimRotations.RotY = RotY;
globalToOpenSimRotations.RotZ = RotZ;
globalToOpenSimRotations.Rot1deg = Rot1;
globalToOpenSimRotations.Rot2deg = Rot2;
%globalToOpenSimRotations.rot180 = str2num(char(answer(6)));
%globalToOpenSimRotations.numberPointKinematics = str2num(char(answer(7)));

