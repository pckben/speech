% NOISEXDIR
%
% set/get the readonly NOISEX directory
%
function s = noisexdir(varargin)
	persistent noisexLocation

	if isempty(noisexLocation)
		if ~isempty(varargin)
			noisexLocation = varargin{1};
		end
	end

	s = noisexLocation;
end

