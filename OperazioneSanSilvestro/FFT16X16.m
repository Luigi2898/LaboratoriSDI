
x = linspace(0, 2*pi, 16);
y1 = 0.003 .* sin(x);
%y = 0.003 * ones(16,1);
yf1 = fi(y1, 1, 24, 23);
yint1 = int(yf1);
T1 = table(bin(yf1'));
writetable(T1, "input_sin_new_little.txt");

y2 = 0.003 .* cos(x);
%y = 0.003 * ones(16,1);
yf2 = fi(y2, 1, 24, 23);
yint2 = int(yf2);
T2 = table(bin(yf2'));
writetable(T2, "input_cos_new_little.txt");

Xr = yf1*2^23; %parte reale del vettore di ingresso
Xi = yf2*2^23; %parte immaginaria del vettore di ingresso
m = [0:1:7];
Wr = cos(2*pi.*m/16); %parte reale dei tweedle factor
Wi = -sin(2*pi.*m/16); %parte immaginaria dei tweedle factor

%Primo stadio
[Ar1 Ai1 Br1 Bi1] = butterfly(Xr(1), Xi(1), Xr(9), Xi(9), Wr(1), Wi(1));
[Ar2 Ai2 Br2 Bi2] = butterfly(Xr(2), Xi(2), Xr(10), Xi(10), Wr(1), Wi(1));
[Ar3 Ai3 Br3 Bi3] = butterfly(Xr(3), Xi(3), Xr(11), Xi(11), Wr(1), Wi(1));
[Ar4 Ai4 Br4 Bi4] = butterfly(Xr(4), Xi(4), Xr(12), Xi(12), Wr(1), Wi(1));
[Ar5 Ai5 Br5 Bi5] = butterfly(Xr(5), Xi(5), Xr(13), Xi(13), Wr(1), Wi(1));
[Ar6 Ai6 Br6 Bi6] = butterfly(Xr(6), Xi(6), Xr(14), Xi(14), Wr(1), Wi(1));
[Ar7 Ai7 Br7 Bi7] = butterfly(Xr(7), Xi(7), Xr(15), Xi(15), Wr(1), Wi(1));
[Ar8 Ai8 Br8 Bi8] = butterfly(Xr(8), Xi(8), Xr(16), Xi(16), Wr(1), Wi(1));

%Secondo stadio
[Ar11 Ai11 Br11 Bi11] = butterfly(Ar1, Ai1, Ar5, Ai5, Wr(1), Wi(1));
[Ar12 Ai12 Br12 Bi12] = butterfly(Ar2, Ai2, Ar6, Ai6, Wr(1), Wi(1));
[Ar13 Ai13 Br13 Bi13] = butterfly(Ar3, Ai3, Ar7, Ai7, Wr(1), Wi(1));
[Ar14 Ai14 Br14 Bi14] = butterfly(Ar4, Ai4, Ar8, Ai8, Wr(1), Wi(1));

[Ar15 Ai15 Br15 Bi15] = butterfly(Br1, Bi1, Br5, Bi5, Wr(5), Wi(5));
[Ar16 Ai16 Br16 Bi16] = butterfly(Br2, Bi2, Br6, Bi6, Wr(5), Wi(5));
[Ar17 Ai17 Br17 Bi17] = butterfly(Br3, Bi3, Br7, Bi7, Wr(5), Wi(5));
[Ar18 Ai18 Br18 Bi18] = butterfly(Br4, Bi4, Br8, Bi8, Wr(5), Wi(5));

%Terzo stadio
[Ar111 Ai111 Br111 Bi111] = butterfly(Ar11, Ai11, Ar13, Ai13, Wr(1), Wi(1));
[Ar112 Ai112 Br112 Bi112] = butterfly(Ar12, Ai12, Ar14, Ai14, Wr(1), Wi(1));

[Ar113 Ai113 Br113 Bi113] = butterfly(Br11, Bi11, Br13, Bi13, Wr(5), Wi(5));
[Ar114 Ai114 Br114 Bi114] = butterfly(Br12, Bi12, Br14, Bi14, Wr(5), Wi(5));

[Ar115 Ai115 Br115 Bi115] = butterfly(Ar15, Ai15, Ar17, Ai17, Wr(3), Wi(3));
[Ar116 Ai116 Br116 Bi116] = butterfly(Ar16, Ai16, Ar18, Ai18, Wr(3), Wi(3));

[Ar117 Ai117 Br117 Bi117] = butterfly(Br15, Bi15, Br17, Bi17, Wr(7), Wi(7));
[Ar118 Ai118 Br118 Bi118] = butterfly(Br16, Bi16, Br18, Bi18, Wr(7), Wi(7));

%Quarto stadio
[Or(1) Oi(1) Or(9) Oi(9)]     = butterfly(Ar111, Ai111, Ar112, Ai112, Wr(1), Wi(1));
[Or(5) Oi(5) Or(13) Oi(13)]   = butterfly(Br111, Bi111, Br112, Bi112, Wr(5), Wi(5));

[Or(3) Oi(3) Or(11) Oi(11)]   = butterfly(Ar113, Ai113, Ar114, Ai114, Wr(3), Wi(3));
[Or(7) Oi(7) Or(15) Oi(15)]   = butterfly(Br113, Bi113, Br114, Bi114, Wr(7), Wi(7));

[Or(2) Oi(2) Or(10) Oi(10)]   = butterfly(Ar115, Ai115, Ar116, Ai116, Wr(2), Wi(2));
[Or(6) Oi(6) Or(14) Oi(14)]   = butterfly(Br115, Bi115, Br116, Bi116, Wr(6), Wi(6));

[Or(4) Oi(4) Or(12) Oi(12)]   = butterfly(Ar117, Ai117, Ar118, Ai118, Wr(4), Wi(4));
[Or(8) Oi(8) Or(16) Oi(16)]   = butterfly(Br117, Bi117, Br118, Bi118, Wr(8), Wi(8));

%risultato_sin = [-3 0 -2 -1668958 -72613 175301 373225 901045 -56024 56022 -119947 119947 35554 -85835 36695 -88589 -53489 0 -159849 0 -53912 -22331 -928995 384805 -56024 -56022 -260393 -260393 -162078 -67135 1477847 1477847]

%risultato_delta = [4026518 4026518 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];

%risultato_sin_compl = [-3 -3 2272217 -1518247 -247913 102689 -797175 1193057 -112046 -2 -91070 -18115 121389 -50281 -82345 16379 -53489 -53489 -42927 -64245 -31581 -76243 -1222823 -817065 -2 -112046 29555 -148585 -94943 -229213 353150 353150];

%risultato_sin_compl = [-7 -7 -486787 2447232 -247914 102688 -119534 -79871 -112046 0 -86832 58017 -31581 -76243 -217951 -1095706 -53490 -53490 -1095706 -217951 -31581 -76243 58017 -86832 0 -112046 -79871 -119534 -247914 102688 2447232 2447232];

%OK!!! risultato_sin_compl = [-2 -2 -151824 227218 10268 -24790 -7987 -11955 -11204 2 -8687 5803 -3158 -7625 -6426 -4294 -5348 -5348 -4294 -6426 -3158 -7625 -8687 5803 2 -11204 -7987 -11955 -24790 10268 227218 -151824];

risultato_sin_compl = [-2
25159
-2590
13005
-3534
8534
-4061
6075
-4411
4412
-4685
3128
-4917
2036
-5133
1021
-5348
2
-5588
-1111
-5866
-2430
-6233
-4165
-6791
-6794
-7847
-11742
-10988
-26525
77982
392045];

O_SS_r = risultato_sin_compl(1:2:31);
O_SS_i = risultato_sin_compl(2:2:32);

close all

figure(58)
plot(sqrt((Or).^2 + (Oi).^2), '-*r');
grid on
hold on
plot(abs(fft((y1 + i*y2).*2^23)), '-og');
hold on
plot(abs(O_SS_r + i*O_SS_i), '-b')

clear all
x = linspace(0, 2*pi, 16);
y1 = 0.003 .* sin(x);
y2 = zeros(1,16);
yf1 = fi(y1, 1, 24, 23);
yf2 = fi(y2, 1, 24, 23)
Xi = yf1*2^23; %parte reale del vettore di ingresso
Xr = yf2*2^23; %parte immaginaria del vettore di ingresso
m = [0:1:7];
Wr = cos(2*pi.*m/16); %parte reale dei tweedle factor
Wi = -sin(2*pi.*m/16); %parte immaginaria dei tweedle factor

%Primo stadio
[Ar1 Ai1 Br1 Bi1] = butterfly(Xr(1), Xi(1), Xr(9), Xi(9), Wr(1), Wi(1));
[Ar2 Ai2 Br2 Bi2] = butterfly(Xr(2), Xi(2), Xr(10), Xi(10), Wr(1), Wi(1));
[Ar3 Ai3 Br3 Bi3] = butterfly(Xr(3), Xi(3), Xr(11), Xi(11), Wr(1), Wi(1));
[Ar4 Ai4 Br4 Bi4] = butterfly(Xr(4), Xi(4), Xr(12), Xi(12), Wr(1), Wi(1));
[Ar5 Ai5 Br5 Bi5] = butterfly(Xr(5), Xi(5), Xr(13), Xi(13), Wr(1), Wi(1));
[Ar6 Ai6 Br6 Bi6] = butterfly(Xr(6), Xi(6), Xr(14), Xi(14), Wr(1), Wi(1));
[Ar7 Ai7 Br7 Bi7] = butterfly(Xr(7), Xi(7), Xr(15), Xi(15), Wr(1), Wi(1));
[Ar8 Ai8 Br8 Bi8] = butterfly(Xr(8), Xi(8), Xr(16), Xi(16), Wr(1), Wi(1));

%Secondo stadio
[Ar11 Ai11 Br11 Bi11] = butterfly(Ar1, Ai1, Ar5, Ai5, Wr(1), Wi(1));
[Ar12 Ai12 Br12 Bi12] = butterfly(Ar2, Ai2, Ar6, Ai6, Wr(1), Wi(1));
[Ar13 Ai13 Br13 Bi13] = butterfly(Ar3, Ai3, Ar7, Ai7, Wr(1), Wi(1));
[Ar14 Ai14 Br14 Bi14] = butterfly(Ar4, Ai4, Ar8, Ai8, Wr(1), Wi(1));

[Ar15 Ai15 Br15 Bi15] = butterfly(Br1, Bi1, Br5, Bi5, Wr(5), Wi(5));
[Ar16 Ai16 Br16 Bi16] = butterfly(Br2, Bi2, Br6, Bi6, Wr(5), Wi(5));
[Ar17 Ai17 Br17 Bi17] = butterfly(Br3, Bi3, Br7, Bi7, Wr(5), Wi(5));
[Ar18 Ai18 Br18 Bi18] = butterfly(Br4, Bi4, Br8, Bi8, Wr(5), Wi(5));

%Terzo stadio
[Ar111 Ai111 Br111 Bi111] = butterfly(Ar11, Ai11, Ar13, Ai13, Wr(1), Wi(1));
[Ar112 Ai112 Br112 Bi112] = butterfly(Ar12, Ai12, Ar14, Ai14, Wr(1), Wi(1));

[Ar113 Ai113 Br113 Bi113] = butterfly(Br11, Bi11, Br13, Bi13, Wr(5), Wi(5));
[Ar114 Ai114 Br114 Bi114] = butterfly(Br12, Bi12, Br14, Bi14, Wr(5), Wi(5));

[Ar115 Ai115 Br115 Bi115] = butterfly(Ar15, Ai15, Ar17, Ai17, Wr(3), Wi(3));
[Ar116 Ai116 Br116 Bi116] = butterfly(Ar16, Ai16, Ar18, Ai18, Wr(3), Wi(3));

[Ar117 Ai117 Br117 Bi117] = butterfly(Br15, Bi15, Br17, Bi17, Wr(7), Wi(7));
[Ar118 Ai118 Br118 Bi118] = butterfly(Br16, Bi16, Br18, Bi18, Wr(7), Wi(7));

%Quarto stadio
[Or(1) Oi(1) Or(9) Oi(9)]     = butterfly(Ar111, Ai111, Ar112, Ai112, Wr(1), Wi(1));
[Or(5) Oi(5) Or(13) Oi(13)]   = butterfly(Br111, Bi111, Br112, Bi112, Wr(5), Wi(5));

[Or(3) Oi(3) Or(11) Oi(11)]   = butterfly(Ar113, Ai113, Ar114, Ai114, Wr(3), Wi(3));
[Or(7) Oi(7) Or(15) Oi(15)]   = butterfly(Br113, Bi113, Br114, Bi114, Wr(7), Wi(7));

[Or(2) Oi(2) Or(10) Oi(10)]   = butterfly(Ar115, Ai115, Ar116, Ai116, Wr(2), Wi(2));
[Or(6) Oi(6) Or(14) Oi(14)]   = butterfly(Br115, Bi115, Br116, Bi116, Wr(6), Wi(6));

[Or(4) Oi(4) Or(12) Oi(12)]   = butterfly(Ar117, Ai117, Ar118, Ai118, Wr(4), Wi(4));
[Or(8) Oi(8) Or(16) Oi(16)]   = butterfly(Br117, Bi117, Br118, Bi118, Wr(8), Wi(8));
risultato_sin_compl = [-3
0
376984
-1895233
-72613
175301
-59515
89070
-56024
56022
-54593
36477
-53912
22331
-53586
10659
-53489
0
-53586
-10660
-53912
-22331
-54593
-36478
-56024
-56022
-59515
-89071
-72613
-175301
376984
1895232];

O_SS_r = risultato_sin_compl(1:2:31);
O_SS_i = risultato_sin_compl(2:2:32);

figure(18)
plot(sqrt((Or).^2 + (Oi).^2), '-*r');
grid on
hold on
plot(abs(fft((y2 + i*y1).*2^23)), '-og');
hold on
plot(abs(O_SS_r + i*O_SS_i), '-b')

figure(19)
plot(Or,'r')
hold on
grid on
plot(O_SS_r, 'b')

figure(110)
plot(Oi,'r')
hold on
grid on
plot(O_SS_i, 'b')
