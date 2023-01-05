
function y = scalaire(a,b)
if (length(a)==3) & (length(b) == 3)
    y=a(1)*b(1)+a(2)*b(2)+a(3)*b(3) ;
else
    y=[] ;
    'error'
end


t=0:0.1:100;
y=1-exp(-t/20);
figure(1)
plot(t,y)
xlabel('Time(a)');
ylabel('Output(V)');
axis([-10 100 0 1.5])
title('First order system')
subplot(2,1,2)
y2=100*exp(-(t-50).*(t-50)/(2*100));
plot(t,y2)
xlabel('angle(deg)');
ylabel('Output(%)');
title('Gaussian function')

