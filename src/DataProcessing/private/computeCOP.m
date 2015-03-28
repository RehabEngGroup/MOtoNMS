function COP =  computeCOP(forces, moments,fpInfo, pad)
% INPUT: forces=[Fx Fy Fz]
%        moments=[Mx My Mz] in mm 
%        pad=plate pad thickness in mm
%
% OUTPUT: COP=[COPx COPy COPz] in m
%
% refer to http://www.kwon3d.com/theory/grf/cop.html
% COPx = (-1*(My + co*Fx)./Fz) + ao;
% COPy =((Mx - (co*Fy))./Fz) + bo;
% COPz = zeros(length(COPx),1);
%
% refer to http://www.kwon3d.com/theory/grf/pad.html for pad addition
%
% adapted for FP type3 from 
% http://www.health.uottawa.ca/biomech/courses/apa6903/kistler.pdf

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

Fx=forces(:,1);
Fy=forces(:,2);
Fz=forces(:,3);

Mx=moments(:,1);    
My=moments(:,2);
Mz=moments(:,3);

%different meaning of fpInfo.origin according to FP type
%see C3D User Guide: http://www.c3d.org/pdf/c3dformat_ug.pdf  pag.91

if fpInfo.type==3 
    
    az0=fpInfo.origin(3);
    
    COPx = (-1*(My + (az0+pad)*Fx)./Fz);
    COPy =((Mx - ((az0+pad)*Fy))./Fz);
    COPz = zeros(length(COPx),1);
        
else
    ao=fpInfo.origin(1); %x
    bo=fpInfo.origin(2); %y
    co=fpInfo.origin(3); %z
    
    COPx = (-1*(My + (co-pad)*Fx)./Fz) + ao;
    COPy =((Mx - ((co-pad)*Fy))./Fz) + bo;
    COPz = zeros(length(COPx),1);
    
end
 
        
% Get rid of the NAN's (NAN is output when dividing by zero)
for j=1:length(COPx)
    if isnan(COPx(j))
        COPx(j)=0;
        COPy(j)=0;
    end
end
    

COP = [COPx,COPy,COPz];

    
   