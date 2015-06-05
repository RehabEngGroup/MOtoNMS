New Features in MOtoNMS 2.2 
============================

MOtoNMS 2.2 has been updated to support two largely required features:

	+ **trials with different directions of motion**
	+ **force plates with pads**

MOtoNMS 2.2 also provides the users with additional logging information about the **EMG processing** steps. 
An new output folder (``maxemg``) is created for each dynamic elaboration, with plots and log data related to the computation of maximum EMG values.

A last objective of this release is improving the **processing of marker trajectories**. 
Users have the possibility to define the gaps' maximum size that will be interpolated, and a **piecewise filtering** has been implemented for markers trajectories that still have NaN values. 

Finally, computation of **joint centers** in `Static Elaboration <StaticElaboration>`_ is no more mandatory.
