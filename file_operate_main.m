clear;clc;

%call_STFT("sample_high_tone.wav")       %自分の声(高音のつもり)
%call_STFT("sample_low_tone.wav")        %自分の声(低音)
%call_STFT("sample_high_low_tone.wav")   %自分の声(高低差あり)
%call_STFT("sample_doremi.mp3")
%call_STFT("sample_drum1.wav")
%call_STFT("sample_fue1.wav")
%call_STFT("sample_sample_gone.wav")
%call_STFT("sample_suzu1.wav")
%call_STFT("sample_triangle.wav")

file_operate_DISPLAY("sample_fue1.wav",@file_operate_STFT);