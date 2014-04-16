function filtData = DataFiltering(data,dataRate,fcut,index)
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
%Filter parameters
order=2;
FilterType='lp';
dt=1/dataRate;

for k=1: length(data)
    
    if iscell(data)==0 %without cell struct
        if nargin>3  %if data are markers, filtering only within index interval
            filtData = ZeroLagButtFiltfilt(dt, (fcut), order, FilterType, data, index);
        else
            filtData = ZeroLagButtFiltfilt(dt, (fcut), order, FilterType, data);
        end
        
    else
        
        if length(size(data{k}))>2  %data are from FP
            for i=1:size(data{k},3) %i stands for the considered FP
                filtData{k}(:,:,i) = ZeroLagButtFiltfilt(dt, (fcut{k}), order, FilterType, data{k}(:,:,i));
            end
        else
            if nargin>3   %if dara are markers
                %ZeroLagButtFiltfilt filters data along columns
                filtData{k} = ZeroLagButtFiltfilt(dt, (fcut{k}), order, FilterType, data{k},index{k});
            else
                filtData{k} = ZeroLagButtFiltfilt(dt, (fcut{k}), order, FilterType, data{k});
            end
            %what changes among trials is fcut
        end
        %To save forces in a struct with labels:
        %eval(['filtData.' cell2mat(trialsList(k)) '= matfiltfilt2(dt, fcut{k}, order, FilterType, data );']);
    end
end
