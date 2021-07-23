% hans.kainz@univie.ac.at 
% july 2021
clear all; clc; close all;
home = 'C:\Users\Hans\Documents\UNI_WIEN\MikeSchwartzCollaboration\BART_MuscleLength\';

    addpath('C:\Users\u0113767\Documents\WORK_KULeuven\MATLABcodes\MatlabOpensimPipelineTools\');
    addpath('C:\Users\u0113767\Documents\WORK_KULeuven\MATLABcodes\processEMG');
    
    
  % from OpenSim model gait 2392  
    gastrLength.ankleAngle = load_sto_file([home 'gastr_ankleAngle_NeutralPosit.mot']);
    gastrLength.kneeAngle = load_sto_file([home 'gastr_kneeAngle_NeutralPosit.mot']);
  % interpolate data knee angle 
    x=gastrLength.kneeAngle.knee_angle_r;
    v=gastrLength.kneeAngle.lat_gas_r;
    xq=(-120:0.5:10)';
    vq2 = interp1(x,v,xq,'spline');
    
    Spline.knee.kneeAngle = xq;
    Spline.knee.lat_gas = vq2;
    
    clear v, clear vq2;    
    v=gastrLength.kneeAngle.med_gas_r;
    vq2 = interp1(x,v,xq,'spline');
    Spline.knee.med_gas = vq2;
     clear v, clear vq2; clear x; clear xq;
    % control plot
    figure
    plot(Spline.knee.kneeAngle,Spline.knee.lat_gas)
    hold on
    plot(Spline.knee.kneeAngle,Spline.knee.med_gas)
      % interpolate data ankle angle
    x=gastrLength.ankleAngle.ankle_angle_r;
    v=gastrLength.ankleAngle.lat_gas_r;
    xq=(-90:0.5:90)';
    vq2 = interp1(x,v,xq,'spline');
    
    Spline.ankle.ankleAngle = xq;
    Spline.ankle.lat_gas = vq2;
    
    clear v, clear vq2;    
    v=gastrLength.ankleAngle.med_gas_r;
    vq2 = interp1(x,v,xq,'spline');
    Spline.ankle.med_gas = vq2;
     clear v, clear vq2; clear x; clear xq;
    % control plot
    figure
    plot(Spline.ankle.ankleAngle,Spline.ankle.lat_gas)
    hold on
    plot(Spline.ankle.ankleAngle,Spline.ankle.med_gas)
    
    %% example 
    val_k = [4;5;6]; % knee angle 20 degrees % positive = knee flexion
    val_a = [-30;-29;-28.5]; % ankle angle 40 degrees % positive = dorsiflexion
    z=2; % lat gas
    
     muscle_set = {'lat_gas' 'med_gas'};
    neutral = 0; % anatomical neutral position
    
    % find closest point on knee spline
    val_k = val_k*(-1) % because in OpenSim knee flexion is negative
    
    [ d, ix ] = min( abs( Spline.knee.kneeAngle-val_k ) ); % find closest point based on current knee angle
    
    [ d2, ix2 ] = min( abs( Spline.knee.kneeAngle-neutral ) ); % find time point based on zero (neutral) knee angle
    

     % find closest point on ankle spline    
    [ d3, ix3 ] = min( abs( Spline.ankle.ankleAngle-val_a ) ); % find closest point based on current knee angle
    
    
        
    % calculate difference in muscle length between zero and current knee angle
     mlength_knee_diff_neutral_curr = Spline.knee.(muscle_set{z})(ix,1)-Spline.knee.(muscle_set{z})(ix2,1);    
    gastlength_curr = Spline.ankle.(muscle_set{z})(ix3,1)+mlength_knee_diff_neutral_curr;

    
   
