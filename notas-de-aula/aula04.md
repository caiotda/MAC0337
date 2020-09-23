# Aula 04

***

## Intervalos musicais e altura musical

Altura musical é um conceito que representa como **percebemos sons de diferentes frequência**, dentro de um intervalo cognitivo (agudo, grave). Possui uma relação com o intervalo de frquências audíveis

A altura possui uma relação **não linear** com a frequência: passos iguais em cada uma dessas grandezas não é equivalente ao outro. Por exemplo, se aumentarmos a frequencia linermente, não iremos perceber um aumento linear na altura musical (na verdade, é logarítmico)

Da mesma forma que nossa percepção de intensidade musical estava relacionada á energia da onda, que é o log da amplitude, a nossa percepção de altura musical está relacionada ao log da frequencia. Vamos dizer que o passo entre duas frequências será dado como a razão entre elas:
$$
R = \frac{F_1}{F_0}
$$
E podemos mapear isso logaritmicamente:
$$
log(R) = log(F_1) - log(F_0)
$$
Note que podemos montar uma **progressão geométrica** entre frequencias, tomando R como a razão.

Um conceito musical comum é tomar R = 2. Chamamos isso de **oitava**, ou seja, é duplicar a frequência.
Sempre que aumentarmos uma frequência por R, vamos notar um aumento na altura musical.

Outras razões comuns:

* R = 1/12: semitom
* R = 3/2: Terça
* R = 5/4: quinta

### Frequência e amplitude revisitados

Apesar de associarmos a intensidade de um som à sua amplitude, um fenômeno curioso ocorre se variarmos a frequência de um sinal, fixando a amplitude: se aumentarmos a frequência, temos a impressão de que o som fica mais intenso, e o contrário para sons com frequência mais baixa (**escala PHON**). Esse fenômeno é bastante abordado no campo da *psico-acústica*.

***

## Teorema de nyquist e rebatimento (aliasing)

Vamos estudar agora limitações e impactos na definição da taxa de amostragem do sinal. Com uma certa taxa de amostragem R fixada, certos sinais analógicos serão **perdidos** na conversão. Assim, a escolha de um R te dá um **conjunto de sinais representáveis**.

O **aliasing** é um fenômenos que ocorre quando tentamos representar um sinal proibido pelo nosso R por meio de **componentes senoidais** (combinar senoides), e isso causa uma **distorção** da representação.

### Teorema da amostragem (nyquist-shennon)

* Para representar um sinal analogico de x hz digitalmente, SEM PERDAS, basta tomar uma taxa de amostragem 2x hz.
  * Assim, no PD usamos uma taxa de amostragem = 44100 hz. Note que não conseguiriamos representar  sem perdas sinais acima de 22050 hz.
* Além disso, para representar sinais de frequência no intervalo [0, X) hz, é **necessário** tomarmos taxa de amostragem 2x hz.

a condição de **suficiência** garante que, se tomarmos uma taxa de amostragem grande o suficiente, conseguiríamos reconstruir, quase que com perfeição, o sinal analógico a partir do sinal digital (**interpolação ideal**).

Já a condição de **necessidade** é fácil de ser verificada com inutição: tente representar uma senoide de período xhz e tome uma taxa de amostragem exatamente igual a 2x. A senoide é descrita por:
$$
sen(\frac{2\pi R}{2t})
$$
Mas t = n/r sempre, então sempre teriamos sen(pi * n), e n = 0, 1, 2,... o que é sempre 0. Claramente, um erro de amostragem. A condição de necessidade vem de pegar, pelo menos, 2 amostras dentro do ciclo da senoide e dar uma ideia de periodicidade. Se amostrarmos menos do que isso, a sneoide some.

Obs.: sinais com frequência f = R/2 tem essa frequência batizada de **frquência de nyquist**



Se amostrarmos sinais acima da frequência de nyquist, torna-se impossivel reconstruir o sinal analógico. Se tornarmos sinais com multiplos da frequencia de nyquist, o sinal simplesmente some.



Usando a frequência de nyquist, podemos classificar um sinal analógico como:

1. Superamostrado: quando F < R/2: são representados corretamente no sinal digitad
2. Criticamente amostrada: quando F = R/2: pode ser corretamente representada ou não, dependendo da fase inicial
3. Sub amostrada: Quando F > R/2, aonde irá ocorrer rebatimento. No rebatimento, a nossa onda analógica é convertida em outra com frequência F' = F - kR, pois as duas ondas são representadas de maneira idêntica, já que - digitalmente - as duas ondas são indiferenciaveis