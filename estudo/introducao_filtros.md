## Introdução a filtros



### Convolução

Convolução é uma operação binária que associa dois vetores a um terceiro vetor. A convolução z = x*y é definida como:
$$
z[n] = \sum_m x[m] . y[n-m]
$$
Ou seja, é um produto ponto a ponto onde um dos vetores está "shiftado" n posições. Essa coinvolução é chamada de **linear**, na qual percorremos todos valores que x[m] . y[n-m] é não nulo. Quando temos conhecimento da quantidade de amostras (ou seja, temos N amostras), usamos a **Convolução circular**: todos os indices são interpretados de forma periodica:
$$
z[n] = \sum_{m=0}^{N-1} x[m]. y[(n-m)\%N]
$$
Veremos que a convolução no domínio do tempo tem papel central na aplicação de filtros.

### Filtros da média e da diferença

Os primeiros filtros que vamos ver são os filtros da média e da diferença.



O filtro de média, como diz o nome, faz a média entre dois sinais consecutivos:
$$
y[n] = \frac{x[n] + x[n-1]}{2}
$$
Ele pode ser descrito como uma convolução também:
$$
z = x * l
\\
onde \ l \ = [0.5, 0.5, 0,0....,0]
$$
Se a gente aplica essa convolução, dá exatamente a definição do filtro. Esse filtro é chamado de **passa baixa**, porque ele filtra componentes senoidais de alta frequencia, e deixa passar frequencias mais baixas.



O filtro da diferença é?
$$
y[n] = x[n] - x[n-1]
\\
ou
\\
y = x * l, \ l = [1, -1, 0, 0, \dots, 0]
$$
Esse é um filtro **passa alta**: reduz frequencias baixas e passa frequencias altas.



Se fizermos a analise da DFT desses sinais com o filtro da média e o filtro da diferença, fica claro o motivo de cada um ser um filtro passa alta e filtro passa baixa. Vamos tomar o filtro da media como exemplo.

Se aplicarmos a dft no sinal do filtro, vamos chegar em:
$$
Y[f] = cos\frac{\pi f }{N}. exp\_f[\frac{-1}{2}] . X[f]
$$
Ou seja, as amplitudes de cada frequencia vão ser limitadas por um cosseno, que é maximo para f = 0 e decresce até f = N/2, onde é minimo (0, na verdade). Dai em diante ocorre rebatimento, ja que N/2 é nyquist, e voltamos a subir. Por isso as frequencias altas são filtradas.

O filtro da diferença é parecido, mas o espectro é multiplicado por uma senoide, o que explica porque ele amplifica frequencias altas, proximas de nyquist.

### Segunda forma do teorema da convolução

Vimos, anteriormente, algumas coisas sobre a convolução dos espectros: vimos que se z = x.y então Z = 1/N . X * Y; Uma consequencia dessa relação é que **a convolução no dominio do tempo esta relacionada ao produto dos espectros**:

Dados dois sinais x e y, a convolução z = x*y satisfaz Z = X.Y;

Lembrando da interpretação geométrica da multiplicação de dois números complexos (lembrando que representamos o espectro do sinal como uma exponencial complexa), o que isso signficia é que o espectro da convolução é o produto complexo dos dois sinais convoluidos. Isso significa que eu faço um produto da magnitude dos espectros e acresco a fase de um deles.

## Equação geral do filtro

A equação do filtro é composta por dois sinais: um sinal de entrada, e um sinal contendo coeficientes do filtro (ele é usado da mesma forma que o sinal "l" foi usado no filtro da média):
$$
y[n] = \sum_m h[m] . x[n-m]
$$

### Resposta ao impulso e resposta em frequência

Uma forma de caracterizar um filtro é analisar sua **resposta do filtro ao impulso**: se tomarmos como sinal de entrada um sinal $\delta$, onde $\delta$[n] = 1 se n = 0 e $\delta$[n] = 0 do contrario. Se aplicarmos a convolução nesse sinal de entrada vamos ter exatamente os coeficientes do filtro:
$$
y[n] = \sum_m h[m] . \delta[n-m] = h[n] . \delta[n - n] = h[n]
$$
Note que isso implica que o impulso discreto é o elemento neutro da convolução (x*delta = x, para qualquer sinal x).

Uma outra forma de caracterizar o filtro é olhando no domínio espectal, e não temporal. Se lembrarmos da segunda forma do teorema da convolução, podemos olhar para a equação geral do filtro (y = h * x) na forma espectral: Y = H . X; Lembrando da interpretação polar da multiplicação complexa, podemos ver que cada coeficiente H[k] realiza modificações em aplitude e fase na componente X[k] . exp_k[n] da entrada.

### Filtros FIR, IIR e Causalidade

FIR: Finite impulse response

IIR: Infinite impulse response

São dois termos usados pra disciminar filtros com coeficientes finitos ou infinitos. 

OS filtros FIR podem ser representadoscomo:
$$
y[n] = \sum_{m = L}^{N-1} h[m] . x[n-m]
$$
Onde L...N-1 são os indices que h não é nulo. Existe um caso especial onde L = 0.

Devido à convolução, coeficientes onde L = 0 são particularmente uteis porque cada y[n] usa apenas amostras atuais ou anteriores do sinal (x[n], x[n-1], x[n-2]...). Chamamos esses filtros de **filtros causais**. Esses filtros funcionam bem para processamento em tempo real. Filtros não causas, ou seja, que dependem do futuro do sinal (se L < 0 isso acontece) nao funcionam bem pra processamento em tempo real e para usa-lo nesse cenario seria necessario o uso de um **Delay**. Em arquivos de áudio (ou seja, sabemos o conteúdo do sinal inteiro de antemão), ele funciona bem.

### filtros IIR e recursão

Uma forma de aplicar filtros IIR é utilizar definições recursivas: para calcular um termo N do filtro, usamos termos anteriores. Por exm:
$$
y[n] = x[n] - 0.95 * y[n-1]
$$
Note que é importante que o segundo termo convirja a 0, se não isso pode explodir.

A forma geral de um filtro IIR usando termos de recursão é
$$
y[n] = \sum_{m = 0}^{N-1}a[m] . x[n-m] + \sum_{l = 1}^{M} b[l] . y[n - l]
$$
