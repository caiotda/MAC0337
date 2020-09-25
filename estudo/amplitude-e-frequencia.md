# Aula 03



Amplitude, frequência e teorema de nyquist

***

## Amplitude e frequência

**amplitude**: Variação vertical das amplitudes instantâneas. Grandeza utilizada para caracterizar a força ou volume de um som

**frequência**: periodicidade de um sinal. Em contexto musical, está associado à **altura musical**, que é um conceito que caracteriza quão agudo ou grave um som é (claro, isso só faz sentido se compararmos dois sons, já que é uma medida comparativa.)

### Definições de amplitude

Existem várias formas de definir e medir a amplitude de um sinal.

**Amplitude de pico**: medida que toma a **maior amplitude absoluta** entre todos os sinais amostrados. Cada sinal i apresenta uma amplitude x[i], que seria simplesmente a sua altura no eixo y. O que isso aqui faz é olhar pra toda amostra e ver qual teve um maior deslocamento vertical. 

Note que essa medida acaba não sendo útil para sinais com anomalias, ou seja, picos isolados.

Com essa dificuldade em mente, surge a **amplitude média**, que simplesmente toma a média das amplitudes instantâneas.
$$
amplitude\_media = \frac{x[0] + x[1] + \dots x[n-1]}{n}
$$


Como a noção de amplitude de um sinal está associado a quanto um sinal oscila em picos, associa-se uma noção de energia à amplitude: pense em ondas no mar. Para fazer uma onda com alta amplitude é necessário fazer uma perturbação intensa na água, o que exige muita energia. Convenciona-se a definir a energia de uma amostra como **o quadrado da sua amplitude**.
$$
energia\_de\_uma\_amostra\_i = x[i] ^ 2
$$




Assim, a **energia média** de um sinal é simplesmente a média das energias em cada ponto do sinal.


$$
energia\_do\_sinal = \frac{x[0] ^2 + x[1] ^2 + \dots x[n-1]^2}{n}
$$




Associado ao conceito de energia média, existe a **amplitude RMS**, que traz os valores de energia de volta à escala de amplitudes: tomamos simplesmente a raiz quadrada da soma das energias, e tiramos a média (RMS = Root mean square)
$$
RMS = \sqrt{\frac{x[0] ^2 + x[1] ^2 + \dots x[n-1]^2}{n}}
$$
. É uma grandeza que se assemelha bastante a **tirar a norma euclidiana de um vetor**

Todas essas definições são bem matemáticas, mas pouco se traduzem ao conceito de altura musical, ou a nossa percepção sonora no geral. Experimentalmente, percebemos que nossa audição funciona em **ordens de grandeza**, ou seja, em ordem **multiplicativa** (percebemos pouco incrementos lineares no áudio, mas se dobrarmos, percebemos claramente). Isso sugere uma abordagem **logarítmica** a como modelamos a intensidade sonora. Podemos, inclusive, tomar o log da energia

### Escala bel

A escala bel é definida como a variação relativa de 1 unidade na expressão $log_{10}(energia)$. E a medida em decibéis é simplesmente dada como 
$$
Energia(db) = 10*log_{10}(\frac{energia}{e^0})
$$
Onde $e^0$ é uma **energia de referencia**. Uma escala comum é tomar *e^0* como o quadrado da frequência mínima que somos capazes de ouvir. Essa é a escala **SPL** de decibéis, extremamente usada

### Medindo a frequência

Para sinais periódicos, é trivial medir a frequência. PAra sinais não periódicos, podemos analisar um intervalo pequeno do sinal e **aproximar a frequência** nesse intervalinho.

Outro estimador (bastante impreciso, mas simples) é a **taxa de cruzamento por zero** ou ZCR: analisamos o sinal em x[t] e x[t+1]: se um deles é positivo e o outro é negativo, então o sinal cruzou o eixo x. A quantidade de vezes que cruzou o zero nos dá a quantidade em ZCR que serve de aproximação para a frequência. Essa medida fica mais precisa a medida que consideramos intervalos maiores.