
function COP =  computeCOP(forces, moments,fpInfo)
%forces=[Fx Fy Fz]
%moments=[Mx My Mz] in mm 

%OUTPUT: COP=[COPx COPy COPz] in m

%refere to http://www.kwon3d.com/theory/grf/cop.html
% COPx = (-1*(My + co*Fx)./Fz) + ao;
% COPy =((Mx - (co*Fy))./Fz) + bo;
% COPz = zeros(length(COPx),1);

%adapted for FP type3 from http://www.health.uottawa.ca/biomech/courses/apa6903/kistler.pdf

%Implemented by Alice Mantoan, August 2012, <alice.mantoan@dei.unipd.it>
%Last Update August 2013
% -------------------------------------------------------------------------

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
    
    COPx = (-1*(My + az0*Fx)./Fz);
    COPy =((Mx - (az0*Fy))./Fz);
    COPz = zeros(length(COPx),1);
        
else
    ao=fpInfo.origin(1); %x
    bo=fpInfo.origin(2); %y
    co=fpInfo.origin(3); %z
    
    COPx = (-1*(My + co*Fx)./Fz) + ao;
    COPy =((Mx - (co*Fy))./Fz) + bo;
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

    
   