function [Markers, EMG, Forces, Events, ForcePlatformInfo,Rates] = getInfoFromC3D(c3dFilePathAndName)
% Function to load the data from a c3d file into the structured array data.
%
% INPUT -   file - the file path that you wish to load 
%
% OUTPUT -  all structured arrays containing the following data
%           Markers -  marker trajectories  
%           EMG - EMG data
%           Forces - force plate data 
%           Events - events saved in the c3d
%           ForcePlatformInfo - structure with information about where the
%           corners of the force plates are relative to the global coordinate
%           system
%           Rates - it contains VideoFrameRate e AnalogFrameRate in a
%           unique data structure. If other rates are present they are not
%           considered

%
%Implemented by Alice Mantoan, July 2012, <alice.mantoan@dei.unipd.it>
%Last updating January 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

itf=c3dserver();
C3Dopen(itf,c3dFilePathAndName);

%--------------------------------------------------------------------------
%                                MARKERS 
%--------------------------------------------------------------------------
try
    Markers = get3dPointsData(itf);
    %Markers Labels can also be computed separately and added to the
    %Markers struct
    %Markers.MLabels=getMarkersLabels(itf); 
   
    %alternatively to have a structure with markers idenfified by the
    %label:
    %Markers = getMarkersStruct(itf); 
    
catch me
    Markers=[];
    %Markers.Labels=[];
end

%--------------------------------------------------------------------------
%                                  EMG 
%--------------------------------------------------------------------------
if nargout > 1
    try
        EMG = getEMG(itf);
    catch me
        EMG = [];
        %EMG.Labels=[];
    end
end

%--------------------------------------------------------------------------
%                                FORCES 
%--------------------------------------------------------------------------
if nargout > 2
    try
        
        Forces = getGRForces(itf);
        
        %alternatively could be useful for future operations to have a 
        %STRUCTURE with forces idenfified by the labels ---> use:
        
        %Forces = getForceChannels(itf);
        
        %getForceChannels is taken from getAnalogChannels, a useful
        %function able to return ALL analog data (EMG+Forces+Biodex 
        %measures) in a unique structure, with data identified by labels
    
    catch me
        Forces = [];
    end
end

%--------------------------------------------------------------------------
%                           FORCE PLATFORM INFO 
%--------------------------------------------------------------------------
if nargout > 3
    try

       ForcePlatformInfo=getFPInfo(itf);
       %This returns info in a structure useful for GRF computation in
       %writing .MOT file part
       %alternatively:
       %ForcePlatformInfo = getForcePlateInfo(itf);
       %format of this structure is different from the previous
       %it can be choosen according to its use in trc and mot
       
    catch me
       ForcePlatformInfo = [];
    end
end

%--------------------------------------------------------------------------
%                                RATES 
%--------------------------------------------------------------------------
if nargout > 4
    try
        [VideoFrameRate,AnalogFrameRate] = getFrameRates(itf);
        
    catch me
        VideoFrameRate= [];
        AnalogFrameRate= [];
        
    end
    %store rates in a unique data structure
    Rates.VideoFrameRate=VideoFrameRate;
    Rates.AnalogFrameRate=AnalogFrameRate;
    
end

%--------------------------------------------------------------------------
%                                EVENTS 
%--------------------------------------------------------------------------
if nargout > 5
    
    try
        Events = getC3Devents(itf);
        
    catch me
        
        disp([c3dFilePathAndName ' has no events saved in it'])
        Events=[];
        
    end
    %Events in the c3d are saved in time units, but sometimes we may have
    %inputed frames, so the equivalence is here computed and saved
    eventFrames=getEventFrames(Events,VideoFrameRate);

    if isempty(eventFrames)==0
        for i=1:length(eventFrames)
            Events(i).frame=eventFrames(i);
        end
    end
        
end
