function g = Tanh( z )
g = zeros(size(z));
g = (exp(2.*z)-1)./(exp(2.*z)+1);

end

