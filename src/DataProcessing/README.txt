Set Matlab path to this folder

Run ElaborationInterface.m

It generate the Elaboration.xml file and run the elaboration.


If you already have the xml file, you can skip the user interface and run the code through the command:

runDataProcessing(ElaborationFilePath),

where ElaborationFilePath is the path (without the name) of the xml file you want to run


Note

c3d files must be converted in .mat before with C3D2MAT.m

acquisition.xml file is required and can be generated with mainAquisitionInterface.m