function FPtoGlobalRotationsParameters = FPtoGlobalRotParameterStructCreator(FProtations)
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
RotX=0;
RotY=0;
RotZ=0;

for i=1:size(FProtations,2)
    
    ax=FProtations(i).Axis;  %axis already exist as Matlab command
    
    if length(ax)==0
        error('No FPtoGlobalRotationsParameters for the second force platform are defined in acquisition.xml file')
    end
        

    switch ax
        case 'X'
            
            RotX=i;
            
        case 'Y'
            
            RotY=i;
            
        case 'Z'
            
            RotZ=i;
    end
    
    degrees(i)=FProtations(i).Degrees;
end

%degrees size will be never bigger than 2 (maximum 2 rotations)...
Rot1=degrees(1);
%...but could be just 1 if there's no second rotation
if length(degrees)>1
    Rot2=degrees(2);
else
    Rot2=0;
end

FPtoGlobalRotationsParameters.RotX = RotX;
FPtoGlobalRotationsParameters.RotY = RotY;
FPtoGlobalRotationsParameters.RotZ = RotZ;
FPtoGlobalRotationsParameters.Rot1deg = Rot1;
FPtoGlobalRotationsParameters.Rot2deg = Rot2;