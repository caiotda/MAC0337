# Aula 2



***

## 1.1.3 - Sinais elementares

Vamos ver como construir em PD alguns sinais: Ruidos e sinais periodicos (sentidas, dente de serra e forma de onda quadrada)

### Ruídos

Ruído é qualquer sinal indesejado adicionado a informação desejada. Geralmente não possuem altura musical definida. Altura musical é a nossa percepção dentro de um eixo imaginado pelos humanos, que varia entre Grave e agudo. Para ruídos, não faz sentido distinção entre grave e agudo. Esses sinais não possuem periodicidade ou periodicidade aproximada. Daqui em diante no curso,  "Altura" é sinônimo de uma grandeza que mede quão grave ou agudo é um som.

Podem ser caracterizados de acordo com a faixa de frquência que ocupam. Usamos nomenclatura de cores para associalos a sua distribuição de energia no espectro 

* Ruído branco
* Ruído vermelho:
* Ruido rosa
* Ruido cinza

Vamos entrar mais a fundo nessa taxonomia eventualmente.

### Sinais periódicos e senoides

Sinais periódicos são sinais que satisfazem 
$$
x(t) = x(t + \tau)
$$
Para qualquer tau. O menor tau que satisfazer essa propriedade é o **período**. A **Frequência** é a quantidade de períodos por segundo (hz).

NNão existem na natureza pro serem sinais perfeitamennte periódicos. A frequência aproximada de um som periódico está relacionado ao conceito de **altura musical**.

**Sinais senoidais** são definidos por expressões como
$$
x(t) = sen(\omega t + \Phi^0)
$$
Onde omega é a fequencia angular (radianos por segundo) e phi 0 é a fase inicial, medida em radianos (seria a angulação inicial). O período da senoide é
$$
\tau = \frac{2\pi}{\omega}
$$
É o menor tau que satisfaz:
$$
x(t) = x(t + \tau) 
$$
Frequentemente representamos sinais senoidais como
$$
x(t) = sen(2\pi\omega f + \Phi)
$$
Onde f é a frequencia

### Sinal dente de serra

É um sinal linear com quedas abruptas: uma rampa linnear que se repete periodicamente.

### Forma de onda quadrada

Sinnal que alterna entre os extremos +1 e -1 periodicamente, pela frequência especificada. Podemos usar o operados "sinal" para gerar esse sinal quadrado.



## 1.1.4 Processamento em tempo real

Os sinais anteriores foram construidos com um veotr em PD. Sua construção ocorre em momennto diferente da captura e reprodução do sinal. O pd pode implementar um modelo de processamentno de fluxos em tempo real, de forma que os sinais de audio sao capturados, processados e reproduzidos em fluxo continuo e simultaneamente.



No entanto, computadores funcionam a base de interrupções e escalonamentos temporarios de processos. Assim, a fluidez de processamennto de sinais de puredata é alcançado graças a um sistema de segmentação do sinal em **blocos**. Processamos as amostras 1 vez a cada bloco.



(revisar essa parte posteriormente).



### Objetos DSP

O tamannho default dos blocos DSP do pd é de 64 amostras, aproximadamente 1.45ms. Ou seja, a cada 1.45ms todos os objetos dsp recebem vetores de 64 amostras em suas entradas de audios e sáo obrigados a produzir vetores de 64 amostras em suas sa[idas de áudio.

Por padrão, esses objetos terminam com tio.