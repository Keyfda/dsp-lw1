%% 
% *Проверка свойств преобразования Фурье с помощью вычислений*

clear;
syms t w a b real
syms f(t) g(t) tau 

norm = str2sym('sqrt(2*pi)');

f(t) = sin(t);
g(t) = sin(2*t);

F = fourier(f(t), t, w)/norm ;
G = fourier(g(t), t, w)/norm;
%% 
% 

left = fourier(a*f(t) + b*g(t))/norm;
right = a*F + b*G;

disp('1. Линейность:')
disp(left);
disp(right);
disp(simplify(left - right));

%% 
% 

left = fourier(f(t - a))/norm;
right = exp(-1i*w*a) * F;

disp('2. Сдвиг во времени:')
disp(left);
disp(right);
disp(simplify(left-right));
%% 
% 

left = fourier(exp(1i*a*t)*f(t))/norm;
right = subs(F, w, w - a);

disp('3. Сдвиг по частоте:')
disp(left);
disp(right);
disp(left - right);
%% 
% 

left = fourier(f(a*t))/norm;
right = (1/abs(a))*subs(F, w, w/a);

disp('4. Масштабирование:')
disp(left);
disp(right);
disp(simplify(left-right));
%% 
% 

left = fourier(diff(f, t))/norm;
right = 1i*w*F;

disp('5. Дифференциирование по времени:')
disp(left);
disp(right);
disp(simplify(left-right));
%% 
% 

left = fourier(t*f(t))/norm;
right = 1i*diff(F, w);

disp('6. Дифференциирвоание по частоте:')
disp(left);
disp(right);
disp(simplify(left-right));
%% 
% 

ff = symfun(exp(-t^2), t);
gg = symfun(exp(-2*t^2), t);

FF = fourier(ff(t), t, w) / norm;
GG = fourier(gg(t), t, w) / norm;

conv_fg = int(ff(tau) * gg(t - tau), tau, -inf, inf);

left  = fourier(conv_fg, t, w) / norm;
right = norm * FF * GG;

disp('7. Свёртка в произведение:')
disp(left);
disp(right);
%% 
% 

ff = symfun(exp(-t^2), t);
gg = symfun(exp(-2*t^2), t);

FF = fourier(ff(t), t, w) / norm;
GG = fourier(gg(t), t, w) / norm;

conv_fg = ff(t) * gg(t);
left = fourier(conv_fg, t, w) / norm;
right = int(subs(FF, w, tau) * subs(GG, w, w - tau), tau, -inf, inf) / norm;

disp('7. Произведение в свертку:')
disp(left)
disp(right)
%% 
% 

left = fourier(dirac(t), t, w) / norm;
right = 1/ norm;

disp('9. Преобразвоание функции Дирака:')
disp(left);
disp(right);
%% 
% 

left = fourier(1, t, w) / norm;
right = norm * dirac(w);

disp('10. Преобразование единицы (константы):')
disp(left);
disp(right);
%% 
% *Проверка 1, 2, 4, 7, 8 свойств с помощью функции fft*

N = 128;
n = 0:N-1;
k = 0:N-1;

x = sin(2*pi*5*n/N);
y = cos(2*pi*12*n/N);

X = fft(x);
Y = fft(y);
%% 
% # *Линейность*

a = 2;
b = -3;

left  = fft(a*x + b*y);
right = a*X + b*Y;
disp('1. Линейность:')
disp(norm(left - right));
%% 
% *2. Сдвиг во времени*

m = 7;

x_shift = circshift(x, m);
left  = fft(x_shift);
right = X .* exp(-1i*2*pi*k*m/N);

disp('2. Сдвиг по времени:')
disp(norm(left - right));
%% 
% *4. Масштабирование*

a = 2;

x_pad = [x zeros(1, (a-1)*N)];
left  = fft(x_pad);

X_pad = fft(x_pad);
right = interp1(0:length(X_pad)-1, X_pad, (0:N-1)*a, 'linear', 0);

disp('4. Масштабирование:')
disp(norm(left(1:N) - right));
%% 
% *7. Свертка в произведние*

left  = ifft(X .* Y);
right = cconv(x, y, N);

disp('7. Свёртка в произведение:')
disp(norm(left - right));
%% 
% *8. Происзведение в свертку*

left  = fft(x .* y);
right = cconv(X, Y, N);

disp('8. Произведение в свертку:')
disp(norm(left - right));