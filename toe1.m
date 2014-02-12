% Часть 1.
% Расчёт величин B(k), C(k) и Um(k) и начальной фазы Pci(k) (k=1 - kmax) табл. 5.3
clear
echo off
kmax=input('kmax - максимальное число используемых гармоник; задайте kmax=');
Umm=100; T=0.01;
k=1:kmax;
Bk=(Umm./(pi*k)).*(2*sin(pi*k/4).^2-cos(3*pi*k/2)+cos(2*pi*k))  % Здесь забить свои хтонические формулы
Ck=(Umm./(pi*k)).*(sin(pi*k/2)+sin(3*pi*k/2)-sin(2*pi*k))       % Сделать тоже самое, при этом постаратся не вызвать Ктулху 
Umk=sqrt(Bk.^2+Ck.^2)
    Pcik=atan2(Ck,Bk);
Pcikgr=atan2(Ck,Bk);
% Построение графика дискретного спектра амплитуд входного напряжения
figure(1)
U0=0;  % Вместо 0 подставь своё значение
Uspectr=[1:kmax+1];
Uspectr(1)=U0;
q=2:kmax+1;
Uspectr(q)=Umk(q-1);
kk=0:kmax;
stem(kk,Uspectr),grid;

pause
% Сравнение кривых заданного и приближенных наапряжений
figure(3)
omg1=2*pi/T;
nt=1;
for t=0:T/(10*kmax):T;
tt(nt)=t;
    % 1. Построение столбца точных значений u(nt)
u(nt)=0;
if t<=T/4;              % Немного подумай и запиши свою кусочную функцию или что там у тебя
    u(nt)=Umm;
elseif t<=3*T/4
        u(nt)=0;
else
    u(nt)=-Umm;
end
   % 2. Построение столбца приближённых значений uu(nt)
   a=0;
   for v=1:kmax;
   a=a+Umk(v)*sin(v*omg1*t+Pcik(v));
   end
uu(nt)=a+U0;
nt=nt+1;
end
plot(tt,[uu',u']),grid
pause
