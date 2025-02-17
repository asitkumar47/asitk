clear, clc, close all

tfWoDelay   = tf(1, [1 .5 1]);                 % 2nd order system with no delay
tfWithDelay = tf(1, [1 .5 1], 'ioDelay', 1);   % 2nd order system with 1s delay

[num, den]      = pade(1, 2);                  % pade(T, N) <- T = time delay, N <- order of PA
tfPa            = tf(num, den);
tfWithDelayPa   = tfWoDelay * tfPa;

figure(1); clf;
set(gcf, 'Position', [100 0 1200 500])
subplot(2, 2, [1, 3])
step(tfWoDelay); hold on, grid on
step(tfWithDelay, 'r--')
step(tfWithDelayPa, 'k--')
legend('without delay', 'with delay (e^{-st})', 'with delay (PA)')

subplot(2, 2, [2, 4])
bode(tfWoDelay); hold on
bode(tfWithDelay, 'r--')
options = bodeoptions;
options.PhaseMatching = 'on';
bodeplot(tfWithDelayPa, options), grid on

hline = findall(gcf, 'type', 'line');
set(hline, 'LineWidth', 1.5);
set(hline(8), 'linestyle', '--');
set(hline(8), 'color', 'k');

legend('without delay', 'with delay (e^{-st})', 'with delay (PA)', 'Location', 'southwest')
ylim([-360, 0])