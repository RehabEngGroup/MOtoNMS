function trialType = getTrialType(trialName)
%Extract type without repetition number
%TrialName should be composed by Type + Repetition number

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

nRep{10}='0';
nRep{1}='1';
nRep{2}='2';
nRep{3}='3';
nRep{4}='4';
nRep{5}='5';
nRep{6}='6';
nRep{7}='7';
nRep{8}='8';
nRep{9}='9';

ind=[];

for i=1:length(nRep)
    c=strfind(trialName,nRep{i});
    ind=[ind c];
end

indsort=sort(ind);

if isempty(ind)==0
    
    trialType=trialName(1:indsort(1)-1);
else
    trialType=trialName;
    %disp('No repetition number in the trial name: trial type equals trial name')
end

    
