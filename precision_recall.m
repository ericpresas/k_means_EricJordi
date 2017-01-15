function [] = precision_recall( xlabels_pred, xlabels_orig)
    %Precission recall per a 2 classes
    scores = xlabels_pred;
    targets = xlabels_orig;
    figure
    [Xpr,Ypr,Tpr,AUCpr] = perfcurve(targets, scores, 1, 'xCrit', 'reca', 'yCrit', 'prec');
    plot(Xpr,Ypr)
    xlabel('Recall'); ylabel('Precision')
    title(['Precision-recall curve (AUC: ' num2str(AUCpr) ')'])

end

