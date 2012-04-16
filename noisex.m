% NOISEX
%
% Get noise sample from the NOISEX-92 database.
%
function s = noisex(id)
	s = wavread(fullfile(noisexdir,[id,'.wav']));
end
