%% Matlab Fuction to calculate Likelihood


H1P1=[2.019847709,1.904070563,2.092793478,2.167033185,2.047050739,1.93933038,2.167033185,2.019847709,2.261652419,1.96598753]';
k_=length(H1P1);
pd=fitdist(H1P1,'Normal')
 
mu=1.5:0.1:3.2;
x_=length(mu);
sig=0.07:0.01:0.24;
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
            L(i,j)=L(i,j)*normpdf(Cd1(k_),mu(i),sig(j));
        end
    end
end
 
surf(X,Y,L)
%contour(X,Y,L)
xlabel('mu C_D');
ylabel('sig C_D');
