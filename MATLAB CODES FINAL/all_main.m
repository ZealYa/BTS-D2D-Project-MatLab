clc
close all
clear all
tic;
drops_numb=500;
Area = 700:100:1000; % area size
sim_time = 50;
Total_energy_LEACH_random_a=zeros(drops_numb,length(Area));
Total_energy_Direct_a=zeros(drops_numb,length(Area));
Total_energy_pegasis_a=zeros(drops_numb,length(Area));
Total_energy_dream_a=zeros(drops_numb,length(Area));

Total_energy_LEACH_random_b = zeros(drops_numb,sim_time+1);
Total_energy_Direct_b = zeros(drops_numb,sim_time+1);
Total_energy_pegasis_b = zeros(drops_numb,sim_time+1);
Total_energy_dream_b = zeros(drops_numb,sim_time+1);

Efficiency_DIRECT_a = zeros(drops_numb,length(Area));
Efficiency_PEGASIS_a = zeros(drops_numb,length(Area));
Efficiency_LEACH_a = zeros(drops_numb,length(Area));
Efficiency_DREAM_a = zeros(drops_numb,length(Area));

for i=1:drops_numb
    disp(i);
    [Total_energy_LEACH_random_b(i,:), Total_energy_Direct_b(i,:), Total_energy_pegasis_b(i,:), Total_energy_dream_b(i,:), Efficiency_DIRECT_a(i,:), Efficiency_PEGASIS_a(i,:), Efficiency_LEACH_a(i,:), Efficiency_DREAM_a(i,:),Total_energy_LEACH_random_a(i,:),Total_energy_Direct_a(i,:),Total_energy_pegasis_a(i,:),Total_energy_dream_a(i,:),clustersss]=main_over_drops_final(Area,sim_time);
end

 y1=mean(Total_energy_LEACH_random_a);
 y2=mean(Total_energy_Direct_a);
 y3=mean(Total_energy_pegasis_a);
 y4=mean(Total_energy_dream_a);
 
 x1=mean(Efficiency_LEACH_a)/1e6;
 x2=mean(Efficiency_DIRECT_a)/1e6;
 x3=mean(Efficiency_PEGASIS_a)/1e6;
 x4=mean(Efficiency_DREAM_a)/1e6;
 
 for i = 1:drops_numb
     Total_energy_LEACH_random_b(i,:) = cumsum(Total_energy_LEACH_random_b(i,:));
     Total_energy_Direct_b(i,:) = cumsum(Total_energy_Direct_b(i,:));
     Total_energy_pegasis_b(i,:) = cumsum(Total_energy_pegasis_b(i,:));
     Total_energy_dream_b(i,:) = cumsum(Total_energy_dream_b(i,:));
 end
 
 z1=mean(Total_energy_LEACH_random_b);
 z2=mean(Total_energy_Direct_b);
 z3=mean(Total_energy_pegasis_b);
 z4=mean(Total_energy_dream_b);
 
figure
colour_darkblue = [1 17 181] ./ 255;
p1=plot (Area, y2,'Color', colour_darkblue);
set(p1,'Marker','x');
set(p1,'LineStyle','-');
hold on
% plot (Area, Total_energy_LEACH_random_PC_a)
% plot (Area, Total_energy_LEACH_kmeans_a)
% plot (Area, Total_energy_LEACH_kmeans_PC_a)

darkred=[178 34 4] ./ 255;
p2=plot (Area, y1,'Color', darkred);
set(p2,'Marker','o');
set(p2,'LineStyle','-');

colour_green = [1 181 17] ./ 255;
p3=plot (Area, y3,'Color', colour_green);
set(p3,'Marker','x');
set(p3,'LineStyle','-');


fuchsia=[250 0 250] ./ 255;
p4=plot (Area, y4,'Color', fuchsia);
set(p4,'Marker','o');
set(p4,'LineStyle','-');
% plot (Area, Total_energy_Direct_PC_a)
% axis([0 Area(length(Area))+500 0 Inf])
limyd=min(min(min(y1(1),y2(1)),y3(1)),y4(1));
limyu=max([max(y1) max(y2) max(y3) max(y4)]);
xlim([Area(1) Area(end)]);
ylim([limyd limyu]);

%xticks(Area);
grid on
% legend('LEACH random','LEACH random - PC','LEACH k-means++','LEACH k-means++ - PC','Direct full power','Direct power control')

% title ('Total energy consumption for different protocols')
set(p1,'LineWidth',1.5);
set(p2,'LineWidth',1.5);
set(p3,'LineWidth',1.5);
set(p4,'LineWidth',1.5);
toc



