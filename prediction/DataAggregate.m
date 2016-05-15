function y = DataAggregate( x0,x1,x2,x3 )
%数据聚合处理
for i=1:length(x0)
    y(i)=x0(i)+x1(i)+x2(i)+x3(i);
end
% y=y';
end

