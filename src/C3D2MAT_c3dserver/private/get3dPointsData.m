 function Markers = get3dPointsData(itf, index1, index2)
% get3dPointsData - returns structure with markers data
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

% Modified by Alice Mantoan, Michele Vivian
% Last Updated: December 5, 2013

%%

if nargin == 1, 
    index1 = itf.GetVideoFrameHeader(0); % frame start
    index2 = itf.GetVideoFrameHeader(1); % frame end
end

 nIndex = itf.GetParameterIndex('POINT', 'LABELS');
 nItems = itf.GetParameterLength(nIndex);
 nIndex2 = itf.GetParameterIndex('POINT', 'LABELS2');
 nIndex3 = itf.GetParameterIndex('POINT', 'LABELS3');
 
 if nIndex2 ~= -1; 
     nItems2 = itf.GetParameterLength(nIndex2); 
 end
 
 if nIndex3 ~= -1; 
     nItems3 = itf.GetParameterLength(nIndex3); 
 end
 
 unitIndex = itf.GetParameterIndex('POINT', 'UNITS');
 rateIndex = itf.GetParameterIndex('POINT', 'RATE');
 
Values=[];

for i = 1 : nItems,
    target_name=itf.GetParameterValue(nIndex, i-1);
    target_name = itf.GetParameterValue(nIndex, i-1);
    % find any spaces
    d = findstr(target_name, ' ');
    if ~isempty(str2num(target_name))
       target_name = ['M' target_name];  
    end
    if ~isempty(d)
        target_name(d) = '_';
    end
    d = findstr(target_name, ':');
    if ~isempty(d)
        target_name = target_name(d+1:end);
    end
    newstring = target_name;
    if findstr('-', newstring) >= 1, 
        slashind = findstr('-', newstring); 
        newstring = [newstring(1:slashind-1) newstring(slashind+1:end)];
    end

   if strcmpi(newstring(1), '*'), newstring = ['C_' newstring(2:end)]; end
   if strcmpi(newstring(1), '$'), newstring = ['P_' newstring(2:end)]; end
   
   Labels{i}=newstring;
   
   x=cell2mat(itf.GetPointDataEx(i-1,0,index1,index2,'1'));
   y=cell2mat(itf.GetPointDataEx(i-1,1,index1,index2,'1'));
   z=cell2mat(itf.GetPointDataEx(i-1,2,index1,index2,'1'));
   
   Values=[Values x y z];
        
end 

if nIndex2 ~= -1
    for i = 1 : nItems2-1,
        target_name = itf.GetParameterValue(nIndex2, i-1);
        % find any spaces
        d = findstr(target_name, ' ');
        if ~isempty(str2num(target_name))
            target_name = ['M' target_name];
        end
        if ~isempty(d)
            target_name(d) = '_';
        end
        d = findstr(target_name, ':');
        if ~isempty(d)
            target_name = target_name(d+1:end);
        end
        newstring = target_name;
        if findstr('-', newstring) >= 1,
            slashind = findstr('-', newstring);
            newstring = [newstring(1:slashind-1) newstring(slashind+1:end)];
        end
        if strcmpi(newstring(1), '*'), newstring = ['U1_' newstring(2:end)]; end
        if strcmpi(newstring(1), '$'), newstring = ['P1_' newstring(2:end)]; end
        
        x=cell2mat(itf.GetPointDataEx(255+i-1,0,index1,index2,'1'));
        y=cell2mat(itf.GetPointDataEx(255+i-1,1,index1,index2,'1'));
        z=cell2mat(itf.GetPointDataEx(255+i-1,2,index1,index2,'1'));
        
        Values=[Values x y z];
       
    end
end

if nIndex3 ~= -1
    for i = 1 : nItems3-1,
        target_name = itf.GetParameterValue(nIndex3, i-1);
        % find any spaces
        d = findstr(target_name, ' ');
        if ~isempty(str2num(target_name))
            target_name = ['M' target_name];
        end
        if ~isempty(d)
            target_name(d) = '_';
        end
        d = findstr(target_name, ':');
        if ~isempty(d)
            target_name = target_name(d+1:end);
        end
        newstring = target_name;
        if findstr('-', newstring) >= 1,
            slashind = findstr('-', newstring);
            newstring = [newstring(1:slashind-1) newstring(slashind+1:end)];
        end
        if strcmpi(newstring(1), '*'), newstring = ['U2_' newstring(2:end)]; end
        if strcmpi(newstring(1), '$'), newstring = ['P2_' newstring(2:end)]; end
        
        x=cell2mat(itf.GetPointDataEx(510+i-1,0,index1,index2,'1'));
        y=cell2mat(itf.GetPointDataEx(510+i-1,1,index1,index2,'1'));
        z=cell2mat(itf.GetPointDataEx(510+i-1,2,index1,index2,'1'));
        
        Values=[Values x y z];
    end
end

nStartFrame = itf.GetVideoFrameHeader(0);
nEndFrame = itf.GetVideoFrameHeader(1);

if rateIndex > 0; Markers.Rate =double(itf.GetParameterValue(rateIndex, 0));end
Markers.Units = itf.GetParameterValue(unitIndex, 0);
Markers.RawData=Values;
Markers.Labels=Labels;
Markers.FirstFrame=nStartFrame;
Markers.LastFrame=nEndFrame;

