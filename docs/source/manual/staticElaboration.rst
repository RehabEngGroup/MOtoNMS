.. _`StaticElaboration`:

Static Elaboration: process your static trials
==============================================

OpenSim requires static trials for the scaling procedure [4]_. The objective of the elaboration of these trials is to produce for each static trial a markers trajectories file (``.trc``), optimized for the Scaling in OpenSim.

Starting from the ``.mat`` structures created by :ref:`C3D2MAT <C3D2MAT>`, Static Elaboration apply the same filtering procedure used in Data Processing. The main step is then joint centers (JC) estimation. These are points usually recommended to improve the accuracy of the OpenSim scaling procedure.

In the current toolbox version, methods for hip (HJC), knee (KJC), ankle (AJC), elbow (EJC), shoulder (SJC) and wrist (WJC) joint centers computation are available. More specifically, HJC can be assessed exploiting Harrington [5]_, while the others can be computed as the mid points between anatomical landmarks specified in the corresponding setup files (:ref:`Setup Files <StaticSetupFiles>`). However, the structure of the software intentionally allows an easy integration of other algorithms for both lower and upper limbs joints. The resulting trajectories are then added to the markers list defined by the user (:ref:`Static Interface: configure your elaboration <StaticInterfaceConfig>`). The updated list is finally rotated into OpenSim reference system and stored in the output ``.trc`` file.


.. _`StaticInterfaceConfig`:

Static Interface: configure your elaboration
--------------------------------------------

As Data Processing (:ref:`Elaboration Interface: configure your elaboration <ElaborationInterfaceConfig>`), the execution of the Static Elaboration block is fully defined by a set of parameters selected by the user.

All these parameters are enclosed in the ``static.xml`` configuration file, which can be obtained running a graphical user interface.

The GUI will ask first to select the input data folder and next to enter an identifier for the current elaboration. The identifier will be used to name the new folder storing the results of this elaboration (e.g. ``staticelaboration01ID``, ``staticelaboration02ID`` in :ref:`Folders: organize your work figure <dataorg>`). As shown in :ref:`Folders: organize your work figure <dataorg>`, all static elaborations are grouped in the ``staticElaborations`` folder to avoid confusion with the output folders of Data Processing.

Then, the GUI will ask the user the parameters required for the elaboration, which are briefly described in the following:

+ Static trial to be processed
+ Cut-off frequency for markers filtering (Optional)
+ Joints for center computation (Optional)
+ Methods for the computation of the joint centers, which are defined selecting the corresponding setup file (:ref:`Setup Files <StaticSetupFiles>`)
+ List of markersto be written in ``.trc`` file


An example of ``static.xml`` configuration file is shown in  the following:


.. highlight:: xml
   :linenothreshold: 5

.. code-block:: xml
   :linenos:

   <?xml version="1.0" encoding="utf-8"?>

   <static>
     <FolderName>.\InputData\UWAsubject\2010-05-11\</FolderName>
     <TrialName>Static1</TrialName>
     <Fcut>8</Fcut>
     <JCcomputation>
       <Joint>
         <Name>Ankle</Name>
         <Method>AJCMidPoint</Method>
         <Input>
           <MarkerNames>
             <Marker>LLMAL</Marker>
             <Marker>RLMAL</Marker>
             <Marker>LMMAL</Marker>
             <Marker>RMMAL</Marker>
           </MarkerNames>
         </Input>
       </Joint>
       <Joint>
         <Name>Hip</Name>
         <Method>HJCHarrington</Method>
         <Input>
           <MarkerNames>
             <Marker>LASI</Marker>
             <Marker>RASI</Marker>
             <Marker>LPSI</Marker>
             <Marker>RPSI</Marker>
           </MarkerNames>
         </Input>
       </Joint>
       <Joint>
         <Name>Knee</Name>
         <Method>KJCMidPoint</Method>
         <Input>
           <MarkerNames>
             <Marker>LeLFC</Marker>
             <Marker>RiLFC</Marker>
             <Marker>LeMFC</Marker>
             <Marker>RiMFC</Marker>
           </MarkerNames>
         </Input>
       </Joint>
     </JCcomputation>
     <trcMarkers>C7 CLAV LACR LASH LPSH LUA1 LUA2 LUA3 ....</trcMarkers>
   </static>


Before going into details about this file we need to give you some additional information about JC computation. Different methods for the computation of the different JC may require different input data. Usually these input data includes the markers position during the static acquisition. However, different marker protocols use different labels to identify the same body landmark. Thus, it is necessary to define the connection between the marker required by a method (i.e. the left and right anterior and posterior superior iliac spine forthe Harrington method) and their names according to the markers protocol used for the data collection. As it would be too complex and error prone to do it for each elaboration, this information is stored in a setup file (see :ref:`Setup Files <StaticSetupFiles>` in this chapter), one for each JC computational method. Each file describes how the landmarks of interested are named in different marker protocols. A user can add new protocols to the file when required.


Static Elaboration retrieved from the Setup File of the selected JC computation method the marker labels in the marker protocol used in the static trial selected for the processing and save them in the ``static.xml`` file (lines 12-17, 24-29, and 36-41).

