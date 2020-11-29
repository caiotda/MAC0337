-- Aqui eu vou receber a lista de psis.
-- O problema é calcular o b. Eu teria que gerar dinamicamente uma lista de botimos
-- que vão receber uma mensagem que sai desse cara.
-- Ou eu posso descaradamente copiar o codigo do botimo e ja devolver bonitinho.

-- Essa função vai alimentar uma mensagem que cria
--[[
   1) O botimo que recebe essa dupla de valores
   2) Como eu vou utilizar o valor do botimo?

]]

--[[
    Acho que o grande problema aqui é que estou querendo misturar criação e
    processamento, isso é muito complexo. Acho que faz mais sentido ter todo o
    processamento num script ofelia e SÓ ENTÃO que eu crio os objetos. Naturalmente,
    Isso subentende copiar a função do botimo.
]]

ofelia f;
    local media = 0
    succ = 0;
    local x = 300;
    local y = 400;
    local tamanho = #a
    for i=1, #a do; -- Lista de psis
        if a[i] < math.pi/2 then;
            succ = a[i+1];
        else;
            succ = a[i-1];
        end;
        if i==tamanho and a[tamanho] < math.pi/2 then;
            media = (a[tamanho] + math.pi)/2
        end;
        if i==1 and a[1] >= math.pi/2 then;
            media = (a[1]/2);
        -- a cada iteração, devolve um par phi_medio, phi.
        end;
        media = (a[i] + succ)/2;
        -- A cada iteração, devolva a posição x,y da mensagem que recebe essa
        -- saida.
        o:outletAnything(0, ofTable(x, y, media, a[i]));
        x = x + 200;
    end;
    -- checa a ultima iteração


ofelia f;
    local media = 0;
    local succ = 0;
    local id = #a + 4;
    local vsl_id = 4;
    local x = 92;
    local y = 320;
    local o=ofOutlet(this);
    local tamanho = #a;
    for i=1, #a do;
        if a[i] < math.pi/2 then;
            if i==tamanho then;
                succ = math.pi;
            else;
                succ = a[i+1];
            end;
        else;
            if i==1 then;
                succ = 0;
            else;
                succ = a[i-1];
            end
        end;
        media = (a[i] + succ)/2;
        o:outletAnything(0, ofTable(x, y, media, a[i], id, vsl_id));
        x = x + 30;
        y = y + 30;
        id = id + 2;
        vsl_id = vsl_id + 1;
    end;

