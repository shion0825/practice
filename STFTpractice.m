clear;clc;

t=(0:0.02:1)';
data=sin(2*pi*t);

window_length=10; %窓長(偶数)
shift_length=window_length/2; %シフト長

[num_data,num_channel]=size(data);  %データの数,チャンネル数

%ピッタリサイズの行列の横幅の決定
% window_length + shift_length*(num_row-1) >= num_dataを満たす最小のnum_rowが正解
num_row=ceil((num_data-window_length)/shift_length)+1; %ceilは切り上げ

%Xはスペクトラムを格納予定
spectrogram=zeros(window_length,num_row);

%データを行列に並べる
for i=1:num_row-1
    for j=1:window_length
        spectrogram(j,i)=data(window_length/2*(i-1)+j,1);
    end
end

%最後の列だけ0が残るかもしれないので別ループで処理
i=1;
for j=window_length/2*(num_row-1)+1:num_data
    spectrogram(i,num_row)=data(j,1);
    i=i+1;
end

%行列の各ベクトルに窓関数をかける
spectrogram=spectrogram.*hann(window_length);

%各ベクトルにFFT
spectrogram=fft(spectrogram);

%各要素のパワー見せつける
spectrogram=abs(spectrogram).^2;

spectrogram
