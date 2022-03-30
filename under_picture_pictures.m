function under_picture_pictures(filename)

[data,Fs]=audioread(filename);   %Fsはサンプリングレート
[~,num_channel]=size(data);  %チャンネル数

f = figure();
f.Position(3:4) = [400*num_channel 400];
for i=1:num_channel
    [x,y,z] = under_data_matrix(data(:,i),Fs);
    txt = [num2str(filename),'チャンネル',num2str(i)];
    subplot(1,num_channel,i);under_matrix_picture(txt,x,y,z);
end

end