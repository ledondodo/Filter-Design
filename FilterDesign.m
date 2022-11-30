clear all
clc

% remove '%' in the code to show the plot

nuc=1/16;
L=51;
m=26;

syms n
h(n)=sin(2*pi*nuc*(n-m))/pi/(n-m);

samples=zeros(L,1);
for i = 1:L
    if i==m
        samples(i)=2*nuc;
    else
        samples(i)=h(i);
    end
end

w=window(@blackman,L);

hl=zeros(L,1);
for i = 1:L
    hl(i)=w(i)*samples(i);
end

% PLOT hl
%stem(hl);

nu=0:0.002:1;
HL=zeros(500,1);
for n = 1:L
    HL=HL+hl(n)*exp(-1i*2*pi*nu*n);
end

% PLOT HL
%plot(nu,20*log10(abs(HL)));
%plot(nu,20*log10(abs(HL)),nu,20*log10(abs(fft(hl,501)))); % compare for-loop to fft

imp=[zeros(25,1);1;zeros(25,1)];
r=zeros(L,1);
for i = 1:L
    r(i)=imp(i)-hl(i);
end

% PLOT IMPULSE RESPONSE
%stem(r);
%plot(nu,20*log10(abs(fft(r,501))));

F=9;
hr=zeros(L,1);
hr=2^-F*round(hl*2^F);
HR=zeros(500,1);
for n = 1:L
    HR=HR+hr(n)*exp(-1i*2*pi*nu*n);
end

% PLOT ROUNDED SIGNAL
%stem(hr);
%plot(nu,20*log10(abs(HR)));

sig=2^(-2*F)/12;
Exl=0;
for n = 1:L
    Exl=Exl+hl(n)^2;
end
Exl=Exl*sig;
Exq=0;
for n = 1:L
    Exq=Exq+(hl(n)-hr(n))^2;
end
Exq=Exq*sig;
SQNR=Exl/Exq;
SQNRdB=10*log10(SQNR);
snr(hl,hl-hr); % comparison with the matlab formula

