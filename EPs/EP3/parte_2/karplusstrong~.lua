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
    -- Duração, em blocos, do ataque.
    ataque = a[3]
    print(ataque)

    M.duration = math.floor(D*R + 0.5)
    -- Variavel utilizada para iterarmos pela tabela ks
    M.i = 1

    g_0 = math.cos(math.pi * F/R)
    g_1 = 10^(-3/(F * D))
    if g_0 >= g_1 then;
        M.ro = g_1/g_0
        M.s = 0.5
    else
        M.ro = 1
        cos_arg = 2 * math.cos(2 * math.pi * F/R)
        A =  2 - cos_arg
        B = cos_arg - 2
        C = (1 - g_1)^2

        delta = B^2 - 4 * a * c
        x1 = -B + math.sqrt(delta)/ 2 * A
        x2 = -B - math.sqrt(delta)/ 2 * A
        if x1 >= 0 and x1 <= 0.5 then
            m.s = x1
        end

        if x2 >= 0 and x2 <= 0.5 then
            m.s = x2
        end
    end;

    -- Numero de blocos processados
    M.blocks = 0
    M.output = ofTable()

    -- Tamanho da tabela ks
    M.L = math.floor(R/F)
    if ataque == nil then
        ataque = 0
    end
    count = M.L * ataque
    M.ks = ofTable()

    -- Fator de decaimentos das ultimas dez notas. Sera decrescido num fator de
    -- 0.1
    M.alpha = 1

    -- Inicialização da tabela ks com valores aleatórios
    for j = 1, M.L do;
        M.ks[j] = 2*math.random() - 1;
    end;

    M.ant = M.ks[(-1)%M.L + 1]
    ant = M.ant
    i = 1
    for j=1, count do;
        -- Armazena o próximo valor que M.ant receberá
        aux = M.ks[i]
        -- Etapa de atualização da tabela. --
        M.ks[i] =  (M.ks[i] + ant)/2;
        ant = aux
        i = i%M.L + 1
    end
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
            M.ks[M.i] =  M.ro * M.alpha * ((1 - M.s) * M.ks[M.i] + M.s * M.ant);
            M.ant = aux
            M.i = M.i%M.L + 1;
            M.blocks = M.blocks + 1
        end;
        return M.output
    end;
    return ofTable()
end;