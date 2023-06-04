clc;
clear all;
sig = load('Upload the in the Signal File you want to process');
subplot(3,1,1);
plot(sig)
xlabel('samples');
ylabel('electrical activity');
title('ECG Signal Sampled at 100hz');
%fast fourier transform and Inverse fourier Transform%%%%%%%
y = fft(sig);
z = abs(y);
subplot(3,1,2);
plot(z);
title('Fast Fourier Transform OF ECG SIGNAL');
w = ifft(y);
v = abs(w);
subplot(3,1,3);
plot(v);
title('Inverse Fast Fourier Transform OF ECG SIGNAL');
% It counts the dominant peaks on the signal for the data
provided
%peaks are defined as samples with amplitude greater than
the ones beside
%them and greater than one
beat_count = 0;
for k = 2 : length(sig)-1
if(sig(k)>sig(k-1) & sig(k)>sig(k+1) & sig(k)>1)
k
disp('prominent peak found');
beat_count = beat_count + 1;
end
end
% divide the no. of beats counted by the signal duration (in mins)
beat_count = 0;
fs = 100;
N = length(sig);
duration_in_seconds = N/fs;
duration_in_minutes = duration_in_seconds/60;
BPM = beat_count/duration_in_minutes
if BPM<60
disp('The Patient has an abnormally Low heart rate');
elseif BPM>100
disp('The Patient has an abnormally High heart rate');
else 60<BPM<100
disp('The Patient has a normal heart rate');
end
%%%%Signal_Conditioning%%%%%%
x = sig;
y = sgolayfilt(x,0,5);
[M,N] = size(y);
Fs = 1000 ;
TS = timescope('SampleRate',Fs,...
    'TimeSpanSource','Property',...
'TimeSpan',1.5,...
'ShowGrid',true,...
'NumInputPorts',2,...
'LayoutDimensions',[2 1]);
TS.ActiveDisplay = 1;
TS.YLimits = [-1,1];
TS.Title = 'Noisy Signal';
TS.ActiveDisplay = 2;
TS.YLimits = [-1,1];
TS.Title = 'Filtered Signal';
Fpass = 200;
Fstop = 400;
Dpass = 0.05;
Dstop = 0.0001;
F = [0 Fpass Fstop Fs/2]/(Fs/2);
A = [1 1 0 0];
D = [Dpass Dstop];
b = firgr('minorder',F,A,D);
LP = dsp.FIRFilter('Numerator',b);
Fstop = 200;
Fpass = 400;
Dstop = 0.0001;
Dpass = 0.05;
F = [0 Fstop Fpass Fs/2]/(Fs/2); % Frequency vector
A = [0 0 1 1];
Amplitude vector
D = [Dstop Dpass]; % Deviation (ripple) vector
b = firgr('minord',F,A,D);
HP = dsp.FIRFilter('Numerator',b);
tic;
while toc < 30
x = .1 * randn(M,N);
highFreqNoise = HP(x);
noisySignal = y + highFreqNoise;
filteredSignal = LP(noisySignal);
TS(noisySignal,filteredSignal);
end
release(TS)