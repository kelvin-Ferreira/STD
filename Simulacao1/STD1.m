pkg load signal

% Parametro: f1 = 2kHz e f2 = 2.3kHz.
% n(t) = cos(2pi*2k*t) + cos(2pi*2.3k*t)

[x, taxa] = audioread('exemplo.wav');
sound(x, taxa);
tempo = length(x)/taxa;
f1 = 2000;
f2 = 2300;
t = 0;
n = zeros(1, length(x));
cont = 0;
z = zeros(1, length(x));
Ts = 1 / taxa;

for i = 1:length(x)
    t = cont/taxa;
    cont = cont+1;
    n(i) = cos(2*pi*f1*t) + cos(2*pi*f2*t);
    z(i) = x(i) + n(i);
end

sound(n, taxa);
sound(z, taxa);

ny = taxa/2;
fn0 = 1900/ny;
fn1 = f1/ny;
fn2 = f2/ny;
fn3 = 2400/ny;

F = [0 fn0 fn1 fn2 fn3 1];
a = [1 1 0 0 1 1];
b = remez(980, F, a);
y = filter(b, 1, z);

sound(y, taxa);
audiowrite('sinal_filtrado.wav', y, taxa);

%Frequencia

N=length(x);
ssf=(-N/2:N/2-1)/(Ts*N);

fx=fftshift(fft(x(1:N)));
figure(), subplot(4,1,1), plot(ssf,abs(fx));
xlabel('Espectro de magnitudes da entrada');
title('Entrada no dominio da frequencia');

fn=fftshift(fft(n(1:N)));
subplot(4,1,2), plot(ssf,abs(fn));
xlabel('Espectro de magnitudes do ruido');
title('Ruido no dominio da frequencia');

fz=fftshift(fft(z(1:N)));
subplot(4,1,3), plot(ssf,abs(fz));
xlabel('Espectro de magnitudes do sinal ruidoso');
title('Sinal ruidoso no dominio da frequencia');

fy=fftshift(fft(y(1:N)));
subplot(4,1,4), plot(ssf,abs(fy));
xlabel('Espectro de magnitudes da saida');
title('Saida do filtro no dominio da frequencia');

%Tempo

t = (0:length(x)-1) / taxa;

figure(), subplot(4,1,1), plot(t,x)
xlabel('Segundos'); ylabel('Amplitude');
title('Entrada no dominio do tempo');

subplot(4,1,2), plot(t,n)
xlabel('Segundos'); ylabel('Amplitude');
title('Ruido no dominio do tempo');

subplot(4,1,3), plot(t,z)
xlabel('Segundos'); ylabel('Amplitude');
title('Sinal ruidoso no dominio do tempo');

subplot(4,1,4), plot(t,y)
xlabel('Segundos'); ylabel('Amplitude');
title('Saida do filtro no dominio do tempo');

%Resposta em frequencia

figure(), subplot(2,1,1), freqz(b, 1);
title('Respota na frequencia do filtro');

%Resposta ao impulso

subplot(2,1,2), impz(b,1)
title('Respota ao impulso do filtro');





