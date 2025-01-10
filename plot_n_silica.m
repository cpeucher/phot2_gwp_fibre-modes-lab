% -------------------------------------------------------------------------
% Some calculations on refractive index of (doped) silica
%
% -------------------------------------------------------------------------

clear all
close all

file_name_core_figure = strrep(mfilename,'plot','fig');
do_print = 0;
do_add_figsize_to_filename = 1;
margin_figure = 0;

fig.interpreter = 'latex';

%%

% -------------------------------------------------------------------------
% Values extracted from data sheet
% -------------------------------------------------------------------------

% For SSMF (e.g. Corning SMF-28)

NA_ds = 0.14; 
% Numerical aperture at 1300 nm (data sheet value)
% Should not vary much around 1550 nm

a = 8.2e-6/2;
% Core radius, in m


n2_a = 1.444
% Assumed 

n1_a = sqrt(NA_ds^2 + n2_a^2)

% According to Eq. (6.80) in (Chartier, 2023)
cge = (n1_a/n2_a - 1)*10

% This is about 4.7%

V_1550_a = 2*pi*a*NA_ds/1550e-9
% Auuming the numerical aperture / does not change much from 1300 nm to
% 1550 nm



%%
% -------------------------------------------------------------------------
% Refractive index versus molar concentration of GeO2
% -------------------------------------------------------------------------

lambda = 1.55;

n2_1550 = n_silica(0,0,lambda)

xx = (0:0.1:5)/100;
% Molar concentration 

for ii = 1:length(xx)

    n_sellmeier(ii) = n_silica(xx(ii),0,lambda);

end

n_tcha = 1.444*(1 + xx/10);
% According to equation (6.80) in (Chartier, 2023)


fig_name = [file_name_core_figure '_n_vs_xge'];
hfig = figure('Name',fig_name);
plot(xx,n_sellmeier,'Color','b','LineStyle','-','Marker','none','LineWidth',1.5,'MarkerSize',12,'MarkerFaceColor','w','HandleVisibility','on')
hold on
plot(xx,n_tcha,'Color','r','LineStyle','-','Marker','none','LineWidth',1.5,'MarkerSize',12,'MarkerFaceColor','w','HandleVisibility','on')
xlabel('wavelength ($\mu$m) ','Interpreter',fig.interpreter)
ylabel('refractive index','Interpreter',fig.interpreter)
legend('Sellmeier','Eq. (6.80) in (Chartier, 2023)','Location','NorthEast','Box','off','Interpreter',fig.interpreter,'FontSize',18)
%title('','FontWeight','Normal','Interpreter',fig.interpreter)
ax = gca;
ax.TickLabelInterpreter = fig.interpreter;
ax.FontSize = 18;
ax.LineWidth = 1.5;
ax.TickLength = [0.01 0.025]*1.5;
ax.XMinorTick = 'on';
% xlim([0.2 2.6])
% ylim([-0.5 0.05])

xx = 3.6/100;
n_tcha_036 = 1.444*(1 + xx/10)
n_sell_036 = n_silica(xx,0,lambda)

xx = 4.7/100;
n_tcha_047 = 1.444*(1 + xx/10)
n_sell_047 = n_silica(xx,0,lambda)



%% 
% -------------------------------------------------------------------------
% Refractive index versus wavelength
% -------------------------------------------------------------------------

lambda = linspace(0.2,2.6,100);
% Wavelength range, in um

xge = cge;
% Mole concentration of germania in core

n2 = n_silica(0,0,lambda);
n1 = n_silica(xge,0,lambda); 

NA = sqrt(n1.^2 - n2.^2);
% Numerical aperture

fig_name = [file_name_core_figure '_n_vs_lambda'];
hfig = figure('Name',fig_name);
plot(lambda,n2,'Color','b','LineStyle','-','Marker','none','LineWidth',1.5,'MarkerSize',12,'MarkerFaceColor','w','HandleVisibility','on')
hold on
plot(lambda,n1,'Color','r','LineStyle','-','Marker','none','LineWidth',1.5,'MarkerSize',12,'MarkerFaceColor','w','HandleVisibility','on')
xlabel('wavelength ($\mu$m) ','Interpreter',fig.interpreter)
ylabel('refractive index','Interpreter',fig.interpreter)
legend('undoped','4.7\% GeO2','Location','NorthEast','Box','off','Interpreter',fig.interpreter,'FontSize',18)
% title('','FontWeight','Normal','Interpreter',fig.interpreter)
ax = gca;
ax.TickLabelInterpreter = fig.interpreter;
ax.FontSize = 18;
ax.LineWidth = 1.5;
ax.TickLength = [0.01 0.025]*1.5;
ax.XMinorTick = 'on';
xlim([0.2 2.6])
% ylim([-0.5 0.05])



