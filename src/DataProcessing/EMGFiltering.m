function EMGDataLinEnv = EMGFiltering(EMGRawData,EMGRate)

for k=1: length(EMGRawData)  
    if iscell(EMGRawData)
        EMGDataLinEnv{k} = EMGLinearEnvelope(EMGRawData{k},EMGRate);
    else
        EMGDataLinEnv(k) = EMGLinearEnvelope(EMGRawData(k),EMGRate);
    end
end