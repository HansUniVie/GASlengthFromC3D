
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this function calculates gastrocnemicus length based on spline functions
% from the the gait2392 OpenSim model
% hans.kainz@univie.ac.at
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input
% val_k = knee angle 
% val_a= ankle angle 
% z=1 for medial gastrocnemicus length or z=2 for lateral gastrocnemicus
% length
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function m = gastlength(val_k,val_a,z)
    if z == 1 | z ==2
        load('Spline.mat');
        muscle_set = {'med_gas' 'lat_gas'};
        neutral = 0; % anatomical neutral position
        val_k = val_k*(-1); % because in OpenSim knee flexion is negative
        [ d2, ix2 ] = min( abs( Spline.knee.kneeAngle-neutral ) ); % find time point based on zero (neutral) knee angle

        for i=1:length(val_k)
            % find closest point on knee spline     
            [ d, ix ] = min( abs( Spline.knee.kneeAngle-val_k(i,1) ) ); % find closest point based on current knee angle
             % find closest point on ankle spline    
            [ d3, ix3 ] = min( abs( Spline.ankle.ankleAngle-val_a(i,1) ) ); % find closest point based on current ankle angle

            % calculate difference in muscle length between zero and current knee angle
             mlength_knee_diff_neutral_curr = Spline.knee.(muscle_set{z})(ix,1)-Spline.knee.(muscle_set{z})(ix2,1);  

            % calculate current muscle length based on knee and ankle angle 
            gastlength_curr = Spline.ankle.(muscle_set{z})(ix3,1)+mlength_knee_diff_neutral_curr;
            m(i,1)=gastlength_curr;
            clear ix; clear ix3;clear mlength_knee_diff_neutral_curr; clear gastlength_curr;
        end
        % get reference length from anatomic position (knee and ankle angle = 0 degrees)
        refLength = Spline.knee.(muscle_set{z})(ix2,1);
        % normalize muscle length to anatomical position
        m=m./ refLength;
    else
         error ( 'z must be 1 for medial gastrocnemicus or 2 for lateral gastrocnemicus. No other input is allowed for z' )
    end
end
