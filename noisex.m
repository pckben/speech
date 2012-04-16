% NOISEX
%
% Get noise sample from the NOISEX-92 database.
%
function s = noisex(noiseDir,id)
	s = wavread(fullfile(noiseDir,id,'.wav'));
end
