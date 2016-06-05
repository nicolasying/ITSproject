function [ p, r, MAPE, RMSE ] = prediction_micro( fileold, filenew )

%read data
[~,~,x0a,x1a,x2a,x3a,~,~] = textread(fileold,'%s%s%d%d%d%d%d%s','headerlines',1);
for i=1:length(x0a)
    if mod(i,2)==1
        y0((i+1)/2)=x0a(i);
        y1((i+1)/2)=x1a(i);
        y2((i+1)/2)=x2a(i);
        y3((i+1)/2)=x3a(i);
    end
end

tmp=length(x0a)/2;

[~,~,x0b,x1b,x2b,x3b,~,~] = textread(filenew,'%s%s%d%d%d%d%d%s','headerlines',1);
for i=1:length(x0b)
    if mod(i,2)==1
        y0((i+1)/2+tmp)=x0b(i);
        y1((i+1)/2+tmp)=x1b(i);
        y2((i+1)/2+tmp)=x2b(i);
        y3((i+1)/2+tmp)=x3b(i);
    end
end

y=DataAggregate(y0,y1,y2,y3);

for i=1:3500
    x(i)=y(i);
end

tmax=max(x);
tmin=min(x);

for i=1:length(x)
    x(i)=(x(i)-tmin)/(tmax-tmin);
end

I=1; %????
H=30; %BLOCK ????
K=1; %????

trainX=zeros(1,3499);
trainY=zeros(1,3499);

learning_rate=0.001; %????????

for t = 1:size(trainX,2)
    trainX(1,t) = x(t);
end
for t = 1:size(trainX,2)
    trainY(1,t) = x(t+1);
end

[ w_il,w_hl,w_cl,w_if,w_hf,w_cf,w_ic,w_hc,w_iw,w_hw,w_cw,w_ck,tmp_b_tc,tmp_s_tc ] = LSTM_Train( trainX,trainY,learning_rate,I,H,K );

%??????????????????

for i=1:500
    te(i)=y(i+3499);
end

for i=1:length(te)
    te(i)=(te(i)-tmin)/(tmax-tmin);
end


test=zeros(1,499);
result=zeros(1,499);

for i = 1:size(test,2)
    test(1,i) = te(i);
    result(1,i) = te(i + 1);
end

[a_test_tl,b_test_tl,a_test_tf,b_test_tf,a_test_tc,s_test_tc,a_test_tw,b_test_tw,b_test_tc,a_test_tk,b_test_tk] = LSTM_Forecast( w_il,w_hl,w_cl,w_if,w_hf,w_cf,w_ic,w_hc,w_iw,w_hw,w_cw,w_ck,test,tmp_b_tc,tmp_s_tc);

p(1,:)=b_test_tk(1,1,:);
r(1,:)=result(1,:);
% ????????
p(1,:)=p(1,:).*(tmax-tmin)+tmin;
r(1,:)=r(1,:).*(tmax-tmin)+tmin;
% ????
plot(r,'color','blue');
hold;
plot(p,'color','red');

A=0;

for i=1:size(test,2)
    A=A+(abs(r(1,i)-p(1,i))/r(1,i));
end

MAPE=(A*100)/size(test,2);
C=0;
for n=1:size(test,2)
    C=C+(r(1,n) - p(1,n))^2;
end
RMSE=sqrt(C/size(test,2));

end

