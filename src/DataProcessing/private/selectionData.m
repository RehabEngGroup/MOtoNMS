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
    
    %Conversion in time to substract the offset(sec) and then startFrame is
    %expressed in the rate of the given filtData (necessary because rate of
    %filtData may be different): we are already sure start frame will be
    %included in the values of lower frequency time vector because it has
    %been calculated in computeStancePhase converting in VideoFrameRate
    %(that is the lowest)
    DataAnalysisWindow{k}.startFrame=round((AnalysisWindow{k}.startFrame/AnalysisWindow{k}.rate-offset)*Rate);
    %conversion of endFrame into Rate
    DataAnalysisWindow{k}.endFrame=round((AnalysisWindow{k}.endFrame/AnalysisWindow{k}.rate)*Rate);
    
    %Time vector computation:
    %In the case of Manual method, DataAnalysisWindow accounts for the 
    %LabeledDataOffset as it was subtract in AnalysisWindowSelection.m
    %For the other methods, frames are refered to vectors length
    %Thus, in order to write the corresponding original time and frames
    %in .trc and .mot files, LabeledDataOffset must be added and for
    %all the Analysis Window Definition Methods

    timeStartFrame=round(((AnalysisWindow{k}.startFrame+AnalysisWindow{k}.LabeledDataOffset-1)/AnalysisWindow{k}.rate-offset)*Rate);
    timeEndFrame=round(((AnalysisWindow{k}.endFrame+AnalysisWindow{k}.LabeledDataOffset-1)/AnalysisWindow{k}.rate)*Rate);
    
    time{k}=[timeStartFrame/Rate: 1/Rate: timeEndFrame/Rate]';
    
    try
        
        if length(size(filtData{k}))>2
            
            for i=1:size(filtData{k},3)
                
                %Data selection from filtData
                DataSelected{k}(:,:,i)=filtData{k}(DataAnalysisWindow{k}.startFrame:DataAnalysisWindow{k}.endFrame,:,i);
            end
        else
            DataSelected{k}=filtData{k}(DataAnalysisWindow{k}.startFrame:DataAnalysisWindow{k}.endFrame,:);
            
        end
    catch
        
        %error('Data selection not working: Analysis Window out of available data. Try to change method or frames of the analysis window')
        
        error('ErrorTests:convertTest', ...
            ['----------------------------------------------------------------\nWARNING: WRONG PARAMETERS SELECTION in the configuration file. \nAnalysis Window out of available data for trial ' num2str(k) '. \nPLEASE CHANGE method or frames of the analysis window for that trial in your configuration file and TRY again. \n----------------------------------------------------------------'])
        
    end
end


