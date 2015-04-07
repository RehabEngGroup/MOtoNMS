function []= writetrc(markers,MLabels,VideoFrameRate,FullFileName)   
%
% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2012-2014 Alice Mantoan, Monica Reggiani
%
% MOtoNMS is free software: you can redistribute it and/or modify it under 
% the terms of the GNU General Public License as published by the Free 
% Software Foundation, either version 3 of the License, or (at your option)
% any later version.
%
% Matlab MOtion data elaboration TOolbox for NeuroMusculoSkeletal applications
% is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
% without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
% PARTICULAR PURPOSE.  See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along 
% with MOtoNMS.  If not, see <http://www.gnu.org/licenses/>.
%
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>
%
% Note: from an .m function developed by Thor Besier

%%

time=markers(:,1);
DataStartFrame=time(1)*VideoFrameRate+1;

%add frame column
frameArray=[(time(1)*VideoFrameRate+1):round(time(end)*VideoFrameRate+1)]';

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
