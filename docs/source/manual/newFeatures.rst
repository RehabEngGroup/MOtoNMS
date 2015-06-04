New Features in MOtoNMS 2.2 
============================

In MOtoNMS 2.2, we have added some important features. The most relevant are:

	+ Processing of data along different motion directions with respect to the global reference system (e.g. backward)
	+ CoP coordinates computation when plate pads are used
	+ Optionality in computation of joint centers in :ref:`Static Elaboration <StaticElaboration>` 

We have also concentrated in providing the users with more logging information about the processing of EMG signals and the computation of the maximum EMG values for normalization:

	+ EMG labels are included while saving EMG data in ``.mat`` format
	+ An output folder named ``maxemg`` is now created for each dynamic elaboration, to group log data related to the maximum EMG values computation
	+ All raw EMGs selected for the maximum EMG values computation and the corresponding envelopes are stored as ``mat`` files within the ``maxemg`` folder
	+ Information about the trial and time when maximum EMG value for each EMG envelope occurs are printed in ``maxemg.txt`` output file, and saved in ``.mat`` format (``maxemg.mat``)
	+ Raw EMG, envelope and maximum EMG value for each muscle, corresponding to the trial where the maximum EMG value is obtained, are plotted in MATLAB figures for visual inspection

At last, improving the processing of marker trajectories is another objective of this release. In order to do that, we have:

	+ Implemented interpolation for all the gaps in marker trajectories with size less than ``MaxGapSize``
	+ Given the user the possibility to define the ``MaxGapSize`` as a parameter in the ``elaboration.xml`` file
	+ Tracked the interpolation process for each gap, updating the logging in the ``InterpolationNote.txt`` file
	+ Implemented a piecewise filtering for marker trajectories still having NaN values due to a missed interpolation
