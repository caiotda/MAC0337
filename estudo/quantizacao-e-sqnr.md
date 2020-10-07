# Quantização e SQNR

***

### Introdução

Na conversão AD, estudamos o processo de amostragem, que corresponde ao processo de discretização no eixo temporal de amostras, isto é, no processo de amostragem essencialmente escolhemos quantas amostras queremos colher por unidade de tempo.

Um processo equivalente, mas discretização do eixo de amplitude é o processo de **quantização**: nesse processo, definimos uma **codificação**, ou seja, para cada amplitude instantânea x[t], definimos quais os valores possíveis que essa amplitude for armazenada. Uma consequência natural disso é que, se usarmos uma quantização baixa, não vamos notar diferença entre dois picos sucessivos de amplitude instantanea se a diferença for muito pequena: é como se eu "arredondasse" valores de amplitude para uma faixa de representação.



Como vimos, o processo de amostragem é um processo **sem perdas**: conseguimos transitar livremente entre sinal digital e analogico sem perder nada na amostragem. O processo de quantização, por sua vez, é um processo **com perdas**:  para amplitudes `x[n]`que pertencem a uma reta real, vamos mapear esses valores`q(.)` para um conjunto **finito** de códigos disponíveis. Naturalmente, tem perda nesse processo.



Vamos estudar o processo de **Quantização linear** olhando para a codificação com n bits e perceber o **ruído de quantização** correspondente

O ruído da quantização pode ser entendido como:
$$
\epsilon[n] = x[n] - q(x[n])
$$
E o SQNR (Signal to quantization noise ration) é a razão da **energia do sinal e a energia do ruído**, geralmente em decibeis:
$$
SQNR(db) = 10 log_{10}(\frac{energia(x)}{energia(\epsilon)})
\\
\therefore
\\

SQNR(db) = 20 log_{10}(\frac{amplitude(x)}{amplitude(\epsilon)})
$$

### Quantização linear

No processo de quantização linear escolhemos um número de bits B para quantizar nosso sinal. Assim, pra toda amplitude X em [-1, 1). esse valor vai ser representada num intervalo. Os valores de x vão ser dividos em 2^B intervalos, cada um com uma largura $L = \frac{2}{2^B}$.A quantização de cada amplitude x é :
$$
q(x) = (floor(\frac{x+1}{L}))
$$
Isso mapeia cada valor de x para sua faixa de representação correspondente. Chamamos L de **Resolução de amplitude**, isso representa a menor distinção possível entre duas amplitudes x.

No processod e **dequantização** normalmente elege-se um representante para cada intervalo (normalmente o ponto médio) e fazemos:
$$
d(q) = -1 + \frac{L}{2} + qL
$$
E o erro é limitado por L/2 (?)

### Erro da quantização linear

Podemos analisar o erro da quantização linear comparando a amplitude instantânea de um sinal com o valor resultante de quantizarmos e então dequantizarmos esse valor:
$$
\epsilon[n] = x[n] - d(q(x[n]))
\\
\epsilon[n] = x[n] - 1 - \frac{L}{2}-\lfloor \frac{x[n] + 1}L{L}\rfloor
$$
Onde estamos tomando o representante do intervalo como o ponto médio.

Como o erro é limitado por L/2, faz sentido pensar que o ruído tem uma amplitude maxima de L/2. Assim, se calcularmos o SQNR:
$$
SQNR(db) = 20 log_{10}(\frac{amplitude(x)}{amplitude\_ruido})
\\
SQNR(db) = 20 log_{10}(\frac{amplitude(x)}{L/2})\\
SQNR(db) = 20 log_{10}(aamp\_sinal) + 20log_{10}2^B
\\
\approx 20 log_{10}(AMp\_sinal) + 6b
$$
Assim,cada bit represente 6db na SQNR.  Note que a SQNR é menor para sinais mais fracos. Como a SQNR é uma razão entre o sinal e ruido gerado pela quantização, queremos valores altos de sqnr (então uma quantização alta e sinais com amplitude alta acabam gerando um ruido com menos energia do que o sinal)

### Compensação de erro por dithering

Note que o sinal de erro gerado possui características periódicas, já que está associado a amplitude instantânea de um sinal: se esse sinal é periódico, o erro torna-se periódico. O ouvido humano tem uma tendeência de perceber melhor sinais periódicos do que não periódicos, então a periodicidade do erro não é um efeito desejável.



Para tanto, fazemos uso do processo de **dithering** que consiste em interferir de maneira aleatória no processo de quantização: assim, tornamos o ruído de quantização algo menos audível. Essa interferência é feita ora "empurrando" para cima ora pra baixo a amplitude de um sinal. O que normalmente é feito é adicionar um ruído de amplitude L/2.

### Quantização não linear

A idéia da quantização não-linear é de justamente resolver o problema da SQNR para sinais de baixa amplitude.

Existe a escala $\mu$-Law que distribui as amplitudes representaǘeis numa escala logarítmica. Uma consequência natural disso é que o sinal quantizado apresenta "escadinhas" com comprimento cada vez menor conforme menor for a amplitude, e maior conforme aumentamos a amplitude.



Assim, conseguimos manter o SQNR constante independentemente do volume do sinal original.