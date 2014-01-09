function StanceFPc3d = StanceOnFPfromC3D(Forces, platesList, WindowsSelectionInfo, DataOffset, Rates)
%
% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2013 Alice Mantoan, Monica Reggiani
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
    
    for j=1: size(WindowsSelectionInfo.Events{k},2)
        
        %consider only events which correspond to the choosen leg
        if (strmatch(WindowsSelectionInfo.Leg, WindowsSelectionInfo.Events{k}(j).context))

            frame=((WindowsSelectionInfo.Events{k}(j).frame-DataOffset{k})/Rates.VideoFrameRate)*Rates.AnalogFrameRate;
            
            if Fz(frame)<-20
                eventsFrame=[eventsFrame WindowsSelectionInfo.Events{k}(j).frame];
                
                %check it is really a heel strike or toe off
                if (strmatch(WindowsSelectionInfo.Events{k}(j).label, WindowsSelectionInfo.Labels.HS))
                    hsFrame=WindowsSelectionInfo.Events{k}(j).frame;
                else if (strmatch(WindowsSelectionInfo.Events{k}(j).label, WindowsSelectionInfo.Labels.FO))
                        foFrame=WindowsSelectionInfo.Events{k}(j).frame;
                    else
                        error('ErrorTests:convertTest', ...
                              '----------------------------------------------------------------\nWARNING: WRONG PARAMETERS SELECTION in the configuration file. \nEvents do not correspond to the given labels for heel strike and foot off. \nPLEASE check events labels in your c3d files and in the configuration file, and TRY again. \n----------------------------------------------------------------')
                    end
                end
                    
            end 
        end
    end

    if exist('frame','var')==0

        error('ErrorTests:convertTest', ...
            '----------------------------------------------------------------\nWARNING: WRONG PARAMETERS SELECTION in the configuration file. \nEvents in .c3d files do not correspond to the choosen/instrumented leg. \nPLEASE check events definition in the configuration file and in your input files (modifications to c3d files require to re-run C3D2MAT.m!) or change analysis window method in your configuration file, and TRY again. \n----------------------------------------------------------------')
        
    else if (exist('eventsFrame','var') && length(eventsFrame)<2)
               
        error('ErrorTests:convertTest', ...
            '----------------------------------------------------------------\nWARNING: WRONG PARAMETERS SELECTION in the configuration file. \nEvents in the c3d file do not correspond to force data: Unable to compute stance on force plates. \nPLEASE check events definition in the configuration file and in your input files (modifications to c3d files require to re-run C3D2MAT!) or change analysis window method in your configuration file, and TRY again. \n----------------------------------------------------------------')
            
        else
            StanceFPc3d{k}.startFrame=hsFrame-DataOffset{k};
            StanceFPc3d{k}.endFrame=foFrame-DataOffset{k};
            StanceFPc3d{k}.rate=Rates.VideoFrameRate;
            
        end
    end
end

          