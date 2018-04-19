function [ gaussian ] = gaussianKernel( size, sigma )
%Creates a gaussian kernel with the given size and sigma
if nargin < 2
   sigma = 0.5;
end

gaussian = zeros(size);
center = (size+1)/2;

for (i = 1: size)
    for (j = 1: size)
        gaussian(i,j) = exp(-((i-center)*(i-center)+(j-center)*(j-center))/(2*sigma*sigma));
    end
end

gaussian = gaussian/sum(sum(gaussian));

end

