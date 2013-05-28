function ForcePlateList = setForcePlateList (StancesOnFP,leg)


for k=1:length(StancesOnFP)
    
    StanceOnFP=StancesOnFP{k};
    
    for j=1:length(StanceOnFP)  %when more than a FP is struck
        
        if strcmp(StanceOnFP(j).Leg,leg)
            ForcePlateList{k}=StanceOnFP(j).Forceplatform;
        end
    end
    save_to_base(1)
    if isempty(ForcePlateList{k})
        error(['Trial ' num2str(k) ': the instrumented leg does not strike correctly the force platforms. Change method for the Analysis Window Computation or check the Acquisition.xml file']);
    end
    clear StanceOnFP
end
    