The list of markers to be stored in the ``.trc`` file (line 45) MUST NOT include the estimated JC labels, as it will be automatically updated.





How to run the program
----------------------



Create settings file for static elaboration (Static Interface)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#. Set MATLAB path on ``src\StaticElaborationfolder``
#. Run ``StaticInterface.m``


``StaticInterface.m`` is the program implementing the Static Interface.


**Output**: it generates ``static.xml`` file.



At the end of the program the user is prompt with the request if he/she wants to run the elaboration code with the just created ``static.xml`` file.


Run static elaboration
~~~~~~~~~~~~~~~~~~~~~~


If you have already the configuration file with the parameters of your elaboration (``static.xml``) , you can run directly the static elaboration with the command:



``runStaticElaboration(ConfigFilePath)``



where ``ConfigFilePathis`` the full path of the folder where your ``static.xml`` file is located.



**Output**: ``static.trc``, with the processed markers trajectories and the computed JC



Additional files are also generated to help in validation of obtained results:


+ computed joint centers coordinate in .mat format
+ plot of estimated JCs in the laboratory reference system




Please pay ATTENTION to the following IMPORTANT NOTES:

.. warning::

   + For any JC computation method, a setup file MUST be predefined (see :ref:`Setup Files <StaticSetupFiles>`).

   + The marker protocol used in the data collection of the static trial must be among the one in the setup file for the selected JC computation method (see :ref:`Setup Files <StaticSetupFiles>`).

   + Be careful to specify list of markers within the ``MarkerNames`` tag in the same order of the list of markers within the ``MarkersFullNames`` tag (lines 5-10 in the next listing).

   + The plot of estimated JCs is based on data from the first frame: if JCs plot seems wrong there could be a problem on data in the first frame

   + :ref:`C3D2MAT <C3D2MAT>` code MUST be run on the static trial before the static elaboration.






.. _`StaticSetupFiles`:

Setup Files
-----------

The main information that the user have to define for a static  elaboration is the joint centers he/she is interested in computing, the methods to be used for their computation and the parameters each method requires. The last one might be very long and error prone to be edited at each elaboration, so we decided that it would be easier to enclose this parameters in a setup file. The Static Interface will thus ask you to select a setup file for each JC computation. The following explains how to fill these setup files.

.. _`jointCenterComputation`:

Joint Center Computation Methods
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Each implemented JC computation method requires a file that list how the required input markers are labelled in each marker protocol. This file MUST be saved in ``SetupFiles\StaticElaboration\JCcomputation\`` within the folder of the corresponding joint, as shown in :num:`Fig. #sfoldorg`. While not mandatory, our suggestion is to name the file with the acronym of the joint name followed by the identifier of the JC computation method. When only a method is available for a joint, the Static Interface will not ask to choose the setup file and select the only one available in the folder.

.. _sfoldorg:

.. figure:: ../images/staticFolders.png
   :align: center
   :height: 500pt
   :alt: Setup files organization for the Static Elaboration code
   :figclass: align-center

   Setup files organization for the Static Elaboration code.



The following listing is an example of a setup file created for the Harrington method at the hip joint (available at: ``SetupFiles\StaticElaboration\JCcomputation\Hip\HJCHarrington.xml``)

.. _jcxml:

.. highlight:: xml
   :linenothreshold: 5

.. code-block:: xml
   :linenos:

   <Method>
     <Name>HJCHarrington</Name>

     <Input>
       <MarkerFullNames>
         <Marker>Left Anterior Superior Iliac Spine</Marker>
         <Marker>Right Anterior Superior Iliac Spine</Marker>
         <Marker>Left Posterior Superior Iliac Spine</Marker>
         <Marker>Right Posterior Superior Iliac Spine</Marker>
       </MarkerFullNames>
     </Input>

     <MarkersDefinition>
       <Protocol>
         <Name>UWA-Fullbody</Name>
         <MarkerNames>
           <Marker>LASI</Marker>
           <Marker>RASI</Marker>
           <Marker>LPSI</Marker>
           <Marker>RPSI</Marker>
         </MarkerNames>
       </Protocol>

       <Protocol>
         <Name>UNIPD_CASTforOpenSim</Name>
         <MarkerNames>
           <Marker>LASIS</Marker>
           <Marker>RASIS</Marker>
           <Marker>LPSIS</Marker>
           <Marker>RPSIS</Marker>
         </MarkerNames>
       </Protocol>
       ...
     </MarkersDefinition>
   </Method>




The file first lists the input required for the method (``<Input>`` tag, lines 4-11). Required markers are listed with their full name within the ``<MarkersFullNames>`` tag (lines 5-10). Then, a tag named ``MarkersDefinition`` follows (line 13-34). It consists of a list of protocols and MUST include, for each of them, the corresponding input markers names. When new protocols are available, they must be added to the list of the method used for joint computation.






.. [4] <http://simtk-confluence.stanford.edu:8080/display/OpenSim/Getting+Started+with+Scaling>
.. [5] Harrington ME, et al., Journal of Biomechanics,Biomechanics 40:595602, 2007
