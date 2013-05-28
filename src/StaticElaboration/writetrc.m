function []= writetrc(markers,MLabels,VideoFrameRate,FullFileName)   

time=markers(:,1);
DataStartFrame=time(1)*VideoFrameRate;

%add frame column
frameArray=[time(1)*VideoFrameRate:time(end)*VideoFrameRate]';

markers=[frameArray markers];

nFrames=size(markers,1);
ncol=size(markers,2);
nMarkers=length(MLabels);


fid = fopen(FullFileName,'wt');
fprintf('\n------------------------------------------');
fprintf('\n      Printing marker trajectory file     ');
fprintf('\n------------------------------------------');

% Print header information
fprintf(fid,'PathFileType\t4\t(X/Y/Z)\t%s\n',FullFileName);
fprintf(fid,'DataRate\tCameraRate\tNumFrames\tNumMarkers\tUnits\tOrigDataRate\tDataStartFrame\n');
fprintf(fid, '%g\t%g\t%d\t%d\t%s\t%g\t%d\n', ...
    VideoFrameRate, VideoFrameRate, nFrames, nMarkers, 'mm', VideoFrameRate, DataStartFrame);
fprintf(fid,'Frame#\tTime');
for i = 1:nMarkers
    fprintf(fid,'\t%s\t\t%s',MLabels{i});
end
fprintf(fid,'\n\t\t');
for i = 1:nMarkers
    fprintf(fid,'X%d\tY%d\tZ%d\t',i,i,i);
end

fprintf(fid,'\n\n');

% Print data
for i= 1:nFrames
    for j=1:ncol
        if j == 1
            fprintf(fid,'%g\t',markers(i));
        else
            fprintf(fid,'%f\t',markers(i,j));
        end
    end
    fprintf(fid,'\n');
end

fclose(fid);