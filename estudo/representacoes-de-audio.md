# Representação de áudio

O som é um fenômeno físico que abstrai oscilações de partículas de ar: elas se comprimem e se expandem. 

**Sinal** é um modelo matemático utilizado para representar a variação de uma variável em função de outra: no nosso caso, usaremos o sinal sonoro para representar a variação da pressão do ar em função do tempo. Naturalmente, um computador não entende som diretamente então estudaremos os comportamentos dos sinais.

Os sinais podem ser classificados em **digitais** ou analogicos:

* Um sinal analógico está definido para **todos os instantes de tempo** em um intervalo real, associados a valores reais de pressão.
* Um sinal digital está representado em uma **lista de valores** finita de instantes de tempo. Os valores de pressão associados também são finitos

Além de estudarmos os sinais, vamos também estudar a conversão (**transdução**) de sinal digital para anologico (DAC) de de analogico para digital (ADC).

### Transdutores

São instrumentos cujo propósito é converter energia de uma forma para outra (ex.: microfone, ouvido. braço da vitrola).

### Conversão AD

Nessa conversão, iremos transdutar em hardware um sinal **analógico** (por exemplo, um sinal elétrico de um microfone) em um sinal **digital** para representação interna no computador.



Essa conversão produz uma **lista de valores** que pode ser armazenada em alguma estrutura de dados linear e indexada.

No pure data, existe um objeto chamado **adc~**, que serve justamente para capturar o audio do microfone, que é transformado em sinal eletrico digital, em sinais analogicos

***

### Detalhes da implementação em PD

Um programa em PD é chamado de patch. Um patch consiste de fluxogramas compostos por objetos (caixas), mensagens  (caixas com uma identação em forma de < ) e suas conexões



Mensagens e objetos podem ser criados na aba "inserir" no cabeçalho do pd. As conexões são criadas simplesmente clicando em uma saída (outlet) e arrastando até uma entrada de outro objeto (inlet)

O programa de conversão ADC no patch exemplo tem 3 partes:

1. Um objeto toggle conectado a uma mensagem `; pd dsp $1` . A chave envia 0 ou 1 quando é clicada, e esse valor substitui o $1 na mensagem para o objeto pd. Assim, enviar `dsp 1`  e `dsp 0`  significam, respectivamente ligar e disligar o dsp (Processamento digital de sinais do PD).

   O `;` indica que a mensagem vai ser enviada a um objeto nomeado.

2. Vetor que recebe o sinal. Ele foi configurado para receber 88200 amostras (ou seja, 2 segundos de áudio a 44100hz). O nome do vetor (`$0_sinal_adc` ) possui esse cifrão 0 no começo para ser um identificado unico (é bem similar ao `this`, fazendo que esse nome seja unico e localizado no patch)

3. Objeto `adc~`. ele recebe a entrada do microfone e envia para o objeto `tabwrite~`, que faz a escrita no vetor $0_sinal_adc

***

### Conversão DA

Essa conversão também é feita em hardware e transforma o sinal digital armazenado no computador em sinal elétrico (analógico).

Aqui temos o objeto `dac~` e o `tabplay~` que são complementares aos bojetos `adc~` e `tabwrite~`. 

### Detalhes da conversão

1. Módulo DAC: O que ele faz basicamente é emitir um sinal contínuo e atualizar o valor emitido por esse sinal a cada 1/R segundos - onde R é a taxa de amostragem - . O valor atualizado é o do sinal digital correspondente nesse instante de tempo. Então essencialmente ele emite um sinal digital com um formato similar a de uma escada.
2. Deglitcher: remove uns ruídos do sinal emitido
3. Filtragem passa baixa: mais uma etapa, responsavel por trabalhar ainda mais o sinal gerado, emitindo um sinal analógico o mais proximo possível do sinal digital.

***

## Amostragem e quantização

O conceito de amostragem está relacionado a discretização do eixo do tempo. Já quantização, à discretização da amplitude.

### Amostragem

A taxa de amostragem (a.k.a Sample rate, Rate ou SR ou R) é a **quantidade de amostras do sinal digital que correspondem à duração de 1 segundo**. Então se R = 3, em cada segundo temos 3 amostras de sinal digital.

No processo ADC, esse é o número de capturas por segundo que fazemos do sinal analogico para formar o sinal digital. Também existe o período de amostragem, que é simplesmente o inverso da taxa de amostragem.

O pd usa uma taxa de amostragem de 44100hz (ou seja, existem 44100 capturas em 1 segundo).



### Quantização

Se a amostrageme stá relacionado a limitar de quanto em quanto tempo colhemos amostra, o processo de quantização é responsável por determinar **um intervalo de ampliturde para cada amostra em quantidade de bits**. Assim, quanto maior a quantidade de bits, mais valores cada amostra pode demonstrar: uma taxa baixa de quantização achataria a amplitude de cada amostra em poucos intervalos, dando um gráfico em forma de escada. Uma quantização maior entrega um sinal mais fluído.

Assim, com uma quantização de B bits, teremos **2^B codigos possiveis**. 