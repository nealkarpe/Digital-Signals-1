recObj = audiorecorder(44100,24,1);
disp('Start speaking');
recordblocking(recObj,5);
disp('Recording complete');

play(recObj);

myRecording = getaudiodata(recObj);
audiowrite('myRecording.wav',myRecording,44100);