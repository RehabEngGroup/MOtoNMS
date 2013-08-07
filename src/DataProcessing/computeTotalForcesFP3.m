function [Forces]=computeTotalForcesFP3(ForcesFP3)
%Total force computation for data from FP of type 3
%ForcesFP3=ForcesFP3{k}(:,:,i)=[F1x12 F1x34 F1y14 F1y23 F1z1 F1z2 F1z3 F1z4]
%reference: http://www.health.uottawa.ca/biomech/courses/apa6903/kistler.pdf

Fx12=ForcesFP3(:,1);
Fx34=ForcesFP3(:,2);
Fy14=ForcesFP3(:,3);
Fy23=ForcesFP3(:,4);
Fz1=ForcesFP3(:,5);
Fz2=ForcesFP3(:,6);
Fz3=ForcesFP3(:,7);
Fz4=ForcesFP3(:,8);

Fx=Fx12+Fx34;
Fy=Fy14+Fy23;
Fz=Fz1+Fz2+Fz3+Fz4;

Forces=[Fx Fy Fz];