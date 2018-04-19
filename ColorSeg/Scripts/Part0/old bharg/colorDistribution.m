function [colorSamples] = colorDistribution( input_args )
[red,green,yellow] = readmultifiles;

dred = 28;
dgreen = -40;
dyellow = 47;

redbouy = redexcludepoints(red,dred);
greenbouy = hsvexcludepoints(green,dgreen);
yellowbouy = yellowexcludepoints(yellow,dyellow);
allbouy = {redbouy,greenbouy,yellowbouy}; 

rr = redbouy(:,1);
gg = redbouy(:,2);
bb = redbouy(:,3);
fig1 = figure;
plot3(rr,gg,bb,'r.')
saveas(fig1,'../../Output/Part0/R_hist.jpg');  % here you save the figure

rr2 = yellowbouy(:,1);
gg2 = yellowbouy(:,2);
bb2 = yellowbouy(:,3);
fig2 = figure;
plot3(rr2,gg2,bb2,'y.')
saveas(fig2,'../../Output/Part0/Y_hist.jpg');  % here you save the figure

rr3 = greenbouy(:,1);
gg3 = greenbouy(:,2);
bb3 = greenbouy(:,3);
fig3 = figure;
p3 = plot3(rr3,gg3,bb3,'g.');
saveas(fig3,'../../Output/Part0/G_hist.jpg');  % here you save the figure

colorSamples = allbouy; %{redbouy, greenbouy, yellowbuoy};
end

