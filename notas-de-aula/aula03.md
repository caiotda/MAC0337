# Aula 03

***

## Amplitude e frequência

Dois parâmetros importantíssimos para caracterizar sinais sonoros.

**AMplitude** se refere á variação vertical das amplitudes instantâneas. Usamos a amplitude para caracterizar a "força" ou "volume" sonoro. No Pd geralmente passamos a amplitude entre -1 e 1.

**Frequência** se aplica à sinais periódicos ou pseudo periodicos. É uma grandeza associada á taxa de repetição do sinal. Usamos frequência para analisar a **altura musical** de um som (grave/ agudo). A frequência pode ser **aproximada** para sinais aproximadamente periódicos. Podemos analisar a frequência de um sinal dentro de um sub intervalo dentro de toda a ocorrência do sinal.

### Definição de amplitude

Dentre diversas maneiras de definir a amplitude de sinais, temos:

**AMPLITUDE DE PICO**: Maior valor do absoluto de cada amplitude instantânea dentro de um intervalo de tamanho n. Por poder se tratar de uma amostra outlier (imagine um sinal no qual uma das amostras apresenta um pico isolado) que não afeta nossa percepção de volume sonoro, faz mais sentido tomarmos a **AMPLITUDE MÉDIA** do sinal - simplesmente tomamos a média do absoluto das amplitudes instantâneas.

Uma outra forma de medir é a **ENERGIA MÉDIA** de um sinal. A energia instantânea de uma amostra é simplesmente sua **amplitude instantanea** ao quadrado. Assim, a Energia média de um sinal é a média das amplitudes instantâneas ao quadrado.

Essa idéia de energia do som vem derivada da física. Podemos pensar na energia mecânica do sistema composto pelas partículas do ar, ou a energia cinética dos elétrons cujo sinal elétrico representa nosso sinal analógico.



Uma outra forma de medir a amplitude é relacionar a energia instantânea coma amplitude. É o a **AMPLITUDE RMS** (Root of mean square):
$$
RMS = \sqrt{\frac{x[0]^2 + x[1]^2 + \dots x[n-1]^2}{n}}
$$


Pense que você está somando energias (amplitudes ao quadrado) então o que você obtém é energia. Ao tirar a raíz quadrada, é como se você estivesse revertendo o processo e voltando a pensar em amplitudes.

Outro fato interessante é que a amplitude RMS é essencialmente uma **norma euclideana** do vetor de amostras. O 1/n seria como normalizar a energia pelo número de observações

Todas essas medidas de amplitude não se alinham muito bom a nossa sensação de volume. Uma primeira tentativa de aproximar à nossa noção de som é tomar o log da energia de cada amostra. Também pode ser aplicada a partir da frequência. Essa escala é chamada **escala decibel**

A Escala decibel foi montada com evidências empíricas de que nossos ouvidos reagem ao som com mudanças de escala na amplitudes ou energias de um sinal. Ou seja, se pegarmos um sinal e começarmos a multiplicar sua frequência/energia e começarmos a multiplicar ou dividir por um valor arbitrário ( 10, por exemplo), vamos ter a sensação de que os passos de volume seriam mais ou menos compatíveis entre si.



A escala decibel é derivada da escala bell, onde a energia de um sinal é definida como 1 unidade na expressão $log_{10}(energia)$. A energia em decibel é, então:
$$
E(db) = 10*log_{10}(\frac{Energia}{E^0})
$$
Onde $E^0$ é um patamar referencial de energia. Note como, ao multiplicar a expressão por 10, o argumento do log ganha 1 ponto. E se dividirmos por 10, decrescemos 1 ponto.

Podemos usar a frequência RMS para representar a energia de um sinal de db também. Se tomarmos a energia RMS como o quadrado da frequencia RMS, e E0 como 1, temos:
$$
E(db) = 10*log_{10}(Energia) = 10* log_{10}(RMS^2) = 20* log_{10}(RMS)
$$

Uma outra escala interessante toma e0 como o limiar inferior da audição humana. Essa é a escala **SPL = Sound pressure level**. Assim, todo som possui decibéis positivos. É a escala mais utilizada para medir força de um som.

### Frequencia instantânea e estimação

Frequência instantânea é um conceito usado para sinais que **não são senoidais**. Isso é feito definindo um pequeno intervalo de tempo e notando qual a frequência do sinal nesse pequeno intervalo.

A medida dessa frequencia é a ideia de minimizar o erro entre x(t) e x(t + periodo). Assim conseguiriamos um periodo estimado

Uma primeira abordagem é a **ZCR - Zero crossing rate/ Taxa de cruzamento pelo zero**, que, diga-se de passagem, é uma abordagem horrível pra aproximar a frequência de um som, mas é bem simples. A idéia do ZCR é calcular quantas vezes a forma de onda cruza do negativo pro positivo ou positivo pro negativo. A função seno, por exemplo, cruza o zero 2 vezes por período então uma senoide que tem frequência de 100hz, ela vai ter um zcr de 200, então essa abordagem é bem ruim pra senoide. A abordagem do ZCR tende a tornar-se mais precisa quanto maior o intervalo de tempo considerado.

