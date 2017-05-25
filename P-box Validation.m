clc;close all, clear all;
 
 
H1P1=[1.147227231
1.025756737
1.147227231
1.08564254
1.162888855
1.100879442
1.100879442
1.040568917
1.162888855
1.131671788
];
k_=length(H1P1);
pd=fitdist(H1P1,'Normal')
 
% mu =   1.20351   [1.1419, 1.25284]
% sigma = 0.0734226   [0.0513016, 0.128852]
 
 
mu=linspace(1.074,1.146,30);
x_=length(mu);
sig=linspace(0.032,0.09,30);
y_=length(sig);
[X,Y]=meshgrid(mu,sig);
 
L=meshgrid(mu,sig);
%%For Non-informative Prior
for i=1:x_
    for j=1:y_
        L(i,j)=1;
    end
end
 
%Likelihood Function
for i=1:x_
    for j=1:y_
        for k_=1:k_
            L(i,j)=L(i,j)*normpdf(H1P1(k_),mu(i),sig(j));
        end
    end
end
 
subplot(3,2,[1 2])
contour(X,Y,L);
xlabel('mu C_D');
ylabel('sig C_D');
title('Contour Plot')
 
 
%% Generate a p-box from the joint posterior distribution
 
%helicopter 1 with 2 paper clips
Nsu=100;  %generate 100 CDF sets
% select mu from the joint distribution
mu1_1=mu
nmu=length(mu1_1);
 
%select std from the joint distribution
sd1_1 =sig
nsd=length(sd1_1)
 
%Initialize a 11*100 matrix of ones that will store all the xCdF values 
cddat = ones(11,900);
count=0;
 
 
%% P-box from the joint distribution
 
 
subplot(3,2,3)
for i=1:nmu
    for j=1:nsd
        count=count+1;
        Ns=10; %Each mu will have 10 CDs corresponding to different std
        cd=random('normal',mu1_1(i),sd1_1(j),Ns,1);
        cdsort=sort(cd); % sort them in ascending order to plot
        [Fim,xim]=ecdf(cdsort);
        cddat(:,count)=xim';%add the xim cdf values as a column in cddat
        hold on, stairs(xim,Fim,'b');
    end
end
% 95% CI for the p-box
for i=1:11
    temp=sort(cddat(i,:));
    cilow(i)=temp(24)
    cihigh(i)=temp(876);
end
 
%cilow=cddat(:,[26]); %lower bound, pick the 26th column
%cihigh=cddat(:,[974]);%upper bound, pick the 974th column
 
%% Plot the experimental CDF 1 calibration
yobs=H1P1;
ysort=sort(yobs);
[Fi,xi]=ecdf(ysort);%get the analytical CDF
hold on, stairs(xi,Fi,'r');
xlabel('C_D value');
ylabel('CDF value');
title('Pbox');
 
%% Plot the 95% confidence interval CDF
 
subplot(3,2,4)
[Fi,xi] = ecdf(ysort);
hold on, stairs(xi,Fi,'r');
[rx,ry]=stairs(xi,Fi);
hold on, stairs(cilow,Fim,'g');
[glx,gly]=stairs(cilow,Fim);
hold on, stairs(cihigh,Fim,'g');
[ghx,ghy]=stairs(cihigh,Fim);
xlabel('C_D value');
ylabel('CDF value');
title('P-box - Calibration - 3 Pins');
 
 
%% Area metric
 
cdrange=linspace(0,1,100);
 
% >> [x, index] = unique(x); 
% >> yi = interp1(x, y(index), xi); 
 
[gly,index]=unique(gly);
cil = interp1(gly,glx(index),cdrange);
[ghy,index]=unique(ghy);
ciu = interp1(ghy,ghx(index),cdrange);
[ry,index]=unique(ry);
r_exp= interp1(ry,rx(index),cdrange);
sum=0;
for i=1:100
    if r_exp(i)<cil(i)
        sum=sum-r_exp(i)+cil(i);
    end
    if r_exp(i)>ciu(i)
        sum=sum-ciu(i)+r_exp(i);
    end
end
sum=sum/100;
sum_c=sum;
 
 
%% Plot the experimental CDF 1 calibration  ---V1
yobs=[1.193593758
1.193593758
1.045064412
1.210705995
1.077218367
1.029170128
1.093478037
1.142987819
1.262773478
1.298094109
];
ysort=sort(yobs);
[Fi,xi]=ecdf(ysort);%get the analytical CDF
% hold on, stairs(xi,Fi,'r');
% xlabel('C_D value');
% ylabel('CDF value');
% title('Pbox');
 
%% Plot the 95% confidence interval CDF
 
subplot(3,2,5)
[Fi,xi] = ecdf(ysort);
hold on, stairs(xi,Fi,'r');
[rx,ry]=stairs(xi,Fi);
hold on, stairs(cilow,Fim,'g');
[glx,gly]=stairs(cilow,Fim);
hold on, stairs(cihigh,Fim,'g');
[ghx,ghy]=stairs(cihigh,Fim);
xlabel('C_D value');
ylabel('CDF value');
title('Validation - 4 pins');
 
 
%% Area metric
 
cdrange=linspace(0,1,100);
 
% >> [x, index] = unique(x); 
% >> yi = interp1(x, y(index), xi); 
 
[gly,index]=unique(gly);
cil = interp1(gly,glx(index),cdrange);
[ghy,index]=unique(ghy);
ciu = interp1(ghy,ghx(index),cdrange);
[ry,index]=unique(ry);
r_exp= interp1(ry,rx(index),cdrange);
sum=0;
for i=1:100
    if r_exp(i)<cil(i)
        sum=sum-r_exp(i)+cil(i);
    end
    if r_exp(i)>ciu(i)
        sum=sum-ciu(i)+r_exp(i);
    end
end
sum=sum/100;
sum_v_1=sum;
 
 
%% Plot the experimental CDF 1 calibration  ---V2
yobs=[1.161115016
1.252149182
1.039438407
1.289524718
1.270768245
1.215323285
1.252149182
1.289524718
1.12566322
1.233667529
];
ysort=sort(yobs);
[Fi,xi]=ecdf(ysort);%get the analytical CDF
% hold on, stairs(xi,Fi,'r');
% xlabel('C_D value');
% ylabel('CDF value');
% title('Pbox');
 
%% Plot the 95% confidence interval CDF
 
subplot(3,2,6)
[Fi,xi] = ecdf(ysort);
hold on, stairs(xi,Fi,'r');
[rx,ry]=stairs(xi,Fi);
hold on, stairs(cilow,Fim,'g');
[glx,gly]=stairs(cilow,Fim);
hold on, stairs(cihigh,Fim,'g');
[ghx,ghy]=stairs(cihigh,Fim);
xlabel('C_D value');
ylabel('CDF value');
title('Validation - 5 pins');
 
 
%% Area metric
 
cdrange=linspace(0,1,100);
 
% >> [x, index] = unique(x); 
% >> yi = interp1(x, y(index), xi); 
 
[gly,index]=unique(gly);
cil = interp1(gly,glx(index),cdrange);
[ghy,index]=unique(ghy);
ciu = interp1(ghy,ghx(index),cdrange);
[ry,index]=unique(ry);
r_exp= interp1(ry,rx(index),cdrange);
sum=0;
for i=1:100
    if r_exp(i)<cil(i)
        sum=sum-r_exp(i)+cil(i);
    end
    if r_exp(i)>ciu(i)
        sum=sum-ciu(i)+r_exp(i);
    end
end
sum=sum/100;
sum_v_2=sum;
 
  
sum_c
sum_v_1
sum_v_2
