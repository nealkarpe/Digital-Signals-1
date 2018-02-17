close all

[y,Fs] = audioread('myRecording.wav');
%original sample at 44.1kHz
sound(y,Fs);

pause(7);
%subsampled to 24kHz
y24 = my_resample(y,24000,44100);
sound(y24,24000);

pause(7);
%subsampled to 16kHz
y16 = my_resample(y,16000,44100);
sound(y16,16000);

pause(7);
%subsampled to 8kHz
y8 = my_resample(y,8000,44100);
sound(y8,8000);

pause(7);
%subsampled to 4kHz
y4 = my_resample(y,4000,44100);
sound(y4,4000);

pause(7);
[impulse_data,impulse_freq] = audioread('terrys_typing_omni.wav');
y_conv1 = conv(y,impulse_data);
sound(y_conv1,impulse_freq);

pause(7);
[impulse_data2,impulse_freq2] = audioread('stalbans_a_mono.wav');
y_conv2 = conv(y,impulse_data2);
sound(y_conv2,impulse_freq2);

pause(7);
[impulse_data3,impulse_freq3] = audioread('ir1.wav');
y_conv3 = conv(y,impulse_data3);
sound(y_conv3,impulse_freq3);

function ret = my_resample(data,A,B)
    length = size(data,1);
    step = B/A;
    ret = zeros(ceil(length/step),1);
    count = 0;
    for i = [1:step:length]
        index = ceil(i);
        count = count + 1;
        ret(count,1) = data(index,1);
    end
end
