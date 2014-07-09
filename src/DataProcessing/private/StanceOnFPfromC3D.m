function StanceFPc3d = StanceOnFPfromC3D(Forces, platesList, WindowsSelectionInfo, DataOffset, Rates)
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

for k=1:length(Forces)
    
    Fz=Forces{k}(:,3,platesList{k});
    
    eventsFrame=[];
    hsFrame=[];
    foFrame=[];
    
    for j=1: size(WindowsSelectionInfo.Events{k},2)
        
        %consider only events which correspond to the choosen leg
        if (strmatch(WindowsSelectionInfo.Leg, WindowsSelectionInfo.Events{k}(j).context))

            frame=((WindowsSelectionInfo.Events{k}(j).frame-DataOffset{k})/Rates.VideoFrameRate)*Rates.AnalogFrameRate;
            
            %check for force data
            if Fz(frame)<-20
                eventsFrame=[eventsFrame WindowsSelectionInfo.Events{k}(j).frame];
                
                %check it is really a heel strike or toe off
                if (strmatch(WindowsSelectionInfo.Events{k}(j).label, WindowsSelectionInfo.Labels.HS))
                    
                    hsFrame=[hsFrame WindowsSelectionInfo.Events{k}(j).frame]; %should be only one, if more there are events with the same name
                
                else if (strmatch(WindowsSelectionInfo.Events{k}(j).label, WindowsSelectionInfo.Labels.FO))
                       
                        foFrame=[foFrame WindowsSelectionInfo.Events{k}(j).frame];
                    end
                end
            end
        end
    end
    
    %chek for possible errors in the system configuration
    
    if exist('frame','var')==0 %Events in .c3d files do not correspond to the choosen/instrumented leg
        
        error('ErrorTests:convertTest', ...
            '----------------------------------------------------------------\nWARNING: WRONG PARAMETERS SELECTION in the configuration file. \nEvents in .c3d files do not correspond to the choosen/instrumented leg. \nPLEASE check events definition in the configuration file and in your input files (modifications to c3d files require to re-run C3D2MAT.m!) or change analysis window method in your configuration file, and TRY again. \n----------------------------------------------------------------')
    end
    
    if (exist('eventsFrame','var') && length(eventsFrame)<2)  %Events in the c3d file do not correspond to force data
            
            error('ErrorTests:convertTest', ...
                '----------------------------------------------------------------\nWARNING: WRONG PARAMETERS SELECTION in the configuration file. \nEvents in the c3d file do not correspond to force data: Unable to compute stance on force plates. \nPLEASE check events definition in the configuration file and in your input files (modifications to c3d files require to re-run C3D2MAT!) or change analysis window method in your configuration file, and TRY again. \n----------------------------------------------------------------') 
    end
    
    if length(hsFrame)>1 %More than one foot strike with the same name
        error('ErrorTests:convertTest', ...
            '----------------------------------------------------------------\nWARNING: WRONG PARAMETERS SELECTION in the configuration file. \nMore than one foot strike with the same name. \nPLEASE check events labels in your c3d files (labels MUST be different each other) and in the configuration file, and TRY again. \n----------------------------------------------------------------')
    end
    
    if length(foFrame)>1 %More than one foot off strike with the same name
        error('ErrorTests:convertTest', ...
            '----------------------------------------------------------------\nWARNING: WRONG PARAMETERS SELECTION in the configuration file. \nMore than one foot off strike with the same name. \nPLEASE check events labels in your c3d files (labels MUST be different each other) and in the configuration file, and TRY again. \n----------------------------------------------------------------')
    end
    
    if  isempty(hsFrame) || isempty(foFrame) %Events do not correspond to the given labels for heel strike and/or foot off
        error('ErrorTests:convertTest', ...
            '----------------------------------------------------------------\nWARNING: WRONG PARAMETERS SELECTION in the configuration file. \nEvents do not correspond to the given labels for foot strike and/or foot off. \nPLEASE check events labels in your c3d files and in the configuration file, and TRY again. \n----------------------------------------------------------------')
    end

    % Definition of start and end frame for the stance phase from events
    % stored in the C3D files
    StanceFPc3d{k}.startFrame=hsFrame-DataOffset{k};
    StanceFPc3d{k}.endFrame=foFrame-DataOffset{k};
    StanceFPc3d{k}.rate=Rates.VideoFrameRate;
        
end
      