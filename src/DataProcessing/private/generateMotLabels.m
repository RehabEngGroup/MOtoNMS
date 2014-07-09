function label = generateMotLabels(nFP)
%Generation of mot file column labels depending on the number of FP
%Assumption: a max of 4 force plates, but more FP can be added
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

%%
switch nFP
    
    case 1
        
        label{1} = 'ground_force1_vx';
        label{2} = 'ground_force1_vy';
        label{3} = 'ground_force1_vz';
        label{4} = 'ground_force1_px';
        label{5} = 'ground_force1_py';
        label{6} = 'ground_force1_pz';
        label{7} = 'ground_torque1_x';
        label{8} = 'ground_torque1_y';
        label{9} = 'ground_torque1_z';
        
    case 2
        
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
        
        
    case 3
        
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
        label{13} = 'ground_force3_vx';
        label{14} = 'ground_force3_vy';
        label{15} = 'ground_force3_vz';
        label{16} = 'ground_force3_px';
        label{17} = 'ground_force3_py';
        label{18} = 'ground_force3_pz';
        label{19} = 'ground_torque1_x';
        label{20} = 'ground_torque1_y';
        label{21} = 'ground_torque1_z';
        label{22} = 'ground_torque2_x';
        label{23} = 'ground_torque2_y';
        label{24} = 'ground_torque2_z';
        label{25} = 'ground_torque3_x';
        label{26} = 'ground_torque3_y';
        label{27} = 'ground_torque3_z';
        
    case 4
        
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
        label{13} = 'ground_force3_vx';
        label{14} = 'ground_force3_vy';
        label{15} = 'ground_force3_vz';
        label{16} = 'ground_force3_px';
        label{17} = 'ground_force3_py';
        label{18} = 'ground_force3_pz';
        label{19} = 'ground_force4_vx';
        label{20} = 'ground_force4_vy';
        label{21} = 'ground_force4_vz';
        label{22} = 'ground_force4_px';
        label{23} = 'ground_force4_py';
        label{24} = 'ground_force4_pz';
        label{25} = 'ground_torque1_x';
        label{26} = 'ground_torque1_y';
        label{27} = 'ground_torque1_z';
        label{28} = 'ground_torque2_x';
        label{29} = 'ground_torque2_y';
        label{30} = 'ground_torque2_z';
        label{31} = 'ground_torque3_x';
        label{32} = 'ground_torque3_y';
        label{33} = 'ground_torque3_z';
        label{34} = 'ground_torque4_x';
        label{35} = 'ground_torque4_y';
        label{36} = 'ground_torque4_z';
    
    %ADD here case n if necessary
    
    otherwise
        label=[];
        disp(' ')
        disp('More than 4 force platforms: add labels for mot file generations in function generateMotLabels.m')
end

