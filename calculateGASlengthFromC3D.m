%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hans.kainz@univie.ac.at
% July 2021
% this code calculates GAST length based on the knee and ankle angles from
% a c3d file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; clc; close all;
% load C3D file data and get knee and ankle angles
exampleC3D = 'g0h1_2 41.c3d';
dataC3D = btk_loadc3d(exampleC3D); % load c3d file

val_k = dataC3D.angles.RKneeAngles(:,1); % sagittal knee angle
val_a = dataC3D.angles.RAnkleAngles(:,1); % sagittal ankle angle

% calculate GAST length
medGAST = gastlength(val_k,val_a,1);
latGAST = gastlength(val_k,val_a,2);
    
 






