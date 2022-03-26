clear;clc;

t=(0:0.05:1)';
data=sin(2*pi*t);

window_length=10; %窓長(偶数)
shift_length=window_length/2; %シフト長

[num_data,num_channel]=size(data);  %データの数,チャンネル数

%ピッタリサイズの行列の横幅の決定
% window_length + shift_length*(num_row-1) >= num_dataを満たす最小のnum_rowが正解
num_row=ceil((num_data-window_length)/shift_length)+1; %ceilは切り上げ

%格納予定行列
spectrogram=zeros(window_length,num_row);

%きれいに並べるためにデータの最後に都合のいい数だけ0を詰め込む
data=[data;zeros(1,num_data-(shift_length*(num_row-1)+1))'];

%データを行列に並べる
for i=1:num_row
    spectrogram(:,i)=data(shift_length*(i-1)+1:shift_length*(i-1)+window_length,1);
end

fprintf("データを並べただけのやつ")
spectrogram

%---------------------------------------------------------------------------

%行列の各ベクトルに窓関数をかける
spectrogram=spectrogram.*hann(window_length);

%各ベクトルにFFT
spectrogram=fft(spectrogram);

%各要素のパワー見せつける
spectrogram=abs(spectrogram).^2;

fprintf("でけたやつ")
spectrogram
