function g = SigmoidGradient2( z )
g = zeros(size(z));

g = 4 * Sigmoid(z) .* (1 - Sigmoid(z));

end

