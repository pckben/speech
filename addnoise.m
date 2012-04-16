% ADDNOISE
%
% Add noise n to signal x at the desired SNR.
% SNR = 10*log10(Px1/Pn);
function [y,x_gain] = addnoise(x,n,snr)
	Nx = length(x);
	Nn = length(n);
	%
	% use a random noise segment
	if Nn>Nx
		i = randi(Nn-Nx);
		n = n(i:i+Nx);
	end
	%
	% calculate signal and noise powers
	Px = mean(energy(x,160,160));
	Pn = mean(energy(n,160,160));
	%
	% expected signal power
	Px1 = Pn*(10^(snr/10));          
	%
	% estimated signal gain
	x_gain = sqrt(Px1/Px);
	%
	x1 = x.*x_gain;    
	y  = x1 + n;
end

