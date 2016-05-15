function [ y ] = Dataread(  )
%读入数据
[times,space1,x0a,x1a,x2a,x3a,x4a,x5a] = textread('58_717697_20151102_20151108_flow.dat','%s%s%d%d%d%d%d%s','headerlines',1);
for i=1:length(x0a)
    if mod(i,2)==1
        y0((i+1)/2)=x0a(i);
        y1((i+1)/2)=x1a(i);
        y2((i+1)/2)=x2a(i);
        y3((i+1)/2)=x3a(i);
    end
end
tmp=length(x0a)/2;
[times,space1,x0b,x1b,x2b,x3b,x4b,x5b] = textread('58_717697_20151109_20151115_flow.dat','%s%s%d%d%d%d%d%s','headerlines',1);
for i=1:length(x0b)
    if mod(i,2)==1
        y0((i+1)/2+tmp)=x0b(i);
        y1((i+1)/2+tmp)=x1b(i);
        y2((i+1)/2+tmp)=x2b(i);
        y3((i+1)/2+tmp)=x3b(i);
    end
end

%数据聚合处理，四个车道相加
y=DataAggregate(y0,y1,y2,y3);


end

