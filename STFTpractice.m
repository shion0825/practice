clear;clc;

%サンプリング周波数
Fs=44100;
%表示時間
time=1;

t=(0:1/Fs:time)';
data=100*sin(2*pi*1000*t)+1*sin(4*pi*1000*t);

window_length=2^10; %窓長(偶数)
shift_length=window_length/2; %シフト長

[num_data,num_channel]=size(data);  %データの数,チャンネル数

%ピッタリサイズの行列の横幅の決定
% window_length + shift_length*(num_row-1) >= num_dataを満たす最小のnum_rowが正解
num_row=ceil((num_data-window_length)/shift_length)+1; %ceilは切り上げ

%きれいに並べるためにデータの最後に都合のいい数だけ0を詰め込む
data=[data;zeros(1,num_data-(shift_length*(num_row-1)+1))'];

%格納予定行列
complex_matrix=zeros(window_length,num_row);
amplitude_matrix=zeros(window_length,num_row);
power_spectrogram_matrix=zeros(window_length,num_row);

%窓関数かける、DFTする、パワー！、データを行列に並べる
%一行でもいいが、速さを気にしていないので分けてもええやろと思った
for i=1:num_row
    work_vector=data(shift_length*(i-1)+1:shift_length*(i-1)+window_length,1);
    work_vector=work_vector.*hann(window_length);   %窓関数かける
    work_vector=fft(work_vector);                   %fftする
    complex_matrix(:,i)=work_vector;
    work_vector=abs(work_vector);                   %大きさみる
    amplitude_matrix=work_vector;
    work_vector=20*log10(work_vector);              %パワーとる
    power_spectrogram_matrix(:,i)=work_vector;
end

fprintf("完成パワースペクトログラム")
x=1:num_row;
y=1:window_length;
z=power_spectrogram_matrix(y,x);

x=x*time/num_row;
y=y*Fs/window_length;

imagesc(x,y,z)
xlabel("time");
ylabel("frequsency");

%-----------------------ここから逆変換--------------------------------
rebuild_matrix=zeros(window_length,num_row);

for i=1:num_row
    work_vector=complex_matrix(:,i);
    work_vector=ifft(work_vector);
    rebuild_matrix=work_vector;
end
