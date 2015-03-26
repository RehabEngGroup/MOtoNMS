function FPdata = getForcePlatesData(h)
%getForcePlatesData
%Extraction of FPdata from Analog Data

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

nFP=btkGetMetaData(h, 'FORCE_PLATFORM','USED');
numberForcePlatform=nFP.info.values;
 
fchannels=btkGetMetaData(h, 'FORCE_PLATFORM','CHANNEL');
% From C3D User Guide: 
% The C3D file format allows force platform information to be recorded in any analog 
% channel. There is no requirement that force platform data be ordered in any specific
% way in the recorded analog data as the FORCE_PLATFORM:CHANNEL parameter is
% used to specify the correspondence between recorded analog data channels (1, 2, 3
% etc) and force platform channels (e.g. Fx, Fy, Mz).

analogLabels=btkGetMetaData(h, 'ANALOG','LABELS');

%number of Force channels --> related to the force plate type (6 for type 1
%and 2 but 8 for type 3)
%nFchannels= size(fchannels.info.values,1)*size(fchannels.info.values,2);
%this is not correct since there might be 0 values in fchannels.info.values
channelsUsed=fchannels.info.values(find(fchannels.info.values~=0));
nFchannels=length(channelsUsed);

if nFchannels > 0  %if FPdata are present
    
    for i = 1 : nFchannels,
        %retrieve analog channel corresponding to force plate output channel
        %this allow taking into account more than 6 force channels (like for fp of type 3)
        %but also if force channels do not correspond in order to the analog
        %channels (e.g 7th analog channel empty instead having Fx2)
        
        %fchannel= fchannels.info.values(i); where 0 are present, fchannel
        %become 0 in this way
        fchannel=channelsUsed(i);
        %fchannel contains the analog channel that corresponds to the i force plate output channel
        
        [values, info] = btkGetAnalog(h, fchannel);
        
        Values(:,i) =values; %Values stored force data from all FPs in order
        
        Labels{i}=cell2mat(analogLabels.info.values(fchannel));
        
        units{i}=info.units;
        
        clear values info
    end
    
    %Force platforms of type 4 return force data in V.
    %C3Dserver automatically converts force data in N and N*m or N*mm
    %In the following lines is implemented force data rescaling from V to
    %N and N*m or N*mm for data from FP of type 4
    
    %Refer to: http://c3d.org/HTML/default.htm?turl=calmatrix.htm for
    %further details
    
    [forceplates, forceplatesInfo] = btkGetForcePlatforms(h);
    av = btkGetAnalogsValues(h); %all analog channels as a matrix
    
    Fc=[]; %Fc stands for Fcorrected as in http://c3d.org/HTML/default.htm?turl=calmatrix.htm
    for n=1:numberForcePlatform
        
        dim1=size(forceplatesInfo(n).cal_matrix,1);
        dim2=size(forceplatesInfo(n).cal_matrix,2);
        
        %Fv=Values(:,dim1*(n-1)+1:dim1*n); cal_matrix of FP type 3 might be
        %not set, and dim1/dim2 can be 6 even with FP of type 3, therefore
        %this way to extract data is not always correct
        
        nCh=size(fieldnames(forceplates(n).channels),1);
        %number of channel for each FP according to the type
        
        Fv=av(:,fchannels.info.values(1:nCh,n));
        %each column in fchannels.info.values contains the channels of a FP
                
        if forceplates(n).type == 4
            
            if dim1==dim2 && isempty(forceplatesInfo(n).cal_matrix)==0
                
                fc=forceplatesInfo(n).cal_matrix*Fv';   %[CAL_MATRIX]Fmeasured=Fcorrected
                
                %'Every C3D file uses a consistent set of units throughout
                %thus while the force plate manufacturer usually supplies
                %the moment calibration data in terms of N•m/V, the
                %calibration matrix must store the moment data in N•mm/V
                %if the POINT calibration and measurement units are mm.'
                %From http://c3d.org/HTML/default.htm?turl=calmatrix.htm
                %That's the reason why no conversion (from or to mm or m)
                %is done before applying this formula --> results should
                %be consistent with FPdata units
                
            else
                disp(['Wrong or empty force plate ' num2str(n) ' calibration matrix: unable to convert force data from V to N (Type 4). Be aware that FPdata stored in the sessionData folder are in V!'])
            end
            
            Fc=[Fc fc'];
            
        else
            
            Fc=[Fc Fv];
            
        end
        clear Fv
    end
    
    
    rate=btkGetMetaData(h,'ANALOG','RATE');
    
    nStartFrame=btkGetFirstFrame(h);
    nEndFrame =btkGetLastFrame(h);
    
    FPdata.Rate=double(rate.info.values);
    FPdata.Units=units;
    
    %FPdata.RawData=Values;
    FPdata.RawData=Fc;
    FPdata.Labels=Labels;
    
    FPdata.FirstFrame=nStartFrame;
    FPdata.LastFrame=nEndFrame;
    
else  %Biodex trials for example
    FPdata=[];
    disp('Force Platform Channels empty')
end

