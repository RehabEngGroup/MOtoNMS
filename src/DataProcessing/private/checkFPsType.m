function []=checkFPsType(FPinfo)
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

nFP=length(FPinfo);

for i=1:nFP
    
    FPtype(i)=FPinfo{i}.type;
    
    if i>1
        if  FPtype(i) == 1
            if FPtype(i-1) == FPtype(i)
                return
            else
                error('ErrorTests:convertTest', ...
                    '--------------------------------------------------------------------------\nWARNING: Force Platforms in your laboratory are of different types. MOtoNMS can not process data gathered with different force platforms during the same acquisition, if one of them is of type 1. Please contact project leads for further information (Alice Mantoan <alice.mantoan@gmail.com>, Monica Reggiani <monica.reggiani@gmail.com>) \n--------------------------------------------------------------------------')
            end
        end
    end
end