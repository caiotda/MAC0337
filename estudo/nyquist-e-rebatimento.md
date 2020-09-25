# Teorema de nyquist e rebatimento

***

Nessa seção, vamos estudar os impactos e restrições da **taxa de amostragem** na conversão analógica digital e como isso impacta o conjunto de sinais representáveis. Veremos que, dependendo da taxa de amostragem, pode surgir o erro do **rebatimento**.

### Teorema da amostragem (Shannon - nyquist)

Enunciado: Para representar digitalmente **sem perdas** um sinal analógico de frequência Xhz, é **suficiente** tomar uma taxa de amostragem de pelo menos 2x hz. Mais ainda, para representar todas as componentes senoidais no intervalo [0, x)hz é **necessário** tomar pelo menos uma taxa de amostragem de 2xhz.



Da condição de suficiência vem que, se tomarmos uma taxa de amostragem grande o bastante, conseguiremos representar perfeitamente um sinal analogico e esse sinal pode ser **reconstruído** a partir do digital (por meio da interpolação ideal).

A condição de necessidade mostra que é impossível representarmos um sinal analógico no intervalo [0, x]hz se tomarmos uma taxa de amostragem de menos que X hz.

Intuição: Tome uma senoide de frequência Xhz. Ela precisa de pelo menos duas amostras +1 e -1 para mostrar sua periodicidade. Se tomarmos R = 2x hz, imagine que demos azar e as duas amostras que tomamos são em instantes que a senoide cruzou o zero, assim, geramos duas amostras de valor 0: não é possível interpolar um sinal senoidal disso, e a onda é **rebatida** para um sinal constante igual a 0. Em termos matemáticos:
$$
sen(2\pi (\frac{R}{2})t), \ t = \frac{n}{R}, \ n = 0, 1, 2, ...
\\
sen(2 \pi n) = sen(n\pi) = sen(\pi) = 0
$$
O teorema de nyquist não faz nenhuma garantia para sinais de frequência Xhz e amostrados exatamente com R = 2xHz. É um caso um pouco imprevisível.

Chamamos a frequência R/2 hz de **frequência de nyquist**.

### Reconstruindo um sinal na conversão DA

Se, para toda componente senoidal do nosso sinal analógico, vale que R > 2F, o teorema de nyquist nos diz que isso é suficiente para sermos capazes de reconstruir o sinal analógico a partir do digital.

Um mecanismo para reconstruir o sinal analógico é tomar o sinc(t) de cada amostra:
$$
sinc(t) = \frac{sen(\pi R t)}{\pi R t}
$$
Onde a função sinc(t) é simplesmente sen(x)/x.

Note que sinc(t) = 1 para t ---> 0 e sinc(t) = 0 para t = n/R.

(não entendi muito bem como isso funciona, mas voce basicamente aplica a função em cada amostra e vai somando. Eventualmente você consegue reduzir o erro e chegar em uma aproximação satisfatória do sinal original).



### Notação de amostragem em relação a frequência de nyquist

A satisfação da condição de nyquist normalmente é satisfeita durante a conversão de Sinais analógicos em digitais pela própria placa de som, mas pode ser violada na síntese de sinais. Uma componente senoidal de frequência F produzida artificalmente pode ser classificada como:

* SUPERAMOSTRADA: quando f < R/2. Sua reconstrução na conversão DA será perfeita.
* CRITICAMENTE AMOSTRADO: quando f = R/2. Pode ser representada corretamente ou não, depende da fase inicial.
* SUBAMOSTRADA: quando f > R/2. Ocorrerá o rebatimento/aliasing. O sinal será representado de maneira idêntica a outro sinal de frequência F' = F - kR (já que é impossivel de distinguir as duas, vamos mostrar isso)

Na conversão ADC, o próprio circuito remove todas componentes senoidais que violam a condição de nyquist, assim evitamos o rebatimento e removemos possíves descaracterizações . Essa remoção é chamada de **filtro passa-baixas** com frequencia de corte Fc abaixo de R/2hz. O resultado é um sinal com componentes senoidais que respeitam a condição de nyquist. Dizemos que o sinal foi convertido em um sinal de **banda limitada**.

### Rebatimento, analisando algebricamente

Vamos tomar um sinal cossenoidal subamostrado com frequência g = f + kr:
$$
y[n] = \alpha cos (\frac{2\pi g n}{R} + \phi)
\\
y[n] = \alpha cos (\frac{2\pi (f + kR) n}{R} + \phi)
\\
y[n] = \alpha cos (\frac{2\pi f n}{R} + 2\pi k n + \phi); 2\pi k n \ é \ periodo \ completo
\\
y[n] = \alpha cos (\frac{2\pi f n}{R} + + \phi)
\\
y[n] = x[n]
$$
 assim, o sinal rebatido é indistinguível do sinal x de frequência f. Dizemos que os dois sinais estão a mesma classe de equivalência. Convém-se tomar como representante de uma classe de equivalência o único sinal com frequência f tal que $f \in [\frac{-R}{2}, \frac{R}{2}]$. Assim, podemos descobrir qual será a frequência obtida do sinal analog tomando f - kr, com k = round(f/R).