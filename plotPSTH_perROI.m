function plotPSTH_perROI(mean_PSTH_PerRunOverall,sem_PSTH_PerRunOverall,PSTH_label,colorValues,tpPre,tpPost,printDir,roiFile)

currentWindowSize = [121         473        1106         600];

figure;
set(gcf,'Position',currentWindowSize);


for i = 1:length(mean_PSTH_PerRunOverall)
h(i) = plot(1:length(mean_PSTH_PerRunOverall{i}),mean_PSTH_PerRunOverall{i},'color',colorValues{i}); hold on;
shadedErrorBar(1:length(mean_PSTH_PerRunOverall{i}),mean_PSTH_PerRunOverall{i},sem_PSTH_PerRunOverall{i},'lineprops',{'color',colorValues{i}},'transparent',1); hold on;
end

plot([1 tpPre+1+tpPost],[0 0],'color','k'); hold on;
plot([tpPre+1 tpPre+1],[ylim],'color','k'); hold on;
legend(h,PSTH_label{1},'location','best');
xlim([.5 41.5]);

xlabel('time (TR)');
ylabel('% signal change');
box off
set(gca,'linewidth',2);

set(gca,'XTick',[1:2:41]);
set(gca,'XTickLabel',{tpPre*-1:2:tpPost});

% set(gcf,'PaperPositionMode','Auto');
print(gcf,[printDir,roiFile(1:end-4),'_PSTH.eps'],'-depsc','-tiff')
delete(gcf);