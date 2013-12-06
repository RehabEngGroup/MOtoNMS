function []=runStaticSplashScreen()
%
% The file is part of matlab MOtion data elaboration TOolbox for
% NeuroMusculoSkeletal applications (MOtoNMS). 
% Copyright (C) 2013 Alice Mantoan, Monica Reggiani
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
figurePath=[pwd '\ToolboxInfo\'];   
%if the spashScreen image will be in a different path, necessary to change
cd (originalPath)

try
    s = SplashScreen( 'Splashscreen', [figurePath 'SplashScreen.png'], ...
        'ProgressBar', 'on', ...
        'ProgressPosition', 5, ...
        'ProgressRatio', 0.4 );
    
    s.addText(30, 90, 'Main Developers', 'FontSize', 18, 'Color', [0.2 0.2 0.5],'FontAngle', 'italic'  )
    s.addText(30, 130, 'Alice Mantoan', 'FontSize', 18, 'Color', [0.2 0.2 0.5] )
    s.addText(30, 160, 'Monica Reggiani', 'FontSize', 18, 'Color', [0.2 0.2 0.5] )
    
    s.addText(30, 210, 'Contributors', 'FontSize', 16, 'Color',[0.2 0.2 0.5],'FontAngle', 'italic' )
    s.addText(30, 240, 'Massimo Sartori', 'FontSize', 16, 'Color',[0.2 0.2 0.5] )
    s.addText(30, 265, 'Claudio Pizzolato', 'FontSize', 16, 'Color',[0.2 0.2 0.5] )
    s.addText(30, 290, 'Michele Vivian', 'FontSize', 16, 'Color',[0.2 0.2 0.5] )
    
    s.addText( 500, 50, 'Matlab Data Processing Toolbox', 'FontSize', 25, 'Color', [0 0 0.6] )
    s.addText( 550, 100, 'for Applications in OpenSim', 'FontSize', 20, 'Color', [0.2 0.2 0.5] )
    s.addText( 600, 170, 'Static Elaboration', 'FontSize', 20, 'Color', [0.2 0.2 0.5] )
    s.addText( 500, 280, 'Loading...', 'FontSize', 20, 'Color', 'white' )
    

    pause(4)
    delete( s )

catch
    
    disp(['An error has occured in runSplashScreen.m: verify the splashScreen path. It must be: ' figurePath] )
end
