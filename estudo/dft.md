## Transformada discreta de Fourier (DFT)

Anteriormente, vimos a transformada real de fourier, que parte de um conjunto real de valores e transforma isso, no nosso caso, em uma combinação de senos e cossenos. Essencialmente, é uma mudança de base de canonica para uma base de senos e cossenos. Isso é uma maneira de passarmos de uma representação temporal de um sinal para uma representação discreta.



Vamos ver agora a DFT que é mais genérica: ela toma um vetor de valores real ou não e transforma numa **exponencial complexa**. Vamos entender que usamos exponenciais complexas como representação porque nessa formalização ja vem imbutida a idéia de combinação de senos e cossenos (cumprindo o nosso objetivo de decompor sinais complexos) mas também possui um conceito interessante de rotação. O conceito central da DFT é tomar um vetor de valores em:
$$
exp\_f(n) = e^{i2\pi f *n/N} = cos(\frac{2\pi f * n}{N}) + i * sen(\frac{2\pi f * n}{N}) \ (1)
$$
A igualdade na direita é chamada de **fórmula de Euler**.



Note ainda, que essa represerntação complexa mapeia os valoers x = cos($\frac{2\pi f * n}{N}$) e y = sen($\frac{2\pi f * n}{N}$) no plano complexo, mais do que isso. essa coordenada está restrita à um circulo unitario (note que x^2 + y^2 = 1, pelo teorema fundamental da trigonometria). Assim, estamos representando um sinal num circulo unitario e esse ponto em questão completa f voltas em um bloco de N amostras (já que a frequencia desse sinal é f ciclos em N amostras).

### Frequencias negativas

Ainda no tópico de rotações, vamos tomar um momento e falar de frequencias negativas e pensar um pouco sobre a geometria analitica das coordenadas imaginarias. A componente cossenoidal controla o deslocamento horizontal de um ponto no plano complexo. O seno controla o deslocamento vertical. Tome:
$$
\phi = \frac{2\pi f * n}{N}
$$
O argumento das funções trigonométricas. Se tomassemos uma frequencia negativa, teriamos:
$$
exp = cos(-\phi) + i sen(-\phi) \ (2)
$$
Como o cosseno é uma função **par** e o seno é uma função **impar**, isso equivale a:
$$
cos(-\phi) + i sen(-\phi) = cos(\phi) - i sen(\phi)
$$
Ou seja, mantemos o deslocamento horizontal, mas invertemos o deslocamento vertical. Isso equivale a **inverter o sentido da rotação**.

Então se somarmos (1) com (2), teriamos duas relações interessantes:
$$
cos\_f = \frac{exp\_f + exp\_-f}{2}
\\
sen\_f = \frac{exp\_f - exp\_-f}{2i}
$$
Assim podemos definir as componentes cossenoidais e senoidais como combinações lineares de exponenciais complexas. Podemos aplicar isso em sinais de fase inicial generica, inclusive:
$$
Acos(\phi + \phi_0)  = A\frac{1}{2}(e^{i * \phi + \phi_0} + e^{-i*\phi + \phi_0})
\\
\therefore 
\\
Acos(\phi + \phi_0)  = Ae^{\phi_0}\frac{1}{2}(e^{i*\phi} + e^{-i*\phi})
$$
Onde $\phi_0$ é a fase inicial generica do sinal

### Combinando exponenciais complexas para desenhar um sinal qualquer

Aqui vem, na minha opinião, a verdadeira beleza da transformada discreta de fourier: veremos, a seguir, como representar um sinal qualquer como combinações lineares de exponenciais complexas. 

Isso quer dizer que um sinal x pode ser descrito como
$$
x = exp\_f + 0.33 * exp\_3f + 0.2 * exp\_5f...
$$
Lembre-se, estamos falando de sinais complexos. Isso quer dizer que estamos falando de pontos descrevendo movimentos circulares no plano complexo. Então estamos combinando circunferencias, cada uma com sua frequencia (f, 3f, 5f...) e cada uma com seu raio de rotação (1, 0.33, 0.2 etc). Isso implica, intutitivamente, num sistema de **circunferencias encaixadas como engrenagens** que, ao girarem, **PROJETAM** o desenho do sinal original. Pense nessas engrenagens encaixadas girando, agora imagine que, na ponta da menor circunferencia, colocamos um lapis. Esse lapis vai desenhar exatamente o sinal original!

### Analise e sintese na DFT

Agora é muito parecido com  RFT. Vamos montar os coeficientes da DFT correlacionando os valores de um sinal X = (X[0], X[1], X[2], ... X[N-1]) com exponenciais complexas de frequencias f = 0, 1, ... N-1 (uma diferença aqui com a RFT: nela, usavamos frequencias ate f = n/2 devido a rebatimento, mas como lidamos com frequencias negativas, devemos considerar todas frequencias). Assim, se aplicarmos o produto interno:
$$
Y[f] = (x, exp\_f) = (x, cos\_f) + i * (x, -sen\_f)
\\
= a[f] + ib[f]
$$
Note que teve uma mudança de sinal ali. Isso acontece pela definição de produto cartesiano com valores complexos. Chamamso essa equação de **analise** ou DFT.

A **equação de síntese** (ou IDFT - Transformada discreta de fourier inversa ) simplesmente combina linearmente os coeficientes com as exponenciais complexas: 
$$
x[n] = \frac{1}{N}\sum_{f=0}^{N-1}x[f]*exp\_f[n]
\\
\therefore
\\
x[n] = \frac{1}{N}\sum_{f=0}^{N-1}x[f]*(cos\_f[n] + i * sen\_f[n])
$$
Assim, conseguimos montar uma representação **espectral** Y para qualquer sinal de entrada e reverter isso em uma representação **temporal** usando IDFT. A construção e reconstrução é perfeita.

Obs.: Se estamos tratando da DFT de sinais reia,s então vale a **simetria conjugada** da representação espectarl do sinal. Isto é: a[-f] = a[f] e b[-f] = b[f], então vale que Y[f] = Y[-f]; Assim, a metade alta do espectro (f > N/2) rebatem;  Então por isso que, ao trabalharmos com sinais reais, vemos frequencias até f = N/2.