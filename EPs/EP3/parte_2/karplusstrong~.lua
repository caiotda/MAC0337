--Nome: Caio Túlio de Deus Andrade
--NUSP: 9797232


function ofelia.list(a);
;
    --Taxa de amostragem do PD
    R = 44100
    -- Frequencia central em hz
    F = a[1]
    -- Duração da nota, em segundos
    D = a[2]

    M.duration = math.floor(D*R + 0.5)
    -- Variavel utilizada para iterarmos pela tabela ks
    M.i = 1

    -- Numero de blocos processados
    M.blocks = 0
    M.output = ofTable()

    -- Tamanho da tabela ks
    M.L = math.floor(R/F)
    M.ks = ofTable()

    -- Fator de decaimentos das ultimas dez notas. Sera decrescido num fator de
    -- 0.1
    M.alpha = 1

    -- Inicialização da tabela ks com valores aleatórios
    for j = 1, M.L do;
        M.ks[j] = 2*math.random() - 1;
    end;

    M.ant = M.ks[(-1)%M.L + 1]
    return M.ks
end;

function ofelia.perform();
    if M.blocks < M.duration then;
        for n=1, 64 do;
            if M.blocks > M.duration - 10 then;
                M.alpha = math.max(0, M.alpha - 0.1)
            end;
            -- Etapa de construção da saida. --
            M.output[n] = M.ks[M.i];
            -- Armazena o próximo valor que M.ant receberá
            aux = M.ks[M.i]
            -- Etapa de atualização da tabela. --
            M.ks[M.i] =  M.alpha*(M.ks[M.i] + M.ant)/2;
            M.ant = aux
            M.i = M.i%M.L + 1;
            M.blocks = M.blocks + 1
        end;
        return M.output
    end;
    return ofTable()
end;