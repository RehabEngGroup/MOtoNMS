function [DataSelected,time] = selectionData(filtData,AnalysisWindow,Rate,offset)
% Data selection according to the computed analysis window
% Rate: rate of filtData
% offset: for EMG selection in sec

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

if nargin<4
    offset=0;
end


for k=1:length(filtData)
        
    OrigDataStartFrame=AnalysisWindow{k}.LabeledDataOffset+1;
     

    if AnalysisWindow{k}.startFrame==1
    %Case AnalysisWindow{k}.startFrame==1 requires to be handled separately:         
         %the subtraction of 1 to account for the time/frame shift causes 
         %problems to analog data with different frame rates, since in this  
         %case timeStartFrame has always to be set to 0 (it can not assume 
         %negative values), but within the same DataAnalyisWindow, the time
         %vector may have different sizes for data with different sample  
         %rates. Subtracting 1 at the VideoFrameRate, as done in the other 
         %cases, may cause the loss of AnalogData, which usually have an  
         %higher frame rate.        
         DataAnalysisWindow{k}.startFrame=1;
         
         if  AnalysisWindow{k}.LabeledDataOffset==0
               
             timeStartFrame=0;
         else
             timeStartFrame=round(((AnalysisWindow{k}.LabeledDataOffset)/AnalysisWindow{k}.rate-offset)*Rate); %the use of only LabeledDataOffset already includes the subtraction of 1            
         end

         timeEndFrame=round((((AnalysisWindow{k}.endFrame+AnalysisWindow{k}.LabeledDataOffset)/AnalysisWindow{k}.rate)-1/Rate)*Rate);
         
         %Time-Frame Conversions:
         %First, the AnalysisWindow's start and end frames are converted in  
         %time to substract the EMG offset (sec). Then they are reported in  
         %the rate of the given filtData (necessary because the rates of 
         %filtData may be different). The resulting timeStartFrame and 
         %timeEndFrame should correspond to values in the time vector,since 
         %they have been calculated in computeStancePhase.m based on the 
         %VideoFrameRate (which is the lowest frame rate)
         
     else
         
         DataAnalysisWindow{k}.startFrame=round(((AnalysisWindow{k}.startFrame)/AnalysisWindow{k}.rate-offset)*Rate);
             
         timeStartFrame=round((((AnalysisWindow{k}.startFrame+AnalysisWindow{k}.LabeledDataOffset-1)/AnalysisWindow{k}.rate)-offset)*Rate);       
         timeEndFrame=round((((AnalysisWindow{k}.endFrame+AnalysisWindow{k}.LabeledDataOffset-1)/AnalysisWindow{k}.rate))*Rate);    
         
         %Use of LabeledDataOffset: 
         %in the case of Manual method, DataAnalysisWindow already accounts 
         %for the LabeledDataOffset, since it has been subtracted in 
         %AnalysisWindowSelection.m.
         %Frames are referred to vectors length in all the other cases.
         %Thus, to write the corresponding original time and frames in .trc
         %and .mot files, LabeledDataOffset must always be added(regardless 
         %the Analysis Window Definition Method used)
     end
     
    DataAnalysisWindow{k}.endFrame=round((AnalysisWindow{k}.endFrame/AnalysisWindow{k}.rate)*Rate);
    
    %Time vector computation: 
    time{k}=[timeStartFrame/Rate: 1/Rate: timeEndFrame/Rate]';

    
    try      
        if length(size(filtData{k}))>2
            
            for i=1:size(filtData{k},3)
                
                %Data selection from filtData (based on DataAnalysisWindow)
                DataSelected{k}(:,:,i)=filtData{k}(DataAnalysisWindow{k}.startFrame:DataAnalysisWindow{k}.endFrame,:,i);
            end
        else
            DataSelected{k}=filtData{k}(DataAnalysisWindow{k}.startFrame:DataAnalysisWindow{k}.endFrame,:);
            
        end
    catch
        error('ErrorTests:convertTest', ...
            ['----------------------------------------------------------------\nWARNING: WRONG PARAMETERS SELECTION in the configuration file. \nAnalysis Window out of available data for trial ' num2str(k) '. \nPLEASE CHANGE method or frames of the analysis window for that trial in your configuration file and TRY again. \n----------------------------------------------------------------'])        
    end
end


