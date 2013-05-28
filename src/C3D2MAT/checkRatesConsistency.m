function [] = checkRatesConsistency(Rates,newRates)


if (Rates.VideoFrameRate==newRates.VideoFrameRate && Rates.AnalogFrameRate==newRates.AnalogFrameRate)
    return
else
    disp('Data Inconsistency: Rates differs among trials')
end
