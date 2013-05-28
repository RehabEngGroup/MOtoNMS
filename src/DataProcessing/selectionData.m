function [DataSelected,time] = selectionData(filtData,AnalysisWindow,Rate,offset)
% Data selection according to the computed analysis window
% Rate: rate of filtData
% offset: for EMG selection in sec
% Implemented by Alice Mantoan, August 2012, <alice.mantoan@dei.unipd.it>
%--------------------------------------------------------------------------

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
    DataAnalysisWindow{k}.startFrame=((AnalysisWindow{k}.startFrame/(AnalysisWindow{k}.rate))-offset)*Rate;
    %conversion of endFrame into Rate
    DataAnalysisWindow{k}.endFrame=(AnalysisWindow{k}.endFrame/AnalysisWindow{k}.rate)*Rate;
    
    time{k}=[DataAnalysisWindow{k}.startFrame/Rate: 1/Rate: DataAnalysisWindow{k}.endFrame/Rate]';
    
    if length(size(filtData{k}))>2
        for i=1:size(filtData{k},3)
            
            %Data selection from filtData
            DataSelected{k}(:,:,i)=filtData{k}(DataAnalysisWindow{k}.startFrame:DataAnalysisWindow{k}.endFrame,:,i);
        end
    else
        DataSelected{k}=filtData{k}(DataAnalysisWindow{k}.startFrame:DataAnalysisWindow{k}.endFrame,:);
        
    end
end
