function C3Dopen(itf, fname)
% C3Dopen - loads a C3D file into the C3DServer domain.
% 
% USAGE: openc3d(itf, fname*)
%        * = not a necessary input
% INPUTS:
%   itf      = variable name used for COM object
%   fname    = filename, with or without path and c3d extension


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