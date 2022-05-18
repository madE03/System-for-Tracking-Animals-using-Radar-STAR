fs = 160e9; %Sampling frequency 10 GHz
ts = 1/fs; %Sampling interval
L = 160000;
t = (0:L-1)*ts; %Time vector
l = length(t);
f = fs*(-l/2:l/2-1)/l;

f1 = 60*10^9; %Minimum frequency
f2 = 61*10^9; %Maximum frequency
K = 1e15; %Chirp slope
x = 150*cos(2*pi*f1*t + pi*K*t.^2); %Sawtooth FMCW
c = 3*10^8;

fs1 = 20;
ts1 = 1/fs1;
L1 = 300;
t1 = (0:L1-1)*ts1;
f1 = fs1*(-L1/2:L1/2-1)/L1;
f_h_1 = 1;
f_h_2 = 0.2;
f_h_3 = 0.6;
f_h_4 = 1;
f_h_5 = 0.7;

f_r = 0.2;
f_b = 6; %for the filter

%heart_2 = exp(-t1);
% heart_1 = 1*cos(2*pi*f_h_1*t1);%  + 0.2*cos(2*pi*f_r*t1);
heart_2 = 1*cos(2*pi*f_h_2*t1);
%heart_3 = 1*cos(2*pi*f_h_3*t1);
%heart_4 = 1*cos(2*pi*f_h_4*t1);
% heart_5 = 1*cos(2*pi*f_h_5*t1);
filter = sinc(2*f_b*t1); %To filter out the noise

index = 60; %index of the complex range bin
h = animatedline;
h.Color = 'red';
for i = 1:L1
%     td_1 = 2*(5+heart_1(i))/c;
td_2 = 2*(5+heart_2(i))/c;
%     td_3 = 2*(5+heart_3(i))/c;
%     td_4 = 2*(5+heart_4(i))/c;
%     td_5 = 2*(5+heart_5(i))/c;

%     y_1(i,:) = (delayseq(x',td_1,fs))';
y_2(i,:) = (delayseq(x',td_2,fs))';
%     y_3(i,:) = (delayseq(x',td_3,fs))';
%     y_4(i,:) = (delayseq(x',td_4,fs))';
%     y_5(i,:) = (delayseq(x',td5,fs))';

%     beat_1(i,:) = dechirp(y_1(i,:)',x');
beat_2(i,:) = dechirp(y_2(i,:)',x');
%     beat_3(i,:) = dechirp(y_3(i,:)',x');
%     beat_4(i,:) = dechirp(y_4(i,:)',x');
%     beat_5(i,:) = dechirp(y_5(i,:)',x');

%     beat_fft_1(i,:) = (fftshift(fft(beat_1(i,:)/l)));
beat_fft_2(i,:) = (fftshift(fft(beat_2(i,:)/l)));
%     beat_fft_3(i,:) = (fftshift(fft(beat_3(i,:)/l)));
%     beat_fft_4(i,:) = (fftshift(fft(beat_4(i,:)/l)));
%     beat_fft_5(i,:) = (fftshift(fft(beat_5(i,:)/l)));
    
%     beat_angle_1(i,:) = angle(beat_fft_1(i,:));
beat_angle_2(i,:) = angle(beat_fft_2(i,:));
%     beat_angle_3(i,:) = angle(beat_fft_3(i,:));
%     beat_angle_4(i,:) = angle(beat_fft_4(i,:));
%     beat_angle_5(i,:) = angle(beat_fft_5(i,:));

end
% heart_check_1 = unwrap(beat_angle_1(:,index));
heart_check_2 = unwrap(beat_angle_2(:,index));
% heart_check_3 = unwrap(beat_angle_3(:,index));
% heart_check_4 = unwrap(beat_angle_4(:,index));
% heart_check_5 = unwrap(beat_angle_5(:,index));

%heart_check_1 = unwrap(heart_check);
%output_1 = conv(heart_check_1,filter);
output_2 = conv(heart_check_2,filter);
%output_3 = conv(heart_check_3,filter);
%output_4 = conv(heart_check_4,filter);
% output_5 = conv(heart_check_5,filter);

% figure();
% %subplot(3,2,1);
% plot(t1,output_1(1:length(t1)));

% subplot(3,2,2);
% plot(t1,output_2(1:length(t1)));
% 
% subplot(3,2,3);
% plot(t1,output_3(1:length(t1)));
% 
% subplot(3,2,4);
% plot(t1,output_4(1:length(t1)));
% 
% subplot(3,2,5);
% plot(t1,output_5(1:length(t1)));
%plot(f1,abs(fftshift(fft(output(1:length(t1)))/L1)));
for i = 1:length(output_2)
    addpoints(h,t1(i),output_2(i));
    drawnow;
    xlabel('Time');ylabel('Amplitude');legend('frequency - 0.2 Hz')
end