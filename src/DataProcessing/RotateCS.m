function rotated_Data2 = RotateCS (Data,rotParameters)
%Rotate Coordinate System

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
%
% Note: from an .m function developed by Thor Besier

%%

RotX = rotParameters.RotX;
RotY = rotParameters.RotY;
RotZ = rotParameters.RotZ;
Rot1 = rotParameters.Rot1deg;
Rot2 = rotParameters.Rot2deg;
% Rot180Y = rotParameters.rot180;
% NPointKinematics = rotParameters.numberPointKinematics;

%if the first rotation is null, there's no rotation at all
if (Rot1==0 || (Rot1==Rot2 && Rot2==0))  %Rot1==Rot2==0 is not corrected!
    rotated_Data2=Data;
    return
end

RotAboutX1 = [1,0,0;0,cos(Rot1*pi/180),-(sin(Rot1*pi/180));0,sin(Rot1*pi/180),cos(Rot1*pi/180)];
RotAboutY1 = [cos(Rot1*pi/180),0,sin(Rot1*pi/180);0,1,0;-(sin(Rot1*pi/180)),0,cos(Rot1*pi/180)];
RotAboutZ1 = [cos(Rot1*pi/180),-(sin(Rot1*pi/180)),0;sin(Rot1*pi/180),cos(Rot1*pi/180),0;0,0,1];
RotAboutX2 = [1,0,0;0,cos(Rot2*pi/180),-(sin(Rot2*pi/180));0,sin(Rot2*pi/180),cos(Rot2*pi/180)];
RotAboutY2 = [cos(Rot2*pi/180),0,sin(Rot2*pi/180);0,1,0;-(sin(Rot2*pi/180)),0,cos(Rot2*pi/180)];
RotAboutZ2 = [cos(Rot2*pi/180),-(sin(Rot2*pi/180)),0;sin(Rot2*pi/180),cos(Rot2*pi/180),0;0,0,1];

%Rot180AboutY = [cos(180*pi/180),0,sin(180*pi/180);0,1,0;-(sin(180*pi/180)),0,cos(180*pi/180)];

rotated_Data1 = [];
rotated_Data2 = [];
[nt,nc] = size(Data);

if rem(nc,3)
    error('Data columns must have 3 components each.');
end

if RotX == 1
    for I = 1:nc/3
        rotated_Data1(:,3*I-2:3*I) = [RotAboutX1'*Data(:,3*I-2:3*I)']';
    end
end
if RotY == 1
    for I = 1:nc/3
        rotated_Data1(:,3*I-2:3*I) = [RotAboutY1'*Data(:,3*I-2:3*I)']';
    end
end
if RotZ == 1
    for I = 1:nc/3
        rotated_Data1(:,3*I-2:3*I) = [RotAboutZ1'*Data(:,3*I-2:3*I)']';
    end
end


if Rot2 == 0    %if the second rotation is null return
    rotated_Data2= rotated_Data1;
    
else            %else rotate
    
    if RotX == 2
        for I = 1:nc/3
            rotated_Data2(:,3*I-2:3*I) = [RotAboutX2'*rotated_Data1(:,3*I-2:3*I)']';
        end
        return
    end
    if RotY == 2
        for I = 1:nc/3
            rotated_Data2(:,3*I-2:3*I) = [RotAboutY2'*rotated_Data1(:,3*I-2:3*I)']';
        end
        return
    end
    if RotZ == 2
        for I = 1:nc/3
            rotated_Data2(:,3*I-2:3*I) = [RotAboutZ2'*rotated_Data1(:,3*I-2:3*I)']';
        end
        return
    end
end

% if Rot180Y == 1
%     rotate = menu('Rotate Kinematics 180 degrees about OpenSim Y axis (direzione di avanzamento positiva o negativa?)?', 'Yes', 'No');
%     if rotate == 1
%         for I = 1:nc/3
%             rotated_Data2(:,3*I-2:3*I) = (Rot180AboutY*rotated_Data2(:,3*I-2:3*I)')';
%         end
%     end
% end