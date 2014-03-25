function globalCOP = convertCOPToGlobal(localCOP,rotFP_glParameters,fpInfo)
%reactionGRF=[reactionF1{k} reactionCOP1{k} reactionF2{k} reactionCOP2{k} reactionT1{k}  reactionT2{k}]
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
%Rotation to Global
globalCOP = RotateCS (localCOP,rotFP_glParameters);

%Compute COP translation

corner1 = fpInfo.corners(1, :);
corner2 = fpInfo.corners(2, :);
corner3 = fpInfo.corners(3, :);
corner4 = fpInfo.corners(4, :);

%Origin of FP CS: assumed to be in the center 
FPcenter_lab = (corner1 + corner2 + corner3 + corner4)/4;

Xo_Offset=FPcenter_lab(1);
Yo_Offset=FPcenter_lab(2);
Zo_Offset=FPcenter_lab(3);


%COP translation (only for non zero values) + conversion in m
%non zero values of COP coordinates
COPxValues=find(globalCOP(:,1));
COPyValues=find(globalCOP(:,2));
COPzValues=find(globalCOP(:,3));

globalCOP(COPxValues,1)=(globalCOP(COPxValues,1)+Xo_Offset)/1000;
globalCOP(COPyValues,2)=(globalCOP(COPyValues,2)+Yo_Offset)/1000;
globalCOP(COPzValues,3)=(globalCOP(COPzValues,3)+Zo_Offset)/1000;

% Initially the offset was added for the whole COP
% globalCOP(:,1)=(globalCOP(:,1)+Xo_Offset)/1000;
% globalCOP(:,2)=(globalCOP(:,2)+Yo_Offset)/1000;
% globalCOP(:,3)=(globalCOP(:,3)+Zo_Offset)/1000;

