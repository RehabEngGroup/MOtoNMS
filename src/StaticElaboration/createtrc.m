function []= createtrc(MarkersFiltered,Mtime,MarkersLabels,extParameters,VideoFrameRate,FullFileName) 

% Rotate the marker data to a coordinate system that is consistent with
% OpenSIM, with y being the vertical axis, x-anterior, and z-to the
% right
rotatedMarkers=RotateCS(MarkersFiltered,extParameters);

%add time
CompleteMarkersData=[Mtime rotatedMarkers];

writetrc(CompleteMarkersData,MarkersLabels,VideoFrameRate,FullFileName)   