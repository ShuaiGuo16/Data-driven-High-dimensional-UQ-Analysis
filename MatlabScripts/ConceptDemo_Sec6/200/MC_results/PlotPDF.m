clear
clc

a = load ('f_MC_GR_200.mat');
b = load ('f_ROM_500.mat');
c = load ('f_ROM_1400.mat');

pts = -20:0.1:20;
[f_Pre,xi_Pre] = ksdensity(a.f_MC_GR(:,3),pts);
plot(xi_Pre,f_Pre,'k-','LineWidth',2)
hold on

[f_Pre,xi_Pre] = ksdensity(b.f_ROM,pts);
plot(xi_Pre,f_Pre,'b-','LineWidth',2)

[f_Pre,xi_Pre] = ksdensity(c.f_ROM,pts);
plot(xi_Pre,f_Pre,'r-','LineWidth',2)

h = gca;
h.FontSize = 14;
h.XLim = [-20 20]
h.YLim = [0 0.18]
xlabel('Growth Rate (rad/s)')
ylabel('PDF')
xticks(-20:10:20)
yticks(0:0.03:0.18)

plot([0 0], [0 0.18],'k--','LineWidth',2)