%3) Seja x1(t) um coseno com frequência f1 = 800 Hz, x2(t) um coseno com frequência f2 = 2000
%Hz, e x3(t) um coseno com frequência f3 = 4500 Hz. Seja x(t) = x1(t) + 0.5x2(t) + 2x3(t).
%Use x(t) como sinal de entrada a cada um dos três filtros projetados no item anterior. Faça o
%gráfico dos espectros e explique o que ocorreu.

time=3;                                 % length of time 
Ts=1/10000;                             % time interval between samples
t = 0:1/Ts:time;
x1 = cos(2*pi*800*t);
x2 = cos(2*pi*2000*t);
x3 = cos(2*pi*4500*t);
x=x1 + 0.5*x2 + 2*x3;                     % generate noise signal
figure(1),plotspec(x,Ts)                % draw spectrum of input
fa = 10000;

fc = 500;
f1 = ((fc-100)/(fa/2));
f2 = ((fc+100)/(fa/2));
b=remez(100,[0 f1 f2 1],[0 0 1 1]);  % specify the LP filter
ylp=filter(b,1,x);                      % do the filtering                   
figure(2),plotspec(ylp,Ts)              % plot the output spectrum

fc = 3000;
f1 = ((fc-100)/(fa/2));
f2 = ((fc+100)/(fa/2));
b=remez(100,[0 f1 f2 1],[1 1 0 0]); % BP filter
ybp=filter(b,1,x);                      % do the filtering                   
figure(3),plotspec(ybp,Ts)              % plot the output spectrum

fc = 1500;
fc2 = 2500;
f1 = ((fc-100)/(fa/2));
f2 = ((fc+100)/(fa/2));
f3 = ((fc2-100)/(fa/2));
f4 = ((fc2+100)/(fa/2));
b=remez(100,[0 f1 f2 f3 f4 1],[1 1 0 0 1 1]); % specify the HP filter
yhp=filter(b,1,x);                      % do the filtering                   
figure(4),plotspec(yhp,Ts)              % plot the output spectrum

%Here's how the figure filternoise.eps was actually drawn
N=length(x);                            % length of the signal x
t=Ts*(1:N);                             % define a time vector 
ssf=(-N/2:N/2-1)/(Ts*N);                % frequency vector
fx=fftshift(fft(x(1:N)));                
figure(5), subplot(4,1,1), plot(ssf,abs(fx))
xlabel('magnitude spectrum at input')
fyl=fftshift(fft(ylp(1:N)));                
subplot(4,1,2), plot(ssf,abs(fyl))
xlabel('magnitude spectrum at output of low pass filter')
fybp=fftshift(fft(ybp(1:N)));                
subplot(4,1,3), plot(ssf,abs(fybp))
xlabel('magnitude spectrum at output of band pass filter')
fyhp=fftshift(fft(yhp(1:N)));                
subplot(4,1,4), plot(ssf,abs(fyhp))
xlabel('magnitude spectrum at output of high pass filter')
