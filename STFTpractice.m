clear;clc;

data=(1:23)'

N=4; %窓長

A=size(data);
num=A(1,1);  %データの数

%ピッタリサイズの行列の横幅の決定
% N + N/2*(yoko-1) >= num を満たす最小のyokoが正解
yoko=ceil(2*(num-N)/N)+1; %ceilは切り上げ

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

X