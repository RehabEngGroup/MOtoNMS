%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         MATLAB DATA PROCESSING TOOLBOX for Applications in OPENSIM      %
%                           STATIC Elaboration                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert static.xml file into a parameter.mat struct for elaboration 
% 
% Implemented by Alice Mantoan, March 2013, <alice.mantoan@dei.unipd.it>

function staticParameters = staticParametersGeneration(staticSettings,acquisitionInfo,foldersPaths,varargin)
%staticParameters struct Definition

%Data needed for oldParameters

%Fcut
if isfield(staticSettings,'Fcut')
    staticParameters.Fcut{1}=num2str(staticSettings.Fcut);
end

try
    %JC Computation: no changes from static.xml file
    staticParameters.JCcomputation=staticSettings.JCcomputation;
    
    %trcMarkersList
    Markers=staticSettings.trcMarkers;
    trcMarkersList=textscan(Markers, '%s');
    trcMarkersList=trcMarkersList{1};
    
    staticParameters.trcMarkersList=trcMarkersList;
    
catch
    msgbox('Information missing to run the code: check static.xml file with its .xsd!','Static Parameters Generation','error');
end

if nargin>1  %Parameters not needed for oldParameters
        
    %Parameters definition from acquisition.xml file
    
    globalReferenceSystem= acquisitionInfo.Laboratory.CoordinateSystemOrientation;
    
    globalToOpenSimRotations=globalToOpenSimRotParametersCreator(globalReferenceSystem);

    staticParameters.globalToOpenSimRotations=globalToOpenSimRotations;
   
    save ([foldersPaths.elaboration '\staticParameters.mat'], 'staticParameters')
end

save_to_base(1)


