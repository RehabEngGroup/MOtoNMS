function C3Dopen(itf, fname)
% C3Dopen - loads a C3D file into the C3DServer domain.
%
%   C3D directory contains C3DServer activation and wrapper Matlab functions.
%   This function written by:
%   Matthew R. Walker, MSc. <matthewwalker_1@hotmail.com>
%   Michael J. Rainbow, BS. <Michael_Rainbow@brown.edu>
%   Motion Analysis Lab, Shriners Hospitals for Children, Erie, PA, USA
%   Questions and/or comments are most welcome.  
%   Last Updated: April 21, 2006
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

if nargin == 1 
    [fname, pname] = uigetfile('*.c3d', 'Choose a C3D-file:');
    file = [pname fname];
    
else
    dotind = findstr(fname,'.');
    
    if isempty(dotind) == 1
        fname = [fname '.c3d']; 
    end
    
    file = fname;
end

pRet = itf.Open(file,3);
 
if pRet == 0, 
    disp([file ' has been loaded.']); 
end