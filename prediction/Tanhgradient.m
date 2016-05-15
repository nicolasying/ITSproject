function g = Tanhgradient( z )
g = zeros(size(z));
g = 1-Tanh(z).*Tanh(z);

end


