function [] = writeMot(grfOpenSim,time,fname)

 % Generate column labels for forces, COPs, and vertical torques.
% Order:  rGRF(xyz), rCOP(xyz), lGRF(xyz), lCOP(xyz), rT(xyz), lT(xyz)
label{1} = 'ground_force1_vx';
label{2} = 'ground_force1_vy';
label{3} = 'ground_force1_vz';
label{4} = 'ground_force1_px';
label{5} = 'ground_force1_py';
label{6} = 'ground_force1_pz';
label{7} = 'ground_force2_vx';
label{8} = 'ground_force2_vy';
label{9} = 'ground_force2_vz';
label{10} = 'ground_force2_px';
label{11} = 'ground_force2_py';
label{12} = 'ground_force2_pz';
label{13} = 'ground_torque1_x';
label{14} = 'ground_torque1_y';
label{15} = 'ground_torque1_z';
label{16} = 'ground_torque2_x';
label{17} = 'ground_torque2_y';
label{18} = 'ground_torque2_z';
forceIndex = length(label);

    
% Initialize 'motion file data matrix' for writing data of interest.
nRows = length(grfOpenSim);
nCols = length(label)+1;   % plus time
motData = zeros(nRows, nCols);

% Write time array to data matrix.
motData(:, 1) = time;

motData(:, 2:end) = grfOpenSim;          

% Open file for writing.
fid = fopen(fname, 'wt');

fprintf('\n------------------------------------------');
fprintf('\n      Printing mot file     ');
fprintf('\n------------------------------------------');

if fid == -1
    error(['unable to open ', fname])
end

% Write header.
fprintf(fid, 'name %s\n', fname);
fprintf(fid, 'datacolumns %d\n', nCols);
fprintf(fid, 'datarows %d\n', nRows);
fprintf(fid, 'range %d %d\n', time(1), time(nRows));
fprintf(fid, 'endheader\n\n');

% Write column labels.
fprintf(fid, 'time');
fprintf(fid,'\t');

for i = 1:nCols-1,
	fprintf(fid, '%20s\t', label{i});
end

% Write data.
for i = 1:nRows
    fprintf(fid, '\n'); 
	for j = 1:nCols
        if j == 1
            fprintf(fid,'%g\t', motData(i));
        else
            fprintf(fid, '%20.8f\t', motData(i, j));
        end
    end
end

fclose(fid);
return;