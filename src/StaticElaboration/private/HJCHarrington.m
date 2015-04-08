function [RHJC, LHJC]=HJCHarrington(markers)
%Hip joint center computation according to Harrington et al J.Biomech 2006
%
%PW: width of pelvis (distance among ASIS)
%PD: pelvis depth = distance between mid points joining PSIS and ASIS 
%All measures are in mm
%Harrington formula:
% x= -0.24 PD-9.9
% y= -0.30PW-10.9
% z=+0.33PW+7.3
%
%Input
%markers = mat struct with required hip markers trajectories from static 
%          acquisition (LASIS, RASIS, LPSIS, RPSIS)
%Markers correspondence is obtained by order position and is defined in
%HJCHarrington.xml file (ConfigurationFile folder) as below:   
%<Input>
%   <MarkerFullNames>
% 	  <Marker>Left Anterior Superior Iliac Spine</Marker>
%     <Marker>Right Anterior Superior Iliac Spine</Marker>
%     <Marker>Left Posterior Superior Iliac Spine</Marker>
%     <Marker>Right Posterior Superior Iliac Spine</Marker>
% 	</MarkerFullNames>
%</Input>
%
%Output
%[RHJC, LHJC]= Hip Joint Center global position for each time istant
%
%Developed by Zimi Sawacha <zimi.sawacha@dei.unipd.it>
%Modified by Claudio Pizzolato <claudio.pizzolato@griffithuni.edu.au>

%%

%Renamd for convenience 
LASIS=markers{1}';   %after transposition: [3xtime]
RASIS=markers{2}';
LPSIS=markers{3}';
RPSIS=markers{4}';


for t=1:size(RASIS,2)

    %Right-handed Pelvis reference system definition 
    SACRUM(:,t)=(RPSIS(:,t)+LPSIS(:,t))/2;      
    %Global Pelvis Center position
    OP(:,t)=(LASIS(:,t)+RASIS(:,t))/2;    
    
    PROVV(:,t)=(RASIS(:,t)-SACRUM(:,t))/norm(RASIS(:,t)-SACRUM(:,t));  
    IB(:,t)=(RASIS(:,t)-LASIS(:,t))/norm(RASIS(:,t)-LASIS(:,t));    
    
    KB(:,t)=cross(IB(:,t),PROVV(:,t));                               
    KB(:,t)=KB(:,t)/norm(KB(:,t));
    
    JB(:,t)=cross(KB(:,t),IB(:,t));                               
    JB(:,t)=JB(:,t)/norm(JB(:,t));
    
    OB(:,t)=OP(:,t);
      
    %rotation+ traslation in homogeneous coordinates (4x4)
    pelvis(:,:,t)=[IB(:,t) JB(:,t) KB(:,t) OB(:,t);
                   0 0 0 1];
    
    %Trasformation into pelvis coordinate system (CS)
    OPB(:,t)=inv(pelvis(:,:,t))*[OB(:,t);1];    
       
    PW(t)=norm(RASIS(:,t)-LASIS(:,t));
    PD(t)=norm(SACRUM(:,t)-OP(:,t));
    
    %Harrington formulae (starting from pelvis center)
    diff_ap(t)=-0.24*PD(t)-9.9;
    diff_v(t)=-0.30*PW(t)-10.9;
    diff_ml(t)=0.33*PW(t)+7.3;
    
    %vector that must be subtract to OP to obtain hjc in pelvis CS
    %vett_diff_pelvis_sx(:,t)=[-diff_ml(t);diff_v(t);diff_ap(t);1];
    %vett_diff_pelvis_dx(:,t)=[diff_ml(t);diff_v(t);diff_ap(t);1];
    vett_diff_pelvis_sx(:,t)=[-diff_ml(t);diff_ap(t);diff_v(t);1];
    vett_diff_pelvis_dx(:,t)=[diff_ml(t);diff_ap(t);diff_v(t);1];    
    
    %hjc in pelvis CS (4x4)
    rhjc_pelvis(:,t)=OPB(:,t)+vett_diff_pelvis_dx(:,t);  
    lhjc_pelvis(:,t)=OPB(:,t)+vett_diff_pelvis_sx(:,t);  
    

    %Transformation Local to Global
    RHJC(:,t)=pelvis(1:3,1:3,t)*[rhjc_pelvis(1:3,t)]+OB(:,t);
    LHJC(:,t)=pelvis(1:3,1:3,t)*[lhjc_pelvis(1:3,t)]+OB(:,t);
    %or
    %RHJC(:,t)=pelvis(:,:,t)*[rhjc_pelvis(:,t)];
    %LHJC(:,t)=pelvis(:,:,t)*[lhjc_pelvis(:,t)];
    
    %Or other way to check the result:
    %transformation of the difference vector into global 
    %vett_diff_global_sx(:,t)=pelvis(:,:,t)*vett_diff_pelvis_sx(:,t);
    %vett_diff_global_dx(:,t)=pelvis(:,:,t)*vett_diff_pelvis_dx(:,t);
    %Sum global diff vect + global center
    %RHJC(:,t)=[OB(:,t);1]+vett_diff_global_dx(:,t);
    %LHJC(:,t)=[OB(:,t);1]+vett_diff_global_sx(:,t);
       
end

% To have a mean value during the whole static acquisition instead of for
% each time instant, mean computation must be added
% RHJC=mean(RHJC(:,:),2);
% LHJC=mean(LHJC(:,:),2);

% [time x [x y z]]
RHJC=RHJC';
LHJC=LHJC';
