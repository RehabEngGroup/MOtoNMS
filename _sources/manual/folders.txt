Folders: organize your work
===========================

Before starting with the description of MOtoNMS components, lets have a look to MOtoNMS code structure and how to organize your experimental data folders.

.. _`CodeOrganization`:

Code Organization
-----------------

:num:`Fig. #codeorg` shows MOtoNMS code structure. It is organized in threeparts:

+ *Source Code* (``MOtoNMS/src/``) directories include MOtoNMS code. Functions are organized in several directories reflecting the main parts of the toolbox, that will be described in the next chapters: :ref:`Acquisition Interface <AcquisitionInterface>` (:ref:`figure MOtoNMS overview schema <overview>` - blue boxes) and :ref:`C3D2MAT <C3D2MAT>`,  :ref:`Data Processing <DataProcessing>` and :ref:`Static Elaboration <StaticElaboration>` (:ref:`figure MOtoNMS overview schema <overview>` - orange boxes). Two  implementations for :ref:`C3D2MAT <C3D2MAT>` are available, each one using a different tool (`C3Dserver <http://www.c3dserver.com/>`_ and `BTK <https://code.google.com/p/b-tk/>`_) to access C3D files. A directory (``src/shared``) stores MATLAB functions common to  more than one processing step.


+ *Setup Files* (``MOtoNMS/SetupFiles/``) directory that includes files describing the laboratory setup, markers and EMG protocols, EMG output labels depending on the final application (see :ref:`Setup Files in Data  Processing <DataProcessingSetupFiles>` ), and information for join center computation methods (see  :ref:`Setup Files in Static Elaboration <StaticSetupFiles>`). Their organization in folders matches the source code structure. Several setup files are already available in the toolbox distribution (:ref:`Appendix B: Validation of Setup and Configuration Files <AppendixB>`) and are often used as examples in the manual. If you need to create new ones, refer to the *Setup Files* sections in each chapter as a reference for their editing.

+ *Licences* (``MOtoNMS/Licenses/``) directory which includes Licenses for tools used by MOtoNMS and developed by other authors.


The next chapters of the manual describe in details each part of MOtoNMS: its objectives, how it works, required configuration files and useful setup files.

.. _codeorg:

.. figure:: ../images/codeOrganization.png
   :align: center
   :width: 33%

   Overview of MOtoNMS Code Organization. The distribution of MOtoNMS includes an additional folder (``TestData``) with data from four different laboratories to test the toolbox.


.. _`DataOrganization`:

Data Organization
-----------------

An advantage of MOtoNMS is that it helps in keeping your experimental data folder well organized. Data storage is a common and important issue, especially when large amount of data are involved or when the collaboration among research teams leads to sharing of data sets and results.

Thus, we have decided to force some simple rules in the storage of collected data. This allow an automatic generation of output directories with a well defined structure. Therefore, the use of MOtoNMS forces the arrangement of the processed data sets with the same structure, facilitating the retrieval of information and results and the sharing of your work with other research teams.

But, actually, the only real rule that you have to follow is as simple as placing the folders of your collected data in a folder called ``InputData``.

We then encourage users to create a different folder for each acquisition, named with the date when data were collected. These folders should then be stored in another folder named with the subject identifier.

:num:`Fig. #dataorg` shows a representation of how MOtoNMS suggests to organize the data set: in black is the path of data from a single acquisition session. Inside the folder, together with the expected C3D files, you must include the ``acquisition.xml`` file (:num:`Fig. #dataorg` - red) that fully describe the collected data (see :ref:`Acquisition Interface <AcquisitionInterface>`).

The execution of MOtoNMS automatically creates new folders (:num:`Fig. #dataorg` - green). The new path for the output folder is created based on the input file path just replacing ``InputData`` with ``ElaboratedData`` (e.g, ``MyData\ElaboratedData\subjectXXX\ Year-Month-Day\``). Then the execution of the different tools create new subdirectories. :ref:`C3D2MAT <C3D2MAT>` extracts data from the C3D files and stores them in mat format in the subfolder ``sessionData`` (``MyData\ElaboratedData\subjectXXX\Year-Month-Day\sessionData\``). ``staticElaborations`` and ``dynamicElaborations`` subfolders store the output of :ref:`Static Elaboration <StaticElaboration>` and :ref:`Data Processing <DataProcessing>` parts, respectively.  Finally, the results of multiple executions of these two tools, with different configurations for the same input data, are stored in different subfolders, each one named with an identifier chosen by the user through the user interface (:ref:`Elaboration Interface: configure your elaboration <ElaborationInterfaceConfig>`).

.. _dataorg:

.. figure:: ../images/FIG3.*
   :align: center
   :width: 50%
   :figclass: align-center

   Data Folders Organization. In black the input data that the
   user must provide. In red the configuration files created by MOtoNMS
   and in green the output folders generated by the toolbox.
