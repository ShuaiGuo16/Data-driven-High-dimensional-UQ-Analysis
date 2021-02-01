clear
clc

model200 = load('model_Luis_30kW_9.5%_4_21_200ms.mat');
model250 = load('model_Luis_30kW_9.5%_4_21_250ms.mat');
model350 = load('model_Luis_30kW_9.5%_4_21_350ms.mat');

variance200 = sqrt(diag(getcov(model200.model)));
variance250 = sqrt(diag(getcov(model250.model)));
variance350 = sqrt(diag(getcov(model350.model)));

figure(1)
plot(variance200,'-ok')
hold on

plot(variance250,'-^k')
plot(variance350,'-sk')
hold off