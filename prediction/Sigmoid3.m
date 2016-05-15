function g = Sigmoid3( z )

g = zeros(size(z));

g = (2.0 ./ (1.0 + exp(-z))) - 1.0;

end

