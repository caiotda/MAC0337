# 1.1.3 Sinais elementares

Nessa aula vamos ver como construir os tipos de sinais mais elementares estudados nos processamentos de sinais: **ruídos** e **sinais periódicos**, como sinais senodais, dente de serra e ondas quadradas.

***

### Ruídos

Em teoria da informação, **ruído é qualquer sinal indesejado** adicionado à informação desejada.

Geralmente, ruídos não possuem altura musica definida. Lembrando que altura musical é o conceito musical que classifica um som como agudo ou grave - claro que podemos classificar um ruído como mais agudo ou mais grave que outro, mas o ruído em si não apresenta essa caracterísstica -.



Importante: alguns sons sem altura musical definida não são ruidos! Gongos, sinos etc.

Caracterizando ruídos: ruídos podem ser classificados de acordo com a frequência que ocupam e também através de uma nomenclatura de cores, usando uma analogia entre o espectro de cores e o sonoro.

### Sinais periódicos

São sinais que satisfazem a fórmula
$$
x(t) = x(t + \tau)
$$
Para qualuquer $\tau$. O menor $\tau$ que satisfaz a equação é chamado de **período** do sinal. Associado ao conceito de perído existe o conceito de **frquência**, que é simplesmente o inverso do período (unidade hz).

Apesar de não existirem sons perfeitamente periódicos na natureza, o conceito de sinais periodicos é de alta importância pois a frequeência de um som está associado à sua **altura musical**: sons graves tipicamente possuem uma baixa frequência enquanto que sons agudos possuem uma alta frequência.



Dentre os sinais periódicos, possuimos os sinais **senoidais** cujo valor x(t) pode ser modelado por uma senoide:
$$
x(t) = sen(\omega t + \psi^0)
$$
 Onde $\omega$ é denominada a **frquência angular** e $\phi$ é a **fase inicial**. Tipicamente, a fase de uma onda senoidal é simplesmente
$$
\phi(t) = \omega t + \phi(0)
$$
Onde $\phi(0) = \phi^0$.

O período da senoide é
$$
T = \frac{2\pi}{\omega}
$$
O que frequentemente é escrito como
$$
\omega = \frac{2\pi}{T} = 2\pi f
$$
Assim, a equação da senoide é tipicamente representada como:
$$
x(t) = sen(2\pi ft + \phi^0)
$$
No PD, Podemos usar essa equação para montar um sinal periódico usando Lua no objeto Ofélia:

```lua
ofelia f;
local x=ofArray("$0_113D");
local fase=0;
local delta=2*math.pi*a/44100;
for i=0, x:getSize()-1 do;
	fase=fase+delta;
	x[i]=math.sin(fase);
end
```

Nos patches usando ofélia, o `a` sempre representa a entrada. Isso é feito por meio do inlet do objeto ofelia.



O que esse bloco de codigo faz é inicializar $\phi^0 = 0$ e fazer incrementos na fase da senoide a cada nova amostragem do PD (isto é, a cada 1\44100 instantes de tempo) e tirando o seno dessa fase angular.

### Sinal dente de serra

O sinal dente de serra não passa de uma rampa linear que se repete periodicamente, com quedas abruptas quando atinge seu maxmio

***

Detalhes da implementação

Para gerar o sinal dente de serra usamos o seguinte código Lua:

```lua
ofelia f;
local x=ofArray("$0_113E");
local amp=0;
local delta=2*a/44100;
for i=0, x:getSize()-1 do;
	x[i]=amp;
	amp=amp+delta;
	if amp>1 then amp=amp-2 end;
end
```



 O que isso faz, basicamente, é variar o x[i] de 0 até 2. Sempre que `amp > 2`, resetamos seu valor para dar esse formato de queda abrupta.

### Forma de onda quadrada

Esse sinal **alterna** entre extremos periodicamente (o sinal dente de serra subia e descia entre os extremos, esse sinal simplesmente alterna entre os extremos)

***

# 1.1.4 Processamento em tempo real



Até agora lidamos com sinais digitais armazenados num vetor do puredata, onde temos uma amostragem a cada 1/R segundos. Note que o momento de armazenamento do sinal analógico, a conversão em sinal digital e sua reprodução são processos feitos em momentos diferentes. No entanto, o Puredata implementa um modelo de  **Processamento de fluxos em tempo real**, onde os sinais de áudio são capturados, processados e reproduzidos em fluxo contínuo e simultaneamente.

No entanto, um computador - mesmo que com vários núcleos de processamento - trabalha seus processos por meio de interrupções e escalonamentos. Assim, a aparente fluidez e continuidade do processamento de sinais em puredata é feito graças a um sofisticado sistema de segmentação de sinal em **blocos**, gerenciados em um grafo de todas as unidades de DSP. Isso garante o correto escalonamento entre o processamento de todos os blocos na ordem em que aparecem no patch.

### Objetos DSP

O tamanho dos blocos de DSP em tempo real são 64 amostras. Como ta taxa de amostragem do PD é 441000hz, isso quer dizer que a cada 64 amostras - 1.45ms - todos os objetos DSP recebem veetores de 64 amostras em suas entradas e são obrigados a produzir vetores de 64 amostras em suas saídas.

Para um objeto B receber um vetor de amostras de um outro objeto A, é mandatório que o processamento de A tenha sido concluído antes de começarmos o processamento de B. Fazemos isso para garantir que todos os objetos processam blocos que corerspondem a mesma janela de 1.45ms de tempo real. O grafo DSP, por consequencia, deve ser aciclico.



Os objetos DSP em PD tem seu nome, por convenção, terminados por um til (~)

