function g = SigmoidGradient( z )

g = zeros(size(z));

g = Sigmoid(z) .* (1 - Sigmoid(z));


end

