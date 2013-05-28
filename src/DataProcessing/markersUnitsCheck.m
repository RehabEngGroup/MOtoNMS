function [markersRawData] = markersUnitsCheck(markers)

if strcmp(markers.Units,'mm')
    markersRawData= double(markers.RawData);
    return
else
    if strcmp(markers.Units,'m')
        markersRawData= double(markers.RawData/1000);
    end
end