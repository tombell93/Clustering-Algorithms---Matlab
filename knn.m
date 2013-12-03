
function value = isneighbour(idx1, idx2, n)
    value = 0;
    for i=1:3,
        if(n(idx1, i+1) == idx2)
            value = idx2;
        end
    end
end