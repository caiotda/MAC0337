function ofelia.list(a);
;
    R = 44100
    F = a[1]
    D = a[2]
    M.duration = math.floor(D*R + 0.5)

    print(R, F)
    M.i = 0
    M.blocks = 0
    M.output = ofTable()
    M.L = math.floor(R/F)
    M.ks = ofTable()
    for j = 1, M.L do;
        M.ks[j] = 2*math.random() - 1;
    end;
    return M.ks
end;

function ofelia.perform();
    if M.blocks < M.duration then;
        print(M.i)
        for n=1, 64 do;
            -- Etapa de construção da saida. --
            M.output[n] = M.ks[M.i];
            -- Etapa de atualização da tabela. --
            --M.ant = ; -- Armazena o x[n] antes de aplicar o filtro da media
            --M.ks[M.i] = 0.5*(M.ks[M.i]) + M.ks[(M.i-2)%M.L + 1]);
            M.i = M.i%M.L + 1;
            M.blocks = M.blocks + 1
        end;
        return M.output
    end;
    return ofTable()
end;