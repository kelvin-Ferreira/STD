% filternoise.m filter a noisy signal three ways

%2) A partir do código em filternoise.m crie um filtro que: (a) passe todas as frequências acima
%de 500 Hz, (b) passe todas as frequências abaixo de 3 kHz, (c) rejeite todas as frequências
%entre 1.5 kHz e 2.5 kHz, (d) reprojete os três filtros anteriores considerando que a frequência
%de amostragem foi alterada para Fs = 20 kHz. Fs inicial = 10kHz.

time=3;                                 % length of time 
Ts=1/20000;                             % time interval between samples
x=randn(1,time/Ts);                     % generate noise signal
figure(1),plotspec(x,Ts)                % draw spectrum of input
fa = 20000;

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
