function []=runAcquisitionSplashScreen()

originalPath=pwd;
cd('..')
cd('..')
%if the spashScreen image will be in a different path, necessary to change
figurePath=[pwd '\ToolboxInfo\'];   
cd (originalPath)

try
    s = SplashScreen( 'Splashscreen', [figurePath 'Acquisition.png'], ...
        'ProgressBar', 'on', ...
        'ProgressPosition', 5, ...
        'ProgressRatio', 0.4 );
 catch       
    disp(['An error has occured in runSplashScreen.m: verify the splashScreen path. It must be: ' figurePath] )
end

    s.addText(30, 130, 'Main Developers', 'FontSize', 18, 'Color', 'white', 'FontAngle', 'italic' )
    s.addText(30, 170, 'Alice Mantoan', 'FontSize', 18, 'Color', 'white' )
    s.addText(30, 200, 'Monica Reggiani', 'FontSize', 18, 'Color','white' )
    
    s.addText(30, 250, 'Contributors', 'FontSize', 16, 'Color','white','FontAngle', 'italic' )
    s.addText(30, 280, 'Massimo Sartori', 'FontSize', 16, 'Color','white' )
    s.addText(30, 300, 'Claudio Pizzolato', 'FontSize', 16, 'Color','white' )
    s.addText(30, 320, 'Michele Vivian', 'FontSize', 16, 'Color','white' )
    
    s.addText( 300, 30, 'Matlab Data Processing Toolbox', 'FontSize', 25, 'Color', 'white')
   % s.addText( 300, 100, 'for Applications in OpenSim', 'FontSize', 20, 'Color', 'white')
    s.addText( 370, 70, 'Acquisition Interface', 'FontSize', 22, 'Color', 'white' )
    s.addText( 380, 200, 'Loading...', 'FontSize', 20, 'Color', 'white' )
    
    pause(5)
    delete( s )