h_legend=legend ('Direct Communication','LEACH','PEGASIS','DREAM');
set(h_legend,'FontSize',12,'Location','northwest');
title('Energy Consumption, with mobility','FontSize',25);
ylabel('Energy Consumption [J] ','FontSize',17);
xlabel('Dimension of Area [m]', 'FontSize', 17);grid on;

 set(gca,'FontWeight','normal',...
    'FontSize',12);

figure(2)
colour_darkblue = [1 17 181] ./ 255;
p1=plot (Area, x2,'Color', colour_darkblue);
set(p1,'Marker','x');
set(p1,'LineStyle','-');
hold on
% plot (Area, Total_energy_LEACH_random_PC_a)
% plot (Area, Total_energy_LEACH_kmeans_a)
% plot (Area, Total_energy_LEACH_kmeans_PC_a)

darkred=[178 34 4] ./ 255;
p2=plot (Area, x1,'Color', darkred);
set(p2,'Marker','o');
set(p2,'LineStyle','-');


colour_green = [1 181 17] ./ 255;
p3=plot (Area, x3,'Color', colour_green);
set(p3,'Marker','x');
set(p3,'LineStyle','-');


fuchsia=[250 0 250] ./ 255;
p4=plot (Area, x4,'Color', fuchsia);
set(p4,'Marker','o');
set(p4,'LineStyle','-');
% plot (Area, Total_energy_Direct_PC_a)
% axis([0 Area(length(Area))+500 0 Inf])
set(p1,'LineWidth',1.5);
set(p2,'LineWidth',1.5);
set(p3,'LineWidth',1.5);
set(p4,'LineWidth',1.5);



h_legend=legend ('Direct Communication','LEACH','PEGASIS','DREAM');
set(h_legend,'FontSize',12,'Location','northwest');
title('Energy efficiency, one source','FontSize',25);
ylabel('Efficiency [Mb/J] ','FontSize',17);
xlabel('Dimension of Area [m]', 'FontSize', 17);grid on;

 set(gca,'FontWeight','normal',...
    'FontSize',12);

t = 0:1:sim_time;

figure(3)
colour_darkblue = [1 17 181] ./ 255;
p1=plot (t, z2,'Color', colour_darkblue);
set(p1,'LineStyle','-');
plot(t(1:10:end),z2(1:10:end), 'x')
% set(p1,'Marker','x');
hold on
% plot (Area, Total_energy_LEACH_random_PC_a)
% plot (Area, Total_energy_LEACH_kmeans_a)
% plot (Area, Total_energy_LEACH_kmeans_PC_a)

darkred=[178 34 4] ./ 255;
p2=plot (t, z1,'Color', darkred);
set(p2,'LineStyle','-');
plot(t(1:10:end),z1(1:10:end), 'o')
% set(p2,'Marker','o');


colour_green = [1 181 17] ./ 255;
p3=plot (t, z3,'Color', colour_green);
set(p3,'LineStyle','-');
plot(t(1:10:end),z3(1:10:end), 'x')
% set(p3,'Marker','x');


fuchsia=[250 0 250] ./ 255;
p4=plot (t, z4,'Color', fuchsia);
set(p4,'LineStyle','-');
plot(t(1:10:end),z4(1:10:end), 'o')
% set(p4,'Marker','o');
% plot (Area, Total_energy_Direct_PC_a)
% axis([0 Area(length(Area))+500 0 Inf])


%xticks(Area);
grid on
% legend('LEACH random','LEACH random - PC','LEACH k-means++','LEACH k-means++ - PC','Direct full power','Direct power control')

% title ('Total energy consumption for different protocols')
set(p1,'LineWidth',1.5);
set(p2,'LineWidth',1.5);
set(p3,'LineWidth',1.5);
set(p4,'LineWidth',1.5);
toc



h_legend=legend ('Direct Communication','LEACH','PEGASIS','DREAM');
set(h_legend,'FontSize',12,'Location','northwest');
title('Energy consumption in time','FontSize',25);
ylabel('Energy Consumption [J] ','FontSize',17);
xlabel('Time [s]', 'FontSize', 17);grid on;

 set(gca,'FontWeight','normal',...
    'FontSize',12);


SaveFigs = 1;
if SaveFigs == 1
    hgsave(sprintf('Leach'));
    saveas(gca,sprintf('Leach.png'));
    print -dtiff -r300 Leach;%HighResolution Fig
end 
ss=2;