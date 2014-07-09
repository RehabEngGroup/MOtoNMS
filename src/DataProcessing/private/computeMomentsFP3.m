function Moments=computeMomentsFP3(ForcesFP3, ForcePlatformInfo)
%Compute Moments for Force Platform of type 3
%Implemented formulae:  
%http://www.health.uottawa.ca/biomech/courses/apa6903/kistler.pdf

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
Fx12=ForcesFP3(:,1);
Fx34=ForcesFP3(:,2);
Fy14=ForcesFP3(:,3);
Fy23=ForcesFP3(:,4);
Fz1=ForcesFP3(:,5);
Fz2=ForcesFP3(:,6);
Fz3=ForcesFP3(:,7);
Fz4=ForcesFP3(:,8);

a=ForcePlatformInfo.origin(1);
b=ForcePlatformInfo.origin(2);

Mx=b*(Fz1+Fz2-Fz3-Fz4);

My=a*(-Fz1+Fz2+Fz3-Fz4);

Mz=b*(-Fx12+Fx34)+a*(Fy14-Fy23);

Moments=[Mx My Mz];