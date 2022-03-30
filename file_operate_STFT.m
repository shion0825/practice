% 関数には一本のベクトル、サンプリング周波数をねじ込む。画像を表示する関数
function [time_vector,frequent_vector,spectrogram_matrix]=STFT_function(data,SamplingRate)

%--------------製作者の設定---------------
window_length=2^10;                 %窓長(偶数)
shift_length=window_length/2;       %シフト長
%----------------------------------------

num_data=length(data);  %データの数
time = num_data/SamplingRate;     %データの長さ[s]

%ピッタリサイズの行列の横幅の決定
% window_length + shift_length*(num_row-1) >= num_dataを満たす最小のnum_rowが正解
num_row=ceil((num_data-window_length)/shift_length)+1; %ceilは切り上げ

%きれいに並べるためにデータの最後に都合のいい数だけ0を詰め込む
data=[data;zeros(1,num_data-(shift_length*(num_row-1)+1))'];

%格納予定行列
power_spectrogram_matrix = zeros(window_length,num_row);

%窓関数かける、DFTする、パワー！、データを行列に並べる
for i = 1:num_row
    work_vector = data(shift_length*(i-1)+1:shift_length*(i-1)+window_length,1);
    work_vector = work_vector.*hann(window_length); %窓関数かける
    work_vector = 20*log10(abs(fft(work_vector)));  %パワー見せつける
    power_spectrogram_matrix(:,i) = work_vector;    %行列に並べる
end

time_vector = linspace(0,time,num_row);
frequent_vector = linspace(0,SamplingRate,window_length);
spectrogram_matrix = power_spectrogram_matrix;

end %end of STFT_function