fig_name = [file_name_core_figure '_on_vs_lambda'];
hfig = figure('Name',fig_name);
plot(lambda,NA,'Color','b','LineStyle','-','Marker','none','LineWidth',1.5,'MarkerSize',12,'MarkerFaceColor','w','HandleVisibility','on')
xlabel('wavelength ($\mu$m) ','Interpreter',fig.interpreter)
ylabel('numerical aperture','Interpreter',fig.interpreter)
% legend('undoped','3.6\% GeO2','Location','NorthEast','Box','off','Interpreter',fig.interpreter,'FontSize',18)
% title('','FontWeight','Normal','Interpreter',fig.interpreter)
ax = gca;
ax.TickLabelInterpreter = fig.interpreter;
ax.FontSize = 18;
ax.LineWidth = 1.5;
ax.TickLength = [0.01 0.025]*1.5;
ax.XMinorTick = 'on';
xlim([0.2 2.6])
% ylim([-0.5 0.05])

%%
% -------------------------------------------------------------------------
% Material dispersion
% -------------------------------------------------------------------------

c = 299792458;
% Speed of light in m/s

[lambda_d,D] = num_diff(2,lambda,n2);

D = -D.*lambda_d/c/1.0e-12;
% Dispersion in ps/nm/km

fig_name = [file_name_core_figure '_d_vs_lambda'];
hfig = figure('Name',fig_name);
plot(lambda_d,D,'Color','b','LineStyle','-','Marker','none','LineWidth',1.5,'MarkerSize',12,'MarkerFaceColor','w','HandleVisibility','on')
xlabel('wavelength ($\mu$m) ','Interpreter',fig.interpreter)
ylabel('material dispersion (ps/nm/km)','Interpreter',fig.interpreter)
% legend('undoped','3.6\% GeO2','Location','NorthEast','Box','off','Interpreter',fig.interpreter,'FontSize',18)
% title('','FontWeight','Normal','Interpreter',fig.interpreter)
ax = gca;
ax.TickLabelInterpreter = fig.interpreter;
ax.FontSize = 18;
ax.LineWidth = 1.5;
ax.TickLength = [0.01 0.025]*1.5;
ax.XMinorTick = 'on';
xlim([1.1 1.7])
% ylim([-0.5 0.05])


%%



n1_1550 = n_silica(3.6/100,0,1.55)


NA_1550 = sqrt(n1_1550^2 - n2_1550^2)
% Numerical aperture at 1550 nm

DD_1550 = (n1_1550^2 - n2_1550^2)/2/n1_1550^2
% Relative refractive index difference at 1550 nm

V_1550 = 2*pi*a*sqrt(n1_1550^2 - n2_1550^2)/1550e-9
% Normalised frequency at 1550 nm



lambda_c = 2*pi*a*NA_1550/2.405
% Cut-off wavelength of LP11 mode 
% We assume n1^2 - n2^2 do not change much from 1550 nm values (see graph
% of numerical aperture versus wavelength)


n1_1550_tcha = n2_1550*(1 + xge/10)
% Equation (6.80) in
% Thierry Chartier, Propagation guidée, ENSSAT, 2023-2024

DD_1550_tcha = (n1_1550_tcha^2 - n2_1550^2)/2/n1_1550_tcha^2
% Relative refractive index difference at 1550 nm

V_1550_tcha = 2*pi*a*sqrt(n1_1550_tcha^2 - n2_1550^2)/1550e-9
% Normalised frequency at 1550 nm

NA_1550_tcha = sqrt(n1_1550_tcha.^2 - n2_1550.^2)
% Numerical aperture

lambda_c_tcha = 2*pi*a*NA_1550_tcha/2.405
% Cut-off wavelength of LP11 mode 




if margin_figure
    hfig.Position(3:4) = [1 0.9]*hfig.Position(4);
end

if do_add_figsize_to_filename
    [figure_ratio_numerator,figure_ratio_denominator] = rat(hfig.Position(3)/hfig.Position(4));
    fig_name = [fig_name '_w' num2str(figure_ratio_numerator,'%u') 'h' num2str(figure_ratio_denominator,'%u')];
end

if do_print
    print(fig_name,'-dmeta');
    print(fig_name,'-djpeg');
    print(fig_name,'-dpdf');
    crop_command =['pdfcrop ' fig_name '.pdf ' fig_name '.pdf'];
    system(crop_command);
end


