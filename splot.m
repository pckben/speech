classdef splot < handle
	properties
		figureHandle = []; % figure handle
		H = []; % handle vector
        S = []; % current subplot subset
		margin = .075;
		splitMode = 'horizontal';
	end

	methods
		function obj = splot
			clf;
		end

		function append(obj)
            % create the new axes
            obj.H(end+1) = axes;
            % add the subplot to the visible subset
            obj.S(end+1) = length(obj.H); 
            % redraw
			%obj.redraw;
			%axes(obj.H(end));
            title(sprintf('Plot %d',length(obj.H)));
			obj.figureHandle = gcf;
		end

		function select(obj,i)
			axes(obj.H(i));
		end

		% redraw the plot using subplot indices specified in S
		function redraw(obj)
			switch obj.splitMode
				case 'horizontal'
					obj.redrawHorizontal;
				case 'vertical'
					obj.redrawVertical;
				otherwise
					error 'unknown split mode';
			end
		end

		function redrawHorizontal(obj)
            N = length(obj.S);
			margin = obj.margin;
			x = margin;
			w = 1 - 2*margin;
			h = (1 - margin*(N+1)) / N;
            % hide all 
            for i=1:length(obj.H)
				if ~any(obj.S==i)
					set(obj.H(i),'Position',[-10 -10 0.01 0.01]);
				end
            end
            % show selected subset
			for i=1:length(obj.S)
				y = margin*(N-i+1) + h*(N-i);
				hi = obj.H(obj.S(i));
				set(hi,'Position',[x y w h]);
				%axes(hi);
				%axis tight;
			end
		end
		function redrawVertical(obj)
            N = length(obj.S);
			margin = obj.margin;
			y = margin;
			h = 1 - 2*margin;
			w = (1 - margin*(N+1)) / N;
            % hide all 
            for i=1:length(obj.H)
				if ~any(obj.S==i)
					set(obj.H(i),'Position',[-10 -10 0.01 0.01]);
				end
            end
            % show selected subset
			for i=1:length(obj.S)
				x = margin*(N-i+1) + w*(N-i);
				hi = obj.H(obj.S(i));
				set(hi,'Position',[x y w h]);
				%axes(hi);
				%axis tight;
			end
		end

		function xlim(obj,xl,S)
			if nargin<3, S = 1:length(obj.H); end
			for i=S
				obj.select(i);
				xlim(xl);
			end
        end
        
        function show(obj,S)
            obj.S = S;
            obj.redraw;
        end
        
        function reset(obj)
            obj.S = 1:length(obj.H);
            obj.redraw;
        end

		function maximize(obj)
			scr = get(0,'ScreenSize');
			set(obj.figureHandle,'Position',scr);
		end
	end
end
