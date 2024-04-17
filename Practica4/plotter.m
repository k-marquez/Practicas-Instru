function plotter(titlesFigures,rowFig,colFig,data,times,plotTitles,textLegend,xLabels,yLabels,isGraph)
    for i = 1 : length(titlesFigures)
        figure('Name',titlesFigures{i},'NumberTitle','off');
        if isGraph
            plotGraph(rowFig,colFig,data(i,:),times(i,:),plotTitles,textLegend,xLabels,yLabels)
        else
            plotDiag(rowFig,colFig,data,times,plotTitles,textLegend,xLabels,yLabels)
        end
    end
end

function plotGraph(rowFig,colFig,data,times,plotTitles,textLegend,xLabels,yLabels)
    for i = 1 : rowFig * colFig
        dimSubPlots = size(data{i});
        subData = data{i};
        subplot(rowFig, colFig, i)
        hold on;
        subTime = times{i}{1};
            for j = 1 : dimSubPlots(2)
                plot(subTime,subData{j});
            end  
        ylabel(yLabels{i},'interpreter', 'latex','FontSize',13);
        xlabel(xLabels{1},'interpreter', 'latex','FontSize',13);
        title(plotTitles{i})
        legend(textLegend,'FontSize',8);
        grid minor;
        hold off;
    end
end

function plotDiag(rowFig,colFig,data,times,plotTitles,textLegend,xLabels,yLabels)
    indexLabel = 1;
    for i = 1 : rowFig * colFig
        subplot(rowFig, colFig, i);
        dim = size(data{i});
        hold on;
        for j = 1 : dim(2)
            plot(times{i}{j},data{i}{j},'.')
        end
        if i > 3
            indexTitle = i - 3;
            indexLabel = 2;
        else
            indexTitle = i;
        end
        ylabel(xLabels{indexLabel},'interpreter', 'latex','FontSize',13);
        xlabel(yLabels{indexLabel},'interpreter', 'latex','FontSize',13);
        title(plotTitles{indexTitle})
        legend(textLegend,'FontSize',8);
        grid minor;
        hold off;
    end
end