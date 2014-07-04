function []=runSplashScreen()
%
% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2012-2014 Alice Mantoan, Monica Reggiani
%
% MOtoNMS is free software: you can redistribute it and/or modify it under 
% the terms of the GNU General Public License as published by the Free 
% Software Foundation, either version 3 of the License, or (at your option)
% any later version.
%
% Matlab MOtion data elaboration TOolbox for NeuroMusculoSkeletal applications
% is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
% without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
% PARTICULAR PURPOSE.  See the GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License along 
% with MOtoNMS.  If not, see <http://www.gnu.org/licenses/>.
%
% Alice Mantoan, Monica Reggiani
% <ali.mantoan@gmail.com>, <monica.reggiani@gmail.com>

%%
originalPath=pwd;
cd('..')
cd('..')
%if the spashScreen image will be in a different path, necessary to change
%figurePath=[pwd '\ToolboxInfo\'];   
figurePath=pwd;   
cd (originalPath)

try
    s = SplashScreen( 'Splashscreen', [figurePath filesep 'splashScreen.png'], ... %loading image
        'ProgressBar', 'on', ...
        'ProgressPosition', 5, ...
        'ProgressRatio', 0.4 );
 catch       
    disp(['An error has occured in runSplashScreen.m: verify the splashScreen path. It must be: ' figurePath] )
end

    s.addText(330, 50, 'MOtoNMS', 'FontSize', 35,'FontName', 'Century Gothic', 'Color', 'white',  'FontWeight', 'bold')
    s.addText(150, 110, 'Matlab MOtion data elaboration TOolbox ', 'FontSize', 26,'FontName', 'Century Gothic', 'Color', 'white',  'FontWeight', 'bold')
    s.addText(170, 150, 'for NeuroMusculoSkeletal applications', 'FontSize', 26,'FontName', 'Century Gothic', 'Color', 'white',  'FontWeight', 'bold')
    s.addText(370, 230, 'Loading...', 'FontSize', 20, 'Color', 'white','FontName', 'Century Gothic' )
    
   % s.addText(240, 410, 'Alice Mantoan, Monica Reggiani', 'FontSize', 22, 'Color', 'white','FontName', 'Century Gothic','FontWeight', 'bold' )

    s.addText(20, 490, 'Copyright (C) 2012-2014 Alice Mantoan, Monica Reggiani ', 'FontSize', 16, 'Color', 'white','FontName', 'Century Gothic','FontWeight', 'bold' )
    s.addText(530, 490, 'GNU General Public License, Version 3', 'FontSize', 16, 'Color', 'white','FontName', 'Century Gothic','FontWeight', 'bold' )

    pause(3)
    delete(s)