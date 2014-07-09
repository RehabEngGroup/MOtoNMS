function T =  computeTorque(forces, moments, COP,fpInfo)
%INPUT: forces=[Fx Fy Fz]
%       moments=[Mx My Mz] in mm 
%       COP = [COPx,COPy,COPz]
%
%OUTPUT: T=[Tx Ty Tz] 
%refere to http://www.kwon3d.com/theory/grf/cop.html
%adapted for Force plate of type 3 from
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

Fx=forces(:,1);
Fy=forces(:,2);
Fz=forces(:,3);

Mx=moments(:,1);    
My=moments(:,2);
Mz=moments(:,3);

COPx=COP(:,1);    
COPy=COP(:,2);
COPz=COP(:,3);

%different meaning of origin among different FP type

if fpInfo.type==3   
    
    Tz = Mz - ((COPx).*Fy) + ((COPy).*Fx);
    
else
    
    ao=fpInfo.origin(1); %x
    bo=fpInfo.origin(2); %y
    co=fpInfo.origin(3); %z
    
    % Calculate Torque
    
    Tz = Mz - ((COPx - ao).*Fy) + ((COPy - bo).*Fx);
    
end

%Tz = Mz - ((COPx).*Fy) + ((COPy).*Fx);
Tx = zeros(1,length(COPx))';
Ty = Tx; % = 0

% convert to SI units (m) 
Tz = Tz/1000;
  
  
% Get rid of the NAN's (NAN is output when dividing by zero)
for j=1:length(COPx)
    if isnan(Tz(j))       
        Tz(j)=0;
    end
end

T= [Tx,Ty,Tz];