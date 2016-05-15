function y= uniformization( x,tmin,tmax)
%¹éÒ»»¯º¯Êý
for i=1:length(x)
    y(i)=(x(i)-tmin)/(tmax-tmin);
end

end

