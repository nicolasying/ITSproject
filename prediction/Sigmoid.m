function g = Sigmoid(z)

g = zeros(size(z));

g = 1.0 ./ (1.0 + exp(-z));

end

