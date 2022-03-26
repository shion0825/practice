%このプリグラムはdataを一次元だけいじる

clear;clc;

%info=audioinfo("10.wav")
[data,Fs]=audioread("test.wav"); %Fsはサンプリングレート

%data=[1,2,3,4,5,6,7,8,9,10,11].';

N=100; %窓長

A=size(data);
num=A(1,1);  %データの数
chan=A(1,2); %チャンネルの数(mp3はチャンネルが1~3ある?)


%ピッタリサイズの行列の横幅の決定
% N + N/2*(yoko-1) >= num を満たす最小のyokoが正解
yoko=ceil(2*(num-N)/N)+1; %ceilは切り上げ

%Xはスペクトラムを格納予定
X=zeros(N,yoko);

%データを行列に並べる
for i=1:yoko-1
    for j=1:N
        X(j,i)=data(N/2*(i-1)+j,1);
    end
end

%最後の列だけ0が残るかもしれないので別ループで処理
i=1;
for j=N/2*(yoko-1)+1:num
    X(i,yoko)=data(j,1);
    i=i+1;
end

%行列の各ベクトルに窓関数をかける
hann(N);
X=X.*hann(N);

%FFT
X=fft(X);

%各要素のパワー見せつける
X=abs(X);
X=X.^2;

X

