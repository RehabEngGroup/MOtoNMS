%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         MATLAB DATA PROCESSING TOOLBOX for Applications in OPENSIM      %
%                           STATIC Elaboration                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Core Program 
% 
% Implemented by Alice Mantoan, March 2013, <alice.mantoan@dei.unipd.it>

function []=runStaticElaboration(ConfigFilePath)

if nargin==0
    error('static.xml file path missing: it must be given as a function input')
end

%% -------------------STATIC ELABORATION SETTING-------------------------%%
%           Folders paths definition and parameters generation            %
%-------------------------------------------------------------------------%

[foldersPaths,parameters]= StaticElaborationSettings(ConfigFilePath);

%Parameters List: Ri-nomination 
if isfield(parameters,'Fcut')
    fcut=parameters.Fcut;
end

Joints=parameters.JCcomputation.Joint;
trcMarkersList=parameters.trcMarkersList;
globalToOpenSimRotations=parameters.globalToOpenSimRotations;

%% ------------------------------------------------------------------------
%                            DATA LOADING                                 % 
%               Load markers data from static mat folder                  %
%--------------------------------------------------------------------------

load ([foldersPaths.matData '\Markers.mat']);
protocolMLabels=Markers.Labels;

%% -----------------------------------------------------------------------%
%                           DATA FILTERING                                %
%-------------------------------------------------------------------------%
%A cell data type is necessary to be able to use DataFiltering.m
markers{1}=Markers.RawData;
if exist('fcut','var')
    filtMarkers=DataFiltering(markers,Markers.Rate,fcut);
else
    filtMarkers=markers;
end

disp('Markers have been loaded and filtered')

%% -----------------------------------------------------------------------%
%                       JOINT CENTERS Computation                         %
%                       and markers list updating                         %
%-------------------------------------------------------------------------%
f=figure;
hold on
frame=1;

%Markers selection from the list
markerstrc = selectingMarkers(trcMarkersList,Markers.Labels,filtMarkers{1}(:,1:length(Markers.Labels)*3));
%new markers labels list (for addition of computed jc)
MarkersListjc={trcMarkersList};

for k=1:length(Joints)
    
    joint=Joints(k).Name;
    method=Joints(k).Method;
    input=Joints(k).Input;
    
    switch joint
        
        case 'Hip'
            
            [LHJC,RHJC,markers_hjc,markerNames_hjc]=HJCcomputation(method,input,protocolMLabels,filtMarkers);
            
            %add computed point to figure for checking (coordinates are in the laboratory global reference system)
            drawPoints(f,LHJC,RHJC, markers_hjc,markerNames_hjc,frame,'*r','HJC')
            
            %Updating markers selection and markers label list with jc
            [markerstrc,MarkersListjc]=updatingMarkersList(LHJC,RHJC,markerstrc,'LHJC','RHJC',MarkersListjc);

            %Saving Points
            save([foldersPaths.elaboration '\RHJC.mat'] ,'RHJC')
            save([foldersPaths.elaboration  '\LHJC.mat'] ,'LHJC')            

            
        case 'Knee'
            
            [LKJC,RKJC,markers_kjc,markerNames_kjc]=KJCcomputation(method,input,protocolMLabels,filtMarkers);
            
            drawPoints(f,LKJC,RKJC, markers_kjc,markerNames_kjc,frame,'*b','KJC')
                    
            [markerstrc,MarkersListjc]=updatingMarkersList(LKJC,RKJC,markerstrc,'LKJC','RKJC',MarkersListjc);

            save([foldersPaths.elaboration  '\RKJC.mat'] ,'RKJC')
            save([foldersPaths.elaboration  '\LKJC.mat'] ,'LKJC')
 
            
        case 'Ankle'
            
            [LAJC,RAJC,markers_ajc,markerNames_ajc]=AJCcomputation(method,input,protocolMLabels,filtMarkers);
            save_to_base(1)
            drawPoints(f,LAJC,RAJC, markers_ajc,markerNames_ajc,frame,'*g','AJC')
            
            [markerstrc,MarkersListjc]=updatingMarkersList(LAJC,RAJC,markerstrc,'LAJC','RAJC',MarkersListjc);
            
            save([foldersPaths.elaboration  '\RAJC.mat'] ,'RAJC')
            save([foldersPaths.elaboration  '\LAJC.mat'] ,'LAJC')           

            
        %case ...
        %ADD HERE MORE JOINTS
        %...
            
    end
end

%Figure properties Definition
title('Joint Centers Global Position')
grid on
xlabel('Asse x [mm]')
ylabel('Asse y [mm]')
zlabel('Asse z [mm]')
figName='JointCenters_globalPosition.fig';
saveas(gcf,[foldersPaths.elaboration '\' figName]) 
disp([figName ' has been saved'])

%% -----------------------------------------------------------------------%
%                        Write static.trc with jc
%-------------------------------------------------------------------------%
ind=strfind(foldersPaths.matData,'\');
trcFileName=[foldersPaths.matData(ind(end)+1:end) '.trc'];
FullFileName=[foldersPaths.elaboration '\' trcFileName];


%Mtime and MarkerListjc must be cell to be able to use createtrc
Mtime={[1/Markers.Rate: 1/Markers.Rate:  size(markerstrc,1)/Markers.Rate]'};

createtrc(markerstrc,Mtime{1},MarkersListjc{1}',globalToOpenSimRotations,Markers.Rate,FullFileName);

disp(' ')
disp([trcFileName ' has been created'])

%% save_to_base() copies all variables in the calling function to the base
% workspace. This makes it possible to examine this function internal
% variables from the Matlab command prompt after the calling function
% terminates. Uncomment the following command if you want to activate it
save_to_base(1)

h = msgbox('Data Processing terminated successfully','Done!');
uiwait(h)
