Processing Pipeline

1)AcquisitionInterface

You need first to generate an acquisition.xml file that describes your dataset

2)C3D2MAT 

Than you need to run C3D2MAT to be able to process your data. It generates the sessionData folder with data from c3d in .mat format.
This part does not use the acquisition.xml file, so you can switch step 1 and 2.

2)StaticElaboration and DataProcessing are parallel and indipendent each other.
See each src folder for more instructions.
Refer to MOtoNMS User Guide for more details on the use of this toolbox.

TestData folder

It contains a testing dataset from the 4 different laboratories involed: 
Department of Information Engineering, University of Padova (UNIPD)
Department of Neurorehabilitation Engineering, Georg August University in Gottingen, Germany (GAU)
Centre of Musculoskeletal Research, Griffith University, Australia (GriffithUni)
School of Sport Science, Exercise and Health, University of Western Australia (UWA).
You can see how folders should be organized, examples of complete and valid configuration files and some results.

