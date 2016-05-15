function g =  SigmoidGradient3( z )
g = zeros(size(z));

g = 2 * Sigmoid(z) .* (1 - Sigmoid(z));


end

