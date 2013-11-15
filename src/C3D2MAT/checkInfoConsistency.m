function [] = checkInfoConsistency(info,newInfo,tag)

switch tag
    
    case 'ForcePlatformInfo'
     
        nPlatforms=length(info);
        
        for i=1:nPlatforms
            
            checkLabels=find((info{i}.Label==newInfo{i}.Label)==0);
            checkType=find((info{i}.type==newInfo{i}.type)==0);
            checkCorners=find((info{i}.corners==newInfo{i}.corners)==0);
            checkOrigin=find((info{i}.origin==newInfo{i}.origin)==0);
            
            if (isempty(checkLabels)&& isempty(checkType) && isempty(checkCorners) && isempty(checkOrigin))
                return
            else
                disp(['Data Inconsistency: ForcePlatformInfo differs among trials (FP ' num2str(i) ')'])
            end
        end

    case 'Rates'
        if (isempty(info.VideoFrameRate) || isempty(info.AnalogFrameRate))
            disp('At least a frame rate empty')
        else
            if (info.VideoFrameRate==newInfo.VideoFrameRate && info.AnalogFrameRate==newInfo.AnalogFrameRate)
                return
            else
                disp('Data Inconsistency: Rates differs among trials')
            end
        end
        
    otherwise %info corresponds to labels (M or EMG)
       
        if length(info)==length(newInfo)   
            %check data length before comparison
            
            if (strcmp(info,newInfo))
                return
            else
                disp(['Data Inconsistency: ' tag ' differs from the already saved as common session info'])
            end
            
        else
            disp(['Warning: Number of ' tag ' is different from the already saved as common session info'])
        end
end