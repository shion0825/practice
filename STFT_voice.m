clear;clc;

[get_data,Fs] = audioread("high_low_tone.wav");   %Fsはサンプリングレート
[num_data,num_channel] = size(get_data);  %データの数,チャンネル数

%表示時間
time = num_data/Fs;
%表示させる周波数(とりあえずナイキストの周波数まで)
display_frequency = Fs/2;

t = (0:1/Fs:time)';

window_length = 2^10; %窓長(偶数)
shift_length = window_length/2; %シフト長

%なんか2チャンネルあるが、とりあえず1本目をスペクトログラム
data = get_data(:,1);

%ピッタリサイズの行列の横幅の決定
% window_length + shift_length*(num_row-1) >= num_dataを満たす最小のnum_rowが正解
num_row = ceil((num_data-window_length)/shift_length)+1; %ceilは切り上げ

%きれいに並べるためにデータの最後に都合のいい数だけ0を詰め込む
data = [data;zeros(1,num_data-(shift_length*(num_row-1)+1))'];

%格納予定行列
power_spectrogram_matrix = zeros(window_length,num_row);

%窓関数かける、DFTする、パワー！、データを行列に並べる
for i = 1:num_row
    work_vector = data(shift_length*(i-1)+1:shift_length*(i-1)+window_length,1);
    work_vector = work_vector.*hann(window_length); %窓関数かける
    work_vector = 20*log10(abs(fft(work_vector)));  %パワー見せつける
    power_spectrogram_matrix(:,i) = work_vector;
end

x = linspace(1,time,num_row);
y = linspace(1,Fs,window_length);
imagesc(x,y,power_spectrogram_matrix);

%----------グラフの編集----------
axis xy;
xlabel("time");
ylabel("frequsency");
ylim([Fs/window_length,display_frequency])
%------------------------------