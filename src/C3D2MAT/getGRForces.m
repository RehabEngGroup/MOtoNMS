function Forces = getGRForces(itf)
%getGRForces
%Extraction of Forces and Moments from Analog Data

 numberForcePlatform =  itf.GetParameterValue( itf.GetParameterIndex('FORCE_PLATFORM', 'USED'),0);
 numItems = numberForcePlatform*6;
 
 unitIndex = itf.GetParameterIndex('ANALOG', 'UNITS');

 for i = 1 : numItems,
    
    Labels{i} = itf.GetParameterValue(itf.GetParameterIndex('ANALOG','LABELS'), i-1); 
    
    units{i}= itf.GetParameterValue(unitIndex, i-1);
    
    Values(:,i) = getanalogchannel(itf, Labels{i});
 end

 rateIndex = itf.GetParameterIndex('ANALOG', 'RATE');
 
 Forces.Rate = itf.GetParameterValue(rateIndex, 0);
 Forces.Units=units;
 Forces.RawData=Values;
 Forces.Labels=Labels;
 
 
 %Alternative way to extract forces indipendent from data channel
 
 % Fx1 = cell2mat(itf.GetForceData(0, 0 , -1, -1));
 % Fx2 = cell2mat(itf.GetForceData(0, 1 , -1, -1));
 
 % Fy1 = cell2mat(itf.GetForceData(1, 0 , -1, -1));
 % Fy2 = cell2mat(itf.GetForceData(1, 1 , -1, -1));
 
 % Fz1 = cell2mat(itf.GetForceData(2, 0 , -1, -1));
 % Fz2 = cell2mat(itf.GetForceData(2, 1 , -1, -1));
 
  
 % Mx1 = cell2mat(itf.GetMomentData(0, 0 , -1, -1));
 % Mx2 = cell2mat(itf.GetMomentData(0, 1 , -1, -1));
 
 % My1 = cell2mat(itf.GetMomentData(1, 0 , -1, -1));
 % My2 = cell2mat(itf.GetMomentData(1, 1 , -1, -1));
 
 % Mz1 = cell2mat(itf.GetMomentData(2, 0 , -1, -1));
 % Mz2 = cell2mat(itf.GetMomentData(2, 1 , -1, -1));
 
 % Values=[Fx1 Fy1 Fz1 Mx1 My1 Mz1 Fx2 Fy2 Fz2 Mx2 My2 Mz2];
 
 