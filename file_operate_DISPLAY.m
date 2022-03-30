function call_STFT(filename,fuction_file_pass)

[data,Fs]=audioread(filename);   %Fsはサンプリングレート
[~,num_channel]=size(data);  %チャンネル数

%---------------グラフの編集---------------
f = figure();
f.Position(3:4) = [400*num_channel 400];
for i = 1:num_channel
    [x,y,z] = fuction_file_pass(data(:,i),Fs);
    subplot(1,num_channel,i);imagesc(x,y,z);
    txt = [num2str(filename),' チャンネル',num2str(i)];
    title(txt,'Interpreter','none');
    axis xy;
    xlabel("time[s]");
    ylabel("frequsency_gain[dB]",'Interpreter','none');
    ylim([0,Fs/2])
end
%----------------------------------------

end %end of call_STFT
