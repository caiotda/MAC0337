function ofelia.list(a);
;
    R = 44100
    F = a[1]
    D = a[2]

    len = math.floor(D * R + 0.5)
    print(R, F)
    M.L = math.floor(R/F)
    M.ks = ofTable()
    for i = 1, M.L do;
        M.ks[i] = 2*math.random() - 1;
    end;
    return M.ks
end;

function ofelia.perform();
    print(M.ks)
end;