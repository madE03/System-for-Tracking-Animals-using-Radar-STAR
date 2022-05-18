% x1 = 0:1:4;
% x2 = 4:1:8;
% 
% y1 = (4*x1+2)/3;
% y2 = 6-5*(x2-4)/4;
% 
% x = [x1,x2];
% y = [y1,y2];
% 
% plot(x,y)
% xlim([0,9]);
x1 = -pi:pi/10:pi;
y1 = tan(sin(x1)) - sin(tan(x1));
d = sqrt(x1.^2 + y1.^2);
theta = atan(y1./x1);
l1 = length(x1);

fs = 160e9; %Sampling frequency 10 GHz
ts = 1/fs; %Sampling interval
L = 160000*4;
t = (0:L-1)*ts; %Time vector
l = length(t);
f = fs*(0:l-1)/l;

f1 = 60*10^9; %Minimum frequency
f2 = 64*10^9; %Maximum frequency
K = 1e15; %Chirp slope
chirp = 100*cos(2*pi*f1*t + pi*K*t.^2); %Sawtooth FMCW
c = 3*10^8;
%theta = [1.5708,1.1071,1.0304,0.9995,0.9828,0.9828,0.7598,0.5281,0.3110,0.1244];
%d = [0.6667,2.2361,3.8873,5.5478,7.2111,7.2111,6.8966,6.9462,7.3527,8.0623];

d_found = zeros(1,l1);
x_new = zeros(1,l1);
y_new = zeros(1,l1);
td = 2*d/c;
%l1 = length(d);

for i = 1:l1
    y = (delayseq(chirp',td(i),fs))';
    beat = dechirp(y',chirp');
    P2 = (abs(fft(beat/l)));
    P1 = P2(1:l/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    [max_val,index] = max(P1(1:5000,1));
    f_beat = f(index) %beat frequency
    d_found(i) = beat2range(f_beat,K,c) %range
    x_new(i) = d_found(i)*cos(theta(i));
    y_new(i) = d_found(i)*sin(theta(i));
end
% c = linspace(1,10,length(x_new));
% scatter(x_new,y_new,[],c,'filled');
% %plot([x1,x2],[y1,y2]);
% %title('Map of animals - Simulation')
% xlabel('x-axis');ylabel('y-axis');
% axis([0,10,0,10]);
figure();
plot(x_new,y_new,'--gs',...
    'LineWidth',2,...
    'MarkerSize',10,...
    'MarkerEdgeColor','b',...
    'MarkerFaceColor',[0.5,0.5,0.5])
title('Tracking the movement of a single animal');
xlabel('x-axis');ylabel('y-axis');
h = animatedline;
h.Color = 'red';
% for i = 1:length(x_new)
%     %figure();
%     addpoints(h,x_new(i),y_new(i));
%     drawnow;pause(0.00001);
%     title("Tracking motion of an animal");
%     
% end


