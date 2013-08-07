
function T =  computeTorque(forces, moments, COP,fpInfo)
%forces=[Fx Fy Fz]
%moments=[Mx My Mz] in mm 
%COP = [COPx,COPy,COPz]
%
%OUTPUT: T=[Tx Ty Tz] 
%refere to http://www.kwon3d.com/theory/grf/cop.html
%adapted for Force plate of type 3 from
%http://www.health.uottawa.ca/biomech/courses/apa6903/kistler.pdf
%Implemented by Alice Mantoan, August 2012, <alice.mantoan@dei.unipd.it>
%Last Update August 2013
% -------------------------------------------------------------------------

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

% convert to SI units (m) (done in convertToGlobal)
Tz = Tz/1000;
  
  
% Get rid of the NAN's (NAN is output when dividing by zero)
for j=1:length(COPx)
    if isnan(Tz(j))       
        Tz(j)=0;
    end
end

T= [Tx,Ty,Tz];