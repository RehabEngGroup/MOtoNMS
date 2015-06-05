# MOtoNMS #

Matlab MOtion data elaboration TOolbox for NeuroMusculoSkeletal applications 
(MOtoNMS) is a a freely available toolbox that aims at providing a complete 
tool for post-processing of movement data for their use in neuromusculoskeletal 
software. MOtoNMS has been design to be flexible and highly configurable, 
to satisfy the requests of different research groups.  
Users can easily setup their own laboratory and processing procedures, 
without constraints in instruments, software, protocols, and methodologies, 
everything without change in the MATLAB code.  
MOtoNMS also improves the data organization, providing a clear structure of 
input data and automatically generating output directories. 

MOtoNMS is free software.  See the file license for copying conditions.


## Latest Version ##
Details of the latest version can be found on the SimTK project page: 
<https://simtk.org/home/motonms> 


## Documentation ##
A PDF version of MOtoNMS User Manual is included with this release and can be downloaded from <https://simtk.org/home/motonms>.
The most up-to-date documentation is also provided in the GitHub Project Pages available at <http://rehabenggroup.github.io/MOtoNMS/>.


## Installation ##
Just unzip the distribution and start working with MATLAB.
This release includes four directories:

- src:        MOtoNMS source code
- SetupFiles: Setup files describing laboratories configuration, 
              EMG and marker protocols, etc.
- Licenses:   Licenses for the tools used in MOtoNMS that are developed 
              by other authors
- TestData:   Example datasets from four different laboratories 

The TestData package is also available at <https://simtk.org/home/motonms>.


## Execution ##
Please refer to the included manual for detailed information on 
how to use MOtoNMS


## Contacts ##
- If you need help using MOtoNMS, please ask your questions in the MOtoNMS Public Forum, available from the SimTK project page: <https://simtk.org/home/motonms>, or send an email to <ali.mantoan@gmail.com>
- You can send MOtoNMS bug reports to <ali.mantoan@gmail.com>  
- If you want to participate in developing MOtoNMS, please send an email to <monica.reggiani@gmail.com>


## Licensing ##
Please see the file called License.

Copyright (C) 2012-2014 Alice Mantoan, Monica Reggiani

MOtoNMS is free software; you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation; either version 2, or (at your option) any later version.

MOtoNMS is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
MOtoNMS; see the file license.  If not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA.


## Acknowledgments ##
We would like to acknowledge Motion Lab Systems, Inc. (<http://www.motion-labs.com/>)
for the C3Dserver SDK (software development kit), and Arnaud Barre and Stephane Armand for
BTK (Biomechanical Toolkit, <https://code.google.com/p/b-tk/>) contribution.
We would also thank all the researchers at the University of Western Australia and at the Griffith University that contributed to the initial processing pipeline.