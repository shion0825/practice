function picture = under_matrix_picture(graph_title,x,y,z)

%---------------グラフの編集---------------
imagesc(x,y,z);
title(graph_title,'Interpreter','none');
axis xy;
xlabel("time[s]");
ylabel("frequsency_gain[dB]",'Interpreter','none');
ylim([0,max(y)/2])
%----------------------------------------

end %end of call_STFT