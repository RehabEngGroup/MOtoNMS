function [] = checkForcePlatformInfoConsistency(ForcePlatformInfo,newForcePlatformInfo)

nPlatforms=length(ForcePlatformInfo);

for i=1:nPlatforms
    
    checkLabels=find((ForcePlatformInfo{i}.Label==newForcePlatformInfo{i}.Label)==0);
    checkType=find((ForcePlatformInfo{i}.type==newForcePlatformInfo{i}.type)==0);
    checkCorners=find((ForcePlatformInfo{i}.corners==newForcePlatformInfo{i}.corners)==0);
    checkOrigin=find((ForcePlatformInfo{i}.origin==newForcePlatformInfo{i}.origin)==0);
    
    if (isempty(checkLabels)&& isempty(checkType) && isempty(checkCorners) && isempty(checkOrigin))
        return
    else
        disp('Data Inconsistency: ForcePlatformInfo differs among trials')
    end
end

