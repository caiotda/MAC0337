### Convolução e filtros

* Teorema da convolução
* Diferentes tipos de janelamento
* Breve introdução a filtros

***

### Teorema da convolução (produto no dominio do tempo)

Se temos um sinal x e w (w é o vetor de 0-padding) e um y resultante de y = w.x (produto de radamar: y[n] = x[n] . w[n]) . Agora sejam Y, X e W as DFTs de x y e w, então vale que
$$
Y = \frac{1}{N}(X * W)
$$
Onde X * W é a **convolução de x por w**.

Onde a convolução é definida como:
$$
X * W = \sum_{f=0}^{N-1}X[f] . W[k-f]
$$
Isso é, eu percorro os dois vetores e multiplico um deles de forma espelhada.

Obs: X Y e W são periódicos.

Em outras palavras, estamos multiplicando o sinal X para toda frequencia f pelo sinal W **atrasado k amostras** 

**Interpretação geométrica da convolução**

O patch 123E tem uma explicação mais detalhada, mas uma interpretação interessante é a seguinte. Se X define um padrão de onda bem definido (um trecho de senoide por exemplo), Y vai determinar padrões de **repetição** de X, isto é, um mapa de cópias. Marcamos varios pontos de Y que determinam em que posição de X * W o sinalzinho em X será copiado. 

A convolução é comutativa, então tanto faz quem é o mapa de cópias.

### Outros janelamentos

Vimos até agora o janelamento retangular, que consiste de usar W[n] = 1 quando coincide com o sinal e W[n] = 0 do contrario. Vamos ver alguns outros:

* **Janela triangular**: 
  * w[n] = 1 - 2*abs(n-N/2)/N
  * Convolução de duas janelas retangulares de larguna N/2.
  * Lobo central mais alrgo mas lobos laterais mais baixos que uma janela retangular
* **Janela Hann**
  * Elimina bastante a descontinuidade de bordas
  * w[n] = $\frac{1}{2} - \frac{1}{2} . cos(\frac{2\pi n}{N})$ (cosseno invertido e levantado)
  * Espectro bem concentrado em 3 bins.

* **Janela Hammin**
  * w[n] = $1 - (1-a) . cos(\frac{2\pi n}{N}), a \approx 0.54$
  * Formulação levemente alterada de Hann que canceça o primeiro lobo lateral, reduzindo vazamento espectral.

***

## Filtros

### Convolução em filtros

Operação mais basica na aplicação de filtros. Relembrando, é uma operação que toma dois vetores e retorna outro:
$$
z[n] = \sum_{m}^{}x[m].y[n-m]
$$
Podemos interpretar isso de duas formas:

1.convolulção linear: que é a que deixei ai em cima, dai usamos ela para sinais infinitos, por isso não determinamos limites para o m.

2. Convolução **circular**: foi o que abordamos até agora. Percorremos m valores inteiros (na pratica, todos os valores para os quais x[m] e y[n-m] não sao nulos) e tratamos os sinais como **periodicos**:
   $$
   z[n] = \sum_{m = 0}^{N-1}x[m].y[(n-m)\% N]
   $$
   

### Exemplos de filtro

* Filtro de médiaa: Para cada amostra n, faz a média entre x[n] e x[n-1]:
  $$
  y[n] = \frac{x[n] + x[n-1]}{2}
  $$
  Note que podemos interpretar isso como a convolução de x com o vetor l onde l = (1/2, 1/2, ,0.....). Verifique! Basta tomar a expressão de convolução linear. É um filtro de **passa-baixa**, ou seja, ele pega bem sinais de baixa amplitude

* Filtro da diferença: Toma a derivada discreta (mais ou meeenos - é o mais proximo que conseguimos chegar em sinais discretos). Ele só toma a diferença entre duas amostras sucessivas:
  $$
  z[n] = x[n] - x[n-1]
  $$
  Tambem pode ser visto como z = x * h, onde h = (1, -1, 0, 0, ..., 0). É um filtro de **passa-alta**

Estudar melhor a analise dos filtros da media e diferença.