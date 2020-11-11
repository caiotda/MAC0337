### Aula de 14/10/2020

Topicos abordados:

* Resolução da analise de Fourier a principio da incerteza

* FFT: Fast Fourier Transform
* Vazamento espectral



***

Até agora, usamos explicitamente tamanhos de bloco ("blocos de N amostras") para fazer a DFT. Vimos que ele definia a coleção de **frequencias utilizadas na representaçaõ espectral**. Uma coisa que não foi muito enfatizada, é que esse N determina a quantidade de componentes senoidais (ou frequencias) que podemos usar para representar o sinal.

Além disso, vale lembrar que sempre falamos de frequencia estamos tratando de sinais em frequencia em **ciclos completos por bloco**, e a frequencia em hz é determinada por:
$$
f\_hz = f * R/N
$$
Note que R/N é o número que determina a menor diferença observável entre BINS (**resolução espectral**) onde cada bin é uma caixinha de frequencia que um sinal senoidal componente apresenta.





Aqui temos uma relação interessante entre resolução espectral e **duração do bloco de analise** (N/R segundos). Note que se aumentarmos o bloco, a duração do bloco de analise aumenta (aumentamos a precisão de **localização temporal**) o que causa uma **diminuição da resolução espectral**.



Assim, é enunciado o **principio da incerteza em processamento de sinais**: é impossivel aumentar simultaneamente a precisão da localização temporal e a resolução espectral.

***

### Fast Fourier Transform

Um problema da transformada de Fourier é que, para cada frequencia f, teriamos que calcular:
$$
x[N] = \frac{1}{N}\sum_{f = 0}^{f = N/2}y[f] * exp\_f[n]
$$
onde y[f] é a coleção de coeficientes de fourier. Note que isso é quadrático. Queremos algo mais rapido e eficiente. A base do algoritmo é que podemos quebrar a DFT de um sinal X em seus indices pares e impares:
$$
X[f] = X_{par}[f] + e^{-i2\pi f/N} * X_{impar}[f]
$$
E podemos fazer isso sucessivamente até ter um sinal de tamanho 1, nesse caso a transformada de fourier desse sinal é ele mesmo. Assim, usando essa implementação de divisão e conquista teriamos:

```
FFT(x)
1.	se |x|=1 devolva X=x
2.  Xpar = FFT(par)
3.	Ximpar = FFT(impar)
4.	para f = 0,...., N/2 - 1
5. 		X[f] = Xpar[f] + exp(-i2pif/N)*Ximpar[f]
6. 	X[N/2] = Xpar[0] - Ximpar[0]
7.	para f = N/2+1,...,N-1
8.		X[f] = conjugado(X[f-1])
9.	devolva X
```

E essa implementação é linearítmica!

***

### Vazamento espectral e janelamento

**Vazamento espectral é uma consequencia do janelamento**. O Janelamento por sua vez é um termo que se aplica à seleção de trechos de um sinal para fim de analise e processamento. Pressupomos uma janela pela qual observamos o sinal (isso é uma consequencia natural de amostragem limitada).

 

O vazamento espectral então é um termo que resume o efeito resultando de analisarmos segmentos de sinal que contem componentes senoidas diferentes daquelas utilizadas pela transformada. É uma característica intrinseca ao janelamento.

É uma consequencia natural também da transformada de fourier: ela trabalha com sinais periodicos (senos e cossenos) e ao amostrarmos um sinal periodico, não estamos criando um sinal verdadeiramente periodico porque estamos amostrando uma porção do sinal.



Para entender o vazamento, temos que pensar no sinal gerado por fourier: Recebemos um sinal finito supostamente periodico (como N blocos de amostras de uma senoide) em forma de coordenadas polares e vamos reconstruir isso em um sinal continuo. A equação de sintese da transformada é:
$$
x[n] = \frac{1}{N} \sum_{f=0}^{N-1}x[f]exp\_f[n]
$$
Uma característica essencial da TF é que x[N + n] = x[n], então podemos construir um sinal continuo e suficientemente largo a partir de N blocos. Mas isso tem um porem: há uma "descontinuidade" entre X[0] e X[N-1] (que é exatamente no ponto que imendamos o sinal das N amostras com o proximo ciclo periodico do sinal). Justamente essa descontinuidade gera o vazamento: há uma região complicada no meio do sinal geradonessa ressintese que, se aplicarmos a transformada para tentar entender o espectro, a transformada pode entender o sinal como não uma senoide, mas a combinação de uma senoide com outro sinal (por isso gera aquele ruido)



Aproveitando a propriedade de periodicidade da equação de síntese, podemos **aumentar o janelamento** simplesmente preenchendo o sinal de entrada com zeros: colocamos varios zeros após o sinal e tornamos a janela tão grande quanto quisermos (zero-padding). Isso acaba gerando um sinal construido pela DFT com mais pontos e pondendo gerar um sinal espectral mais suave.