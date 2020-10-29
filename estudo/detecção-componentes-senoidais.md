### Detecção de componentes senoidais

O objetivo dessa seção é estudar **sinais complexos**. Faremos isso decompondo esses sinais mais complexos em componentes senoidais. Inicialmente, iremos decompor sinais simples, eles mesmo senoidais. Para encontrarmos os componentes senoidais de um sinal x vamos usar a **correlação**, definida como:
$$
(x, y) = \sum_{n=0}^{N-1}x[n]y[n]
$$
Para sinais com N amostras. O nosso processo será decompor nosso sinal de entrada em várias componentes x's, e por meio da correlação, iremos encontrar informações úteis sobre essa componente ao comparar com um sinal conhecido y. Iremos estudar como interpretar o resultado da correlação entre dois sinais e assim acertarmos componentes de um dado sinal. A correlação tem uma interpretação geométrica, que é exatamente a de **produto escalar**. Por isso, iremos dizer que um sinal é ortogonal a outro se (x,y) = 0.

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

O que mostra que podemos tomar um sinal como a combinação linear de dois outros sinais (estes de fase 0). Note que, se encontrarmos de alguma forma, alfa e beta, poderiamos reconstruir a amplitude e a fase inicial do sinal. Isso segue pelas duas relações a seguir:
$$
A = \sqrt{\alpha^2 + \beta^2} \ (pitagoras)
\\
\phi = arctan(\beta, \alpha)
$$
As coordenadas (A, $\alpha$) e ($\alpha, \beta$) são conhecidas como **coordenadas polares** e **coordenadas cartesianas**; No segundo caso, estamos tomando a componente horizontal e vertical de uma reta dentro de um círculo (pense num circulo unitario e uma reta partindo da origem e atingindo um ponto em, digamos, 45 graus). As coordenadas polares, por outro lado, são definidas exatamente pelo comprimento (em relação à origem) e inclinação do segmento de reta.

### Ortogonalidade e linearidade na obtenção de $\alpha$ e $\beta$

Vamos agora estudar a correlação de um sinal genérico x com um sinal conhecido y. Definimos x como
$$
x[n] = \alpha cosf(n) - \beta sen f(n)
\\
cos f(n) = cos(\frac{2\pi f n}{N})
\\
e
\\
sen f(n) = sen(\frac{2\pi f n}{N})
$$
E podemos calcular a correlação com sinais como:
$$
sen g(n) = sen(\frac{2\pi g n}{N})
\\
e
\\
cos g(n) = cos(\frac{2\pi g n}{N})
$$
Antes de partirmos para a corerlação, vamos ressaltar uma propriedade muito importante dela: a  **linearidade**:
$$
(a + b, c) = ac + cb
$$
Como tudo que é linear, também vale que
$$
\gamma(a, b) = (\gamma a, \gamma b)
$$
Assim, podemos calcular a correlação entre nosso sinal x e um sen g ou cos g:
$$
(\alpha cos f(n) - \beta sen f(n), -sen(g)) = -\alpha(cos f(n), sen g(n)) + \beta(sen f(n), sen g(n))
$$
Vale que a correlação entre cosseno e seno é sempre zero, podemos ignorar o primeiro termo da soma. Vamos nos preocupar nos casos em que f == g (do contrario, a correlação é zero):
$$
(x, -sen f) = \beta (sen f, sen f)
\\
\therefore
\\
\beta = D[f] * (x, -sen f)
$$
Onde D[f] é um **termo de normalização**, que é o inverso da norma de sen f (note como a correlação de um sinal com ele mesmo é sua norma).



Repetindo o mesmo para a correlação com o cos g, teriamos:
$$
\alpha = C[f] * (x, cos f)
$$
Onde C também é um termo de normalização, e teríamos C[f] e D[f] satisfazendo C=D=2/N se 0<f<N/2, e C=1/N e D=0 se f=0 ou f=N/2. 



Assim, por meio da correlação, conseguimos extrair do sinal as coordenadas alpha e beta. Com elas, poderíamos reconstruir o sinal original descobrindo a Amplitude e fase inicial.

***

## Transformada real de Fourier

Agora vamos estudar como converter um sinal qualquer em componentes senoidais. A transformada de Fourier faz exatamente isso: ela recebe um sinal em uma base **canonica** (x[0], x[1], x[2], ...) e converte em uma base de **senos e cossenos** : x = (a[1], b[1] , a[2], b[2], ...) onde
$$
a[f] = (x, cos f)\\
b[f] = (x, -sen f)
$$
Essa é a **equação de análise**. Essas correlações não são normalizadas. Como essas correlações não são normalizadas,vale que $\alpha = a[f], \beta = b[f]$. Portanto, como estudamos anteriormente, podemos facilmente converter essas coordenadas em polares, ou seja, obter a Amplitude do sinal e a fase inicial dele:
$$
A[f] = \sqrt{a[f]^2 + b[f]^2}
\\
\phi[f] = arctan(b[f]/a[f])
$$
Assim conseguimos obter a amplitude e a fase de cada componente.



Podemos fazer o caminho inverso pela **equação de síntese**, que é um processo **sem perdas** de obter o sinal original a partir das componentes. Segue a equação:
$$
x[n] =A[0] *  \frac{1}{N} + \frac{2}{N}\sum_{f=1}^{N/2-1}A[f] * cos(\frac{2\pi f n + \phi(f)}{N}) + \frac{1}{N}A[N/2]cos(\pi n)
$$
Esses pesos 1/N e 2/N tem a ver com as correlações especiais quando f = 0 e f = N/2