% TIMITDIR
%
% set/get the readonly TIMIT directory
%
function s = timitdir(varargin)
	persistent timitLocation

	if isempty(timitLocation)
		if ~isempty(varargin)
			timitLocation = varargin{1};
		end
	end

	s = timitLocation;
end
