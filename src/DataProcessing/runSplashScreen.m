function []=runSplashScreen()

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

    s.addText(30, 90, 'Main Developers', 'FontSize', 18, 'Color', [0.2 0.2 0.5],'FontAngle', 'italic' )
    s.addText(30, 130, 'Alice Mantoan', 'FontSize', 18, 'Color', [0.2 0.2 0.5] )
    s.addText(30, 160, 'Monica Reggiani', 'FontSize', 18, 'Color', [0.2 0.2 0.5] )
    
    s.addText(30, 210, 'Contributors', 'FontSize', 16, 'Color',[0.2 0.2 0.5],'FontAngle', 'italic' )
    s.addText(30, 240, 'Massimo Sartori', 'FontSize', 16, 'Color',[0.2 0.2 0.5] )
    s.addText(30, 265, 'Claudio Pizzolato', 'FontSize', 16, 'Color',[0.2 0.2 0.5] )
    s.addText(30, 290, 'Michele Vivian', 'FontSize', 16, 'Color',[0.2 0.2 0.5] )
    
    s.addText( 500, 50, 'Matlab Data Processing Toolbox', 'FontSize', 25, 'Color', [0 0 0.6] )
    s.addText( 550, 100, 'for Applications in OpenSim', 'FontSize', 20, 'Color', [0.2 0.2 0.5] )
    s.addText( 500, 270, 'Loading...', 'FontSize', 20, 'Color', 'white' )
    
    pause(4)
    delete( s )

catch
    
    disp(['An error has occured in runSplashScreen.m: verify the splashScreen path. It must be: ' figurePath] )
end
