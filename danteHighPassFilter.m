function [datat] = danteHighPassFilter(datat,TR,HPF)
%TR=2; % TR in seconds
tf=HPF; % cut-off in seconds
fs=1/TR;
fc=1/tf;

f_high=max(fc*2/fs,0.004);
[b2,a2] = cheby2(6,20,f_high,'high');
%fvtool(b2,a2);
datat=[flipud(datat(1:10,:)) ; datat ; flipud(datat(end-9:end,:))];
datat=filtfilt(b2,a2,datat);
datat=datat(11:end-10,:);