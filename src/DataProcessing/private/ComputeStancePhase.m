function StancePhase = ComputeStancePhase(filtForces,platesList,FzThreshold,Rates)
% Method to compute start and end frame of the Analysis Window.
% It selects stance phase within gait cycle:
% start == heel strike
% end == toe off
%
% VideoFrameRate is needed to select a startFrame which correspond to a
% time instant sample in the lowest frame rate, otherwise  markers and
% forces may not be perfectly synchronized:with force frame rate there might
% be time samples which do not have an exact correspondence in video frame
% rate

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

VideoFrameRate=Rates.VideoFrameRate;
AnalogFrameRate=Rates.AnalogFrameRate;

for k=1:length(filtForces)
    
    FPused=platesList{k};
    
    if length(FPused)==1
        
        Fz=filtForces{k}(:,3,FPused);
        
        a = find(-Fz > FzThreshold);   %a(1) == heel strike in force rate
                                       %a(end) == toe off in force rate       
    else
        
        disp(['Wrong input platform data for trial' num2str(k) 'in the list: a stance should be computed from just one force platform data'])
        disp('If you want more, change Analysis window computation method')
        
        return
    end
    %conversion in video frame rate
    StancePhase{k}.startFrame=round(a(1)*(VideoFrameRate/AnalogFrameRate));
    StancePhase{k}.endFrame=round(a(end)*(VideoFrameRate/AnalogFrameRate)) ;
    StancePhase{k}.rate=VideoFrameRate;
    %rate store for each trial even if it is the same for all
    
    clear a    
end
   

