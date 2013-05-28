
function COP =  computeCOP(forces, moments,fpInfo)
%forces=[Fx Fy Fz]
%moments=[Mx My Mz] in mm 

%OUTPUT: COP=[COPx COPy COPz] in m
%refere to http://www.kwon3d.com/theory/grf/cop.html

%Implemented by Alice Mantoan, August 2012, <alice.mantoan@dei.unipd.it>
% -------------------------------------------------------------------------

Fx=forces(:,1);
Fy=forces(:,2);
Fz=forces(:,3);

Mx=moments(:,1);    
My=moments(:,2);
Mz=moments(:,3);


ao=fpInfo.origin(1); %x
bo=fpInfo.origin(2); %y
co=fpInfo.origin(3); %z

% Calculate CoP 
    
COPx = (-1*(My + co*Fx)./Fz) + ao;
COPy =((Mx - (co*Fy))./Fz) + bo;
COPz = zeros(length(COPx),1);
        
% Get rid of the NAN's (NAN is output when dividing by zero)
for j=1:length(COPx)
    if isnan(COPx(j))
        COPx(j)=0;
        COPy(j)=0;
    end
end
    

COP = [COPx,COPy,COPz];

    
   