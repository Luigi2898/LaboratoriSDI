 wavesx = audioread('sx.wav');
 wavesxint = wavesx(:,1);
 wavesxint = interp(wavesxint, fs/44000);
 wavesxint = [t wavesxint];
 t1 = find(wavesxint(:,1) > 5.8,1,'first');
 t2 = find(wavesxint(:,1) > 8.89,1,'first');
 wavesxint_t_red = wavesxint((t1:t2),:);
 wavesxint_t_red(:,1) = wavesxint_t_red(:,1) - wavesxint_t_red(1,1);