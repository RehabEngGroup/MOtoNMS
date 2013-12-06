function INFO = getFPInfo(itf)
%
%   C3D directory contains C3DServer activation and wrapper Matlab functions.
%   This function written by Glen Lichtwark (Griffith University), but based 
%   on similar functions written by:
%   Matthew R. Walker, MSc. <matthewwalker_1@hotmail.com>
%   Michael J. Rainbow, BS. <Michael_Rainbow@brown.edu>
%   Motion Analysis Lab, Shriners Hospitals for Children, Erie, PA, USA
%   Questions and/or comments are most welcome.  
%   Last Updated by Glen Lichtwark: August 3rd, 2007
%   Created in: MATLAB Version 7.0.1.24704 (R14) Service Pack 1
%               O/S: MS Windows XP Version 5.1 (Build 2600: Service Pack 2)
%   
%   Please retain the author names, and give acknowledgement where necessary.  
%   DISCLAIMER: The use of these functions is at your own risk.  
%   The authors do not assume any responsibility related to the use 
%   of this code, and do not guarantee its correctness. 

% Modified by Alice Mantoan
% Last Updated: December 5, 2013

%%
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
 
