function trialType = getTrialType(trialName)
%Extract type without repetition number
%TrialName should be composed by Type + Repetition number

% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2013 Alice Mantoan, Monica Reggiani
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

nRep{1}='0';
nRep{2}='1';
nRep{3}='2';
nRep{4}='3';
nRep{5}='4';
nRep{6}='5';
nRep{7}='6';
nRep{8}='7';
nRep{9}='8';
nRep{10}='9';

ind=[];

for i=1:length(nRep)
    c=strfind(trialName,nRep{i});
    ind=[ind c];
end

if isempty(ind)==0
    
    trialType=trialName(1:ind-1);
else
    trialType=trialName;
    %disp('No repetition number in the trial name: trial type equals trial name')
end

    
