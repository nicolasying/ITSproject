function g = Sigmoid2( z )

g = zeros(size(z));

g = (4.0 ./ (1.0 + exp(-z))) - 2.0;

end

