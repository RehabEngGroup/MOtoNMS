Instructions



1) Set Matlab path to this folder



2) Run mainStaticElaboration.m: main program with interface for user inputting data




If you already have the configuration file for a specific elaboration (static.xml), 
you can directly run it through the command:



runStaticElaboration(ConfigFilePath)



where ConfigFilePath is 'C\...\' the path of your XML file




-- 
Note --



- c3d files must be converted in .mat with C3D2MAT.m - C3D2MAT_btk or C3D2MAT_c3dserver - before running Static Elaboration step

- acquisition.xml file is required and can be generated with mainAquisitionInterface.m - AcquisitionInterface -



Refer to MOtoNMS User Manual included with this release, chapter "Static Elaboration: process your static trials".
If you do not have a copy please visit http://goo.gl/Ukrw5B