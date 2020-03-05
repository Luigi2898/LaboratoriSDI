close all
clear all
clc
%%
n = 2^-20.*rand(1000000,1);
n = n - mean(n);
nfi = fi(n, 1, 47, 46);
b = bin(nfi);
t = table(b);
writetable(t, 'input.txt');
plot(n)
%%
tout = readtable('output.txt');
rounded = table2array(tout)./2^23;
%%
tout1 = readtable('output.txt');
rounded1 = table2array(tout1)./2^23;
%%
 plot(rounded(2:end))
 hold on
 plot(nfi(1:end-1))
%%
err = rounded(2:end)-nfi(1:end-1);
foud_bias = mean(err)
theo_bias = 1/2*(2^-23-2^-2)
%%
err1 = rounded1(1:end)-nfi(1:end);
foud_bias1 = mean(err1)
%%
plot(err1)
hold on
plot(err)
%%
disp = std(err)
%disp1 = std(err1)