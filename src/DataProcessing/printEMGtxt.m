function [] = printEMGtxt(folder,time,EMGsData,EMGsLabels)
% Print filtered emg (envelope) in a .txt file
% Developed by Michele Vivian, July 2012
% Last version Alice Mantoan, April 2013

EMGtxt =[time EMGsData];

nRows = length(EMGtxt);
nCols = length(EMGsLabels)+1;   % plus time

fid = fopen([folder,'\emg.txt'], 'w');

fprintf(fid,'datacolumns %g\n',nCols); 
fprintf(fid,'datarows %g\n', nRows);

% Write column labels.
%fprintf(fid, '%20s\t', 'time');
fprintf(fid,'time');
fprintf(fid, '\t');
for i = 1:nCols-1,
	fprintf(fid, '%10s\t', EMGsLabels{i});
end

% Write data.
for i = 1:nRows
    fprintf(fid, '\n');
    for j=1:nCols
        if j == 1
            fprintf(fid,'%g\t',EMGtxt(i));
        else
            fprintf(fid,'%10f\t',EMGtxt(i,j));
        end
    end
end

fclose(fid);