function []=addSharedPath()

originalPath=pwd;
cd('..')

cd('shared')
sharedFunctionsPath=pwd;

addpath(sharedFunctionsPath)
 
cd (originalPath)