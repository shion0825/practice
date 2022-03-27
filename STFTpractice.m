clear;

t=(0:0.05:1)';
data=sin(2*pi*t);

window_length=10; %窓長(偶数)
shift_length=window_length/2; %シフト長

[num_data,num_channel]=size(data);  %データの数,チャンネル数

%ピッタリサイズの行列の横幅の決定
% window_length + shift_length*(num_row-1) >= num_dataを満たす最小のnum_rowが正解
num_row=ceil((num_data-window_length)/shift_length)+1; %ceilは切り上げ

%きれいに並べるためにデータの最後に都合のいい数だけ0を詰め込む
data=[data;zeros(1,num_data-(shift_length*(num_row-1)+1))'];

%格納予定行列
spectrogram=zeros(window_length,num_row);

%窓関数かける、DFTする、パワー！、データを行列に並べる
%一行でもいいが、速さを気にしていないので分けてもええやろと思った
for i=1:num_row
    work_vector=data(shift_length*(i-1)+1:shift_length*(i-1)+window_length,1);
    work_vector=work_vector.*hann(window_length);   %窓関数かける
    work_vector=fft(work_vector);                   %fftする
    work_vector=20*log10(abs(work_vector));         %パワーとる
    spectrogram(:,i)=work_vector;                   %行列に並べる
end

fprintf("完成スペクトログラム")
spectrogram
