function e = energy(x,Nw,Nsh)

[n,m] = size(x);
if n==1 || m==1,
    if nargin<=3
        x = enframe(x,Nw,Nsh);
    else
        error('Missing params Nw, Nsh.');
    end
end

e = mean(x.^2,2);

end

