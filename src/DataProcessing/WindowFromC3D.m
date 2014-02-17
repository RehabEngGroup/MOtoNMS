function WindowC3D = WindowFromC3D(WindowsSelectionInfo, DataOffset, Rates)
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

for k=1:length(WindowsSelectionInfo.Events)
       
    eventFrames=[];

    for j=1: size(WindowsSelectionInfo.Events{k},2) %n di trials
        
        %consider only events which correspond to the choosen leg
        %if (strcmp(WindowsSelectionInfo.Leg, WindowsSelectionInfo.Events{k}(j).context))
            %Full label=context(right/left/general)+label
            eventFullLabel=[WindowsSelectionInfo.Events{k}(j).context,' ',WindowsSelectionInfo.Events{k}(j).label];
            %check labels
            if (strcmp(upper(eventFullLabel),upper(WindowsSelectionInfo.Labels.Start)) || strcmp(upper(eventFullLabel),upper(WindowsSelectionInfo.Labels.Stop)))
                
                eventFrames=[eventFrames WindowsSelectionInfo.Events{k}(j).frame];
            end       
     %   end
    end

    if isempty(eventFrames)
        error('Events in the c3d file do not correspond to the assigned labels.')
        
    else if length(eventFrames)>2
            
            error('More than 2 events with the assigned labels in the c3d file')
            
        else if length(eventFrames)<2
                error('Less than 2 events in the c3d file')               
            else
                [eord,ind]=sort(eventFrames);
                
                WindowC3D{k}.startFrame=eord(1)-DataOffset{k};
                WindowC3D{k}.endFrame=eord(2)-DataOffset{k};
                WindowC3D{k}.rate=Rates.VideoFrameRate;
                
            end
        end
    end
end
