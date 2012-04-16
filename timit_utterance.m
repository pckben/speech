% TIMIT_UTTERANCE
%
% Read a speech utterance from TIMIT database and extract
% its original scale speech signal, plus the reference label
%
function [s,ref] = timit_utterance(timitDir,id,P)

	if nargin < 3,
		P = { 'iy';'ih';'eh';'ey';'ae';'aa';'aw';'ay';'ah';'ao';...
			'oy';'ow';'uh';'uw';'ux';'er';'ax';'ix';'axr';'ax-h';... % vowels
			'b';'d';'g';'p';'t';'k';'dx';'q';...      % stops
			'jh';'ch';...                             % affricatives
			'bcl';'dcl';'gcl';'pcl';'tck';'kcl';'tcl';...   % stop closures
			's';'sh';'z';'zh';'f';'th';'v';'dh';...   % fricatives
			'm';'n';'ng';'em';'en';'eng';'nx';...     % nasals
			'l';'r';'w';'y';'hh';'hv';'el';...        % semivowels and glides
			};          
	end

	% read TIMIT file in voicebox directory
	% and extract phoneme transcription
	[x,Fs,Phn,Ffx] = readsph(fullfile(timitDir,id),'dt');
	%
	% scaling x back to the original signal value s
	xmin = min(x);
	xmax = max(x);
	smin = Ffx{2}{7,2};
	smax = Ffx{2}{8,2};
	s = (x-xmin)/(xmax-xmin) * (smax-smin) + smin;

	ref = zeros(size(s));
	N = size(Phn);
	for i=1:N
		if any(strcmp(P,Phn{i,2}))
			range = Fs*Phn{i,1};
			ref(range(1):range(2)) = 1;
		end
	end
end
