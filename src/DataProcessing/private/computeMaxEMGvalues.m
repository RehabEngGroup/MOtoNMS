function [MaxEMG_frames, MaxEMG_trials, MaxEMGvalues] = computeMaxEMGvalues(EMGconsidered)
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

nTr=size(EMGconsidered,2);

for k=1:nTr
    %store max value and the corresponding frame for all muscles of trial k
    %[nTrials x nMuscle]
     [TrialMaxEMG(k,:), frames(k,:)] = max(EMGconsidered{k}); 
end

[MaxEMGvalues, MaxEMG_trials] = max(TrialMaxEMG,[],1);
%MaxEMG_trials, [1 x nMuscle], stores the trial in which the max among 
%trials occurs

nEMGs=size(MaxEMG_trials,2);
for j=1:nEMGs %for each muscle
    MaxEMG_frames(j)=frames(MaxEMG_trials(j),j);
end


