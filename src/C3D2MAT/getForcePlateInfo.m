function INFO = getForcePlateInfo(itf)
% GETFORCEPLATEINFO - returns structure with the position of the corners of 
% the forceplates.  =
% 
%   USAGE:  INFO = getanalogchannels(itf, index1*, index2*)
%           * = not a necessary input
%   INPUTS:
%   itf         = variable name used for COM object
%   OUTPUTS:
%   INFO   = structure with corners of plate

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

 nIndex = itf.GetParameterIndex('FORCE_PLATFORM', 'CORNERS');
 usedIndex = itf.GetParameterIndex('FORCE_PLATFORM', 'USED');
 n_used = itf.GetParameterValue(usedIndex,0);
 OriginIndex = itf.GetParameterIndex('FORCE_PLATFORM', 'ORIGIN');
 INFO.Number = n_used;

for i = 1:n_used
    for j = 1:4
        channel_name = ['Corner' num2str(j) '_' num2str(i)];      
        INFO.(channel_name).X = itf.GetParameterValue(nIndex, ((i-1)*12)+((j-1)*3));
        INFO.(channel_name).Y = itf.GetParameterValue(nIndex, ((i-1)*12)+((j-1)*3)+1);
        INFO.(channel_name).Z = itf.GetParameterValue(nIndex, ((i-1)*12)+((j-1)*3)+2);
    end
    origin_name = ['Origin_' num2str(i)];
    INFO.(origin_name) = [itf.GetParameterValue(OriginIndex, ((i-1)*3)) ...
        itf.GetParameterValue(OriginIndex, ((i-1)*3)+1) itf.GetParameterValue(OriginIndex, ((i-1)*3)+2)];
end

%--------------------------------------------------------------------------