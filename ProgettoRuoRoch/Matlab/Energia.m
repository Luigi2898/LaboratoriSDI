%Generazione campioni
x = linspace(0,2*pi,1000);
y = sin(x)*0.9;
%fixedpoint
y = fi(y);
y = y';
%plot(y, '-o')
%binario
b = y.bin;
b1 = b(:,1:14);
%salvataggio su file
T = table(b1);
writetable(T,'input.txt')
%emulazione algoritmo
%tratto i fixed in binario come se fossero signed e ne calcolo il valore in
%decimale con segno
for i = 1:1:1000
    ri(i) = -bin2dec(b1(i,1))*2^(13);
    for j = 2:1:14
        ri(i) = ri(i) + bin2dec(b1(i,j))*2^(14-j);
    end
end
%calcolo l'energia
en = sum(ri.^2)
plot(ri)
