clear;clc;

t=(0:0.02:1)';
data=sin(2*pi*t);

windw_length=10; %窓長

[num_data,num_channel]=size(data);  %データの数,チャンネル数

%ピッタリサイズの行列の横幅の決定
% N + N/2*(num_row-1) >= num_data を満たす最小のnum_rowが正解
num_row=ceil(2*(num_data-windw_length)/windw_length)+1; %ceilは切り上げ

%Xはスペクトラムを格納予定
spectrogram=zeros(windw_length,num_row);

%データを行列に並べる
for i=1:num_row-1
    for j=1:windw_length
        spectrogram(j,i)=data(windw_length/2*(i-1)+j,1);
    end
end

%最後の列だけ0が残るかもしれないので別ループで処理
i=1;
for j=windw_length/2*(num_row-1)+1:num_data
    spectrogram(i,num_row)=data(j,1);
    i=i+1;
end

spectrogram