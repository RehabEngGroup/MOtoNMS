Matlab Data Processing Toolbox for OpenSim


Processing Pipeline


1)AcquisitionInterface

You need first to generate an acquisition.xml file that describes your dataset


2)C3D2MAT 

Than you need to run C3D2MAT to be able to process your data. It generate the sessionData folder with data from c3d in .mat format.

This part does not use the acquisition.xml file, so you can switch step 1 and 2.


2)StaticElaboration and DataProcessing are parallel and indipendent each other.


See each src folder for more instructions.


TestData folder

It contains a testing dataset from DEI-UNIPD Laboratory (BTS Motion Capture System). 
You can se how folders should be organized and an example of a complete and valid acquisition.xml file.
