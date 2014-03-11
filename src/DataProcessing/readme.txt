Instructions



1) Set Matlab path to this folder



2) Run ElaborationInterface.m



It generates the elaboration.xml file and run the elaboration.




If you already have the XML file, you can skip the user interface and run the code through the command:



runDataProcessing(ElaborationFilePath)



where ElaborationFilePath is the path (without the name) of the XML file you want to run


.


-- Note --

- 

C3D files must be converted in .mat with C3D2MAT.m - C3D2MAT_btk or C3D2MAT_c3dserver - before running Data Processing step
- 
acquisition.xml file is required and can be generated with mainAquisitionInterface.m - AcquisitionInterface -



Refer to MOtoNMS User Manual included with this release, chapter "Data Processing: elaborate your dynamic trials".
If you do not have a copy please visit http://goo.gl/Ukrw5B