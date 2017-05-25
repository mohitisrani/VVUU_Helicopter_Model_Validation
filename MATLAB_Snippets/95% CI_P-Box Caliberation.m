clc;close all, clear all;
figure
subplot(2,2,[1 2])
%Cd values for helicopter 3 with 2 paper clips
CDs=[0.91308361,0.753552091,0.718910702,1.434742169,0.801008529,0.630518557,0.538005672,0.508798227,,0.874910158,0.789008571,0.779473812];
std_ =std(CDs);
mean_=mean(CDs);
Nsu_=1000; %total Cds to generate
post__=normrnd(mean_,std_,Nsu_,1); %posterior distribution
histfit(post__)
xlabel('x')
ylabel('f(x)')
title('Posterior distribution')
cddat=ones(11,1000) %matrix to store all the mu and sigma values;
 
%% P-box from the posterior of mean
 
figure(1)
subplot(2,2,3)
for i=1:Nsu_
    Ns=10 %each set will have Ns values of Cd
    cd=normrnd(post__(i),std_,Ns,1);% using the same std as exp.
    cdsort=sort(cd);
    [Fim,xim]=ecdf(cdsort);
    cddat(:,i)=xim';%add the xim cdf values as a column in cddat
    hold on, stairs(xim,Fim,'b');
end
% 95% CI for the p-box
for i=1:11
    temp=sort(cddat(i,:));
    cilow(i)=temp(26)
    cihigh(i)=temp(974);
end
 
%cilow=cddat(:,[26])'; %lower bound, pick the 26th column
 
%cihigh=cddat(:,[974])';%upper bound, pick the 974th column
 
 
 
%% Plot the experimental CDF
yobs=CDs;
ysort=sort(yobs);
[Fi,xi]=ecdf(ysort);%get the analytical CDF
hold on, stairs(xi,Fi,'r');
xlabel('C_D value');
ylabel('CDF value');
title('Pbox');
 
%% Plot the 95% confidence interval CDF
 
subplot(2,2,4)
[Fi,xi] = ecdf(ysort);
hold on, stairs(xi,Fi,'r');
[rx,ry]=stairs(xi,Fi);
hold on, stairs(cilow,Fim,'g');
[glx,gly]=stairs(cilow,Fim);
hold on, stairs(cihigh,Fim,'g');
[ghx,ghy]=stairs(cihigh,Fim);
xlabel('C_D value');
ylabel('CDF value');
title('P-box with 95% CI');
 
 
%% Area metric
 
cdrange=linspace(min(rx),max(rx),100);
 
% >> [x, index] = unique(x); 
% >> yi = interp1(x, y(index), xi); 
 
[glx,index]=unique(glx);
cil = interp1(glx,gly(index),cdrange);
[ghx,index]=unique(ghx);
ciu = interp1(ghx,ghy(index),cdrange);
[rx,index]=unique(rx);
r_exp= interp1(rx,ry(index),cdrange);
sum=0;
for i=1:100
    if r_exp(i)>cil(i)
        sum=sum+r_exp(i)-cil(i);
    end
    if r_exp(i)<ciu(i)
        sum=sum+ciu(i)-r_exp(i);
    end
end
sum=sum/100
