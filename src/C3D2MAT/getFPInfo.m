function INFO = getFPInfo(itf)
% getFPInfo - returns structure with the position of the corners of 
% the forceplates.  =
% 
%   USAGE:  INFO = getanalogchannels(itf, index1*, index2*)
%           * = not a necessary input
%   INPUTS:
%   itf         = variable name used for COM object
%   OUTPUTS:
%   INFO   = structure with corners of plate, true origin and FP type
%   Taken from the two functions: getForcePlatformFromC3DParameters.m and
%   getForcePlateInfo.m

 nIndex = itf.GetParameterIndex('FORCE_PLATFORM', 'CORNERS');
 usedIndex = itf.GetParameterIndex('FORCE_PLATFORM', 'USED');
 n_used = itf.GetParameterValue(usedIndex,0);
 OriginIndex = itf.GetParameterIndex('FORCE_PLATFORM', 'ORIGIN');
 TypeIndex=itf.GetParameterIndex('FORCE_PLATFORM', 'TYPE');
 
 for i = 1:n_used
     
     INFO{i}.Label=i;
 
      INFO{i}.type=itf.GetParameterValue(TypeIndex,i-1);
     
     for j = 1:4
         
         INFO{i}.corners(j,:)=[ itf.GetParameterValue(nIndex, ((i-1)*12)+((j-1)*3)), ...
             itf.GetParameterValue(nIndex, ((i-1)*12)+((j-1)*3)+1),...
             itf.GetParameterValue(nIndex, ((i-1)*12)+((j-1)*3)+2)];
     end
     
     INFO{i}.origin = [itf.GetParameterValue(OriginIndex, ((i-1)*3)) ...
         itf.GetParameterValue(OriginIndex, ((i-1)*3)+1),...
         itf.GetParameterValue(OriginIndex, ((i-1)*3)+2)];
     
     
 end
 
 
%  INFO.Number = n_used;
%  
%  for i = 1:n_used
%      
%      INFO.type{i}=itf.GetParameterValue(TypeIndex,i-1);
%      
%      for j = 1:4
%          
%          INFO.corners{i}(j,:)=[ itf.GetParameterValue(nIndex, ((i-1)*12)+((j-1)*3)), ...
%              itf.GetParameterValue(nIndex, ((i-1)*12)+((j-1)*3)+1),...
%              itf.GetParameterValue(nIndex, ((i-1)*12)+((j-1)*3)+2)];
%      end
%      
%      INFO.origins{i} = [itf.GetParameterValue(OriginIndex, ((i-1)*3)) ...
%          itf.GetParameterValue(OriginIndex, ((i-1)*3)+1),...
%          itf.GetParameterValue(OriginIndex, ((i-1)*3)+2)];
%      
%      
%  end
 %--------------------------------------------------------------------------