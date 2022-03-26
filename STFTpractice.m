clear;clc;

data=(1:23)'

N=4; %窓長

A=size(data);
num_data=A(1,1);  %データの数

%ピッタリサイズの行列の横幅の決定
% N + N/2*(num_row-1) >= num_data を満たす最小のnum_rowが正解
num_row=ceil(2*(num_data-N)/N)+1; %ceilは切り上げ

%Xはスペクトラムを格納予定
spectrum=zeros(N,num_row)

%データを行列に並べる
for i=1:num_row-1
    for j=1:N
        spectrum(j,i)=data(N/2*(i-1)+j,1);
    end
end

%最後の列だけ0が残るかもしれないので別ループで処理
i=1;
for j=N/2*(num_row-1)+1:num_data
    spectrum(i,num_row)=data(j,1);
    i=i+1;
end

spectrum