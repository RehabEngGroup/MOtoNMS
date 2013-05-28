function MaxEMGvalues = computeMaxEMGvalues(EMGconsidered)

for k=1:length(EMGconsidered)
     TrialMaxEMG(k,:) = max(EMGconsidered{k}); 
     %store max for each muscle of trial k [nTrials x nMuscle]
end

MaxEMGvalues = max(TrialMaxEMG,[],1);
