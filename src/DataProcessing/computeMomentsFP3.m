function Moments=computeMomentsFP3(ForcesFP3, ForcePlatformInfo)
%Compute Moments for Force Platform of type 3
%Implemented formulae:  http://www.health.uottawa.ca/biomech/courses/apa6903/kistler.pdf


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