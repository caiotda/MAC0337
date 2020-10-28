### Detecção de componentes senoidais

O objetivo dessa seção é estudar **sinais complexos**. Faremos isso decompondo esses sinais mais complexos em componentes senoidais. Inicialmente, iremos decompor sinais simples, eles mesmo senoidais. Para encontrarmos os componentes senoidais de um sinal x vamos usar a **correlação**, definida como:
$$
(x, y) = \sum_{n=0}^{N-1}x[n]y[n]
$$
Para sinais com N amostras. Iremos estudar como interpretar o resultado da correlação entre dois sinais e assim acertarmos componentes de um dado sinal. A correlação tem uma interpretação geométrica, que é exatamente a de **produto escalar**. Por isso, iremos dizer que um sinal é ortogonal a outro se (x,y) = 0.

### Ortogonalidades entre senos e cossenos de fase 0

Chamamos um sinal $x[n] = cos(\frac{2 \pi n}{N})$ (serve pro seno também) de fase 0 pois vale que $\phi[n] = \frac{2 \pi n}{N}; \phi[0] = 0$.

Vamos primeiro observar a ortogonalidade entre dois cossenos, um cosseno x de frequencia f, e outro cosseno de frequencia g. Logo
$$
x[n] = cos (\frac{2 f\pi n}{N})
\\
y[n] = cos(\frac{2 g \pi n}{N})
$$
Queremos usar a correlação para tentar entender a relação entre os dois sinais. Note que teríamos um produto entre dois cossenos. Para simplificar essa conta, podemos fazer uso da propriedade trigonométrica:
$$
cos(a)cos(b) = \frac{cos(a+b)+cos(a-b)}{2}
$$
Assim, teríamos
$$
(x, y) = \sum_{n=0}^{N-1}x[n]y[n]
\\
(x,y) = \sum_{n=0}^{N-1}cos (\frac{2 f\pi n}{N}) * cos(\frac{2 g \pi n}{N})
\\
\therefore 
\\
(x,y) = \sum_{n=0}^{N-1} \frac{cos(2\pi n(f+g))+cos(2\pi n (f - g))}{2}
$$
Note que se f != g, estamos somando dois sinais cossenoidais. Se somarmos cada sinal, vai dar zero (o sinal é periódico).

Agora, se 0 < f ==g < N/2, note que f-g = 0, logo $cos(2 \pi n (0)) = 1$, enquanto que o outro termo, pela mesma lógica anterior, soma 0. Assim, teríamos uma soma de N/2.

Sobra um último caso, que é f = g = 0. Pelo argumento do item anterior, a soma de cada Cosseno vai dar N/2, totalizando uma soma de N.



Assim, conseguimos tres resultados interessantes para a correlação entre dois cossenos: (x,y) = 

* 0, se f != g
* N/2, se 0 < f=g < N/2
* N, se f = g  = 0.

Assim, podemos usar a segunda condição para construir um **algoritmo de deteccção** que percorre todas frequencias num intervalo até encontrar uma frequencia tal que a correlação entre os dois sinais é N/2. Isso é feito para **detectar** a frequencia de x, chutando varias frequências para y.



**Seno com seno**

Para correlacionar seno com seno, convém relembrar dessa identidade trigonométrica:
$$
sen(a)sen(b) = \frac{cos(a-b) - cos(a+b)}{2}
$$
Assim, teriamos a correlação como:
$$
(x,y) = \sum_{n=0}^{N-1} \frac{cos(2\pi n(f-g))-cos(2\pi n (f + g))}{2}
$$
Alguns resultados interessantes:

* (x,y) = 0 se f != g
* [NOVO] (x,y) = 0 se f = g  = 0 ou f = g = N/2 (nesses casos vale que x[n] = 0 e y[n] = 0 para todo n )
* Ainda vale que (x,y) = N/2 se 0 < f = g < N/2

**Seno com cosseno**

Para seno e cosseno podemos seguir o mesmo procedimento trigonométrico mas iremos direto ao ponto: se x é seno e y é cosseno (ou vice e versa), (x,y) = 0, sempre.

### Componentes arbitrárias

Primeiramente, estudamos como identificar componentes senoidais de fase 0, o que é uma simplificação, obviamente. Agora vamos estudar componentes **arbitrarias**, ou seja, fase inicial $\phi$.

Ou seja, vamos representar uma componente qualquer como:
$$
x[n] = Acos(\frac{2 \pi f n}{N} + \phi)
$$
Mais uma vez podemos fazer uso de identidades trigonométricas para tentar reduzir nosso problema complexo em algo que já conhecemos (componentes com fase 0):
$$
cos(a+b) = cos(a)cos(b) - sen(a)sen(b)
$$
Podemos usar isso para decompor o sinal x em:
$$
x[n] = Acos(\frac{2 \pi f n}{N})cos(\phi) - Asen(\frac{2 \pi f n}{N})sen(\phi)
$$
E pronto, decompomos em sinais de fase 0.

Para simplificar a escrita vamos tomar:
$$
\alpha = Acos(\phi)
\\
\beta = Asen(\phi)
$$

$$
x[n] = \alpha cos(\frac{2 \pi f n}{N})- \beta sen(\frac{2 \pi f n}{N})
$$

Note que, se encontrarmos de alguma forma, alfa e beta, poderiamos reconstruir a amplitude e a fase inicial do sinal. Isso segue pelas duas relações a seguir:
$$
A = \sqrt{\alpha^2 + \beta^2} \ (pitagoras)
\\
\phi = arctan(\beta, \alpha)
$$
As coordenadas (A, $\alpha$) e ($\alpha, \beta$) são conhecidas como **coordenadas polares** e **coordenadas cartesianas**; No segundo caso, estamos tomando a componente horizontal e vertical de uma reta dentro de um círculo (pense num circulo unitario e uma reta partindo da origem e atingindo um ponto em, digamos, 45 graus). As coordenadas polares, por outro lado, são definidas exatamente pelo comprimento (em relação à origem) e inclinação do segmento de reta.