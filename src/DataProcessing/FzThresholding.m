function [thrForces, thrMoments] = FzThresholding(filtForces,filtMoments)

% for COP computation
% find when vertical forces drop below threshold, and then make
% all of the force and COP values 0.0 at these points
% refere to http://www.kwon3d.com/theory/grf/cop.html:
% CP position can be very sensitive to errors in the moment & force for a
% small Fz. This is why we get erroneous CP positions at the beginning and
% end of the foot contact phase where Fz is fairly small. A small error can
% be easily introduced during the zero-setting procedure if the system is 
% not well set up. For this reason,one needs to set the threshold for Fz.
% If Fz is smaller than the threshold, the program does not generate the
% CP coordinates.
% Implemented by Alice Mantoan, August 2012, <alice.mantoan@dei.unipd.it>
%--------------------------------------------------------------------------

% values are still in FP action based reference system
FPlateThreshold=-40;     %N: compromise between 20, 40 and 60 (all tested)
%the same threshold is used for ComputeStancePhase method
    
for k=1:length(filtForces)
    
    thrForces{k}=filtForces{k};
    thrMoments{k}= filtMoments{k};
    
    n_FP=size(filtForces{k},3);
    
    for i=1:n_FP
            
            force_zero=find(filtForces{k}(:,3,i) > FPlateThreshold);
            
            thrForces{k}(force_zero,:,i) = 0.0;
            thrMoments{k}(force_zero,:,i) = 0.0;          
    end
end