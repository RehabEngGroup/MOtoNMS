%JC Computation as Mid Point between two points

%Input
%markers = mat struct with required markers trajectories from static 
%          acquisition 
%Markers correspondence is obtained by order position and is defined in
%the choosen 'method'.xml file (ConfigurationFile folder) as below: 
%<Input>
%   <MarkerFullNames>
% 	   <Marker>Left First Point</Marker>
%      <Marker>Right First Point</Marker>
%      <Marker>Left Second Point</Marker>
%      <Marker>Right Second Point</Marker>
%   </MarkerFullNames>
%</Input>

%Output
%[RJC,LJC]=Right and Left Joint Center global position for each time istant
%
function [RJC,LJC]=MidPoint(markers)


LJC=((markers{1}+markers{3})/2);
RJC=((markers{2}+markers{4})/2);