clear;clc;

info=audioinfo("voice.wav")
[data,Fs]=audioread("voice.wav");%Fsはサンプリングレート

window_length=10; %窓長(偶数)
shift_length=window_length/2; %シフト長

[num_data,num_channel]=size(data);  %データの数,チャンネル数

channel=0; %チャンネルの指定をする変数
