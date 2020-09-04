# Aula 01

 

A aposstila do curso pode ser encontrada no arquivo `icsm.pd` (introdução á computação sonora e musical) 

## Capítulo 1 - Representações de som

## 1.1: Representação de audio digital

## 1.1.1 Som e sinal: Conversões AD/DA

AD: Audio analogico

DA : Áudio digital

**Som** é um fenomêno físico que acontece no ar, é um conceito bem geral. Uma variação de pressão no ar em função do tempo. Para serem percebidos pelos humanos, o som deve estar dentro de um intervalo específico (aproximadamente entre 20hz e 20khz)

**Sinal** é um modelo matemático utilizado para representar a variação deum atributo em função de uma variável.

Um sinal sonoro é **analógico** quando está definido em todos os instantes de tempo em um intervalo da reta real.

Um sinal **digital** está definido em uma lista finita de instantes no tempo. Assim, se estamos interessados em armazenar um som real e processa-lo como sinal digital, deve-se ocorrer uma redução ou em tempo ou em relação à variação da pressão em relação a uma media para conseguirmos captar nessa lista finita.

A transição entre o som (fenômeno físico) para o sinal (modelo matemático) é chamada de **transução**.

Existem também conversões entre tipos de sinais (digital -> analogico DAC, ou analogico -> digital ADC)

### Transdutores

São instrumentos cujo proposito é converter enegergia ou informação de uma forma para outra (por exemplo, DAC ou ADC)

Ex.: Ouvido humano! Converte variações da pressão atmosférica em impulsos eletroquímicos

Ex.: Microfone: converte pressão sonora do ar em sinais elétricos; O auto falante, por sua vez, faz o caminho inverso: transforma sinais elétricos em energia mecânica, que faz vibrações do ar.



### Conversão AD

É a conversão de analógico para digital.

Pega o sinal elétrico (entrada do microfone, por exemplo) e transforma numa representação discreta/digital utilizada pelo computador.  Essa conversão é feita na placa de áudio do computador (olha só, um transdutor). O programa em PD serve como uma interface. A gente lê a placa de vídeo pelo objeto `adc~` do pure data - em geral, o pd objetos com `~` lidam  com ondas - que envia o resultado para o objetio `tabwrite~ ` que escreve os resultados numa tabela 

Detalhe: O mqz usa uma variavel `$0_sinal_adc` para armazenar o resultado do tabwrite. O $0 é equivalen te ao `this`de POO e indica o ambiente atual. O `sinal_adc` simplesmente quer dizer que isso é uma conversão ADC sendo representada

Detalhe2: cada caixa do PD é conectado por uns cabinhos. Eles simbolizam o fluxo de informação. As caixas tem saidas (outlets) e entradas (inlets)



### Conversão DA

Essa conversão também é realizada em áudio (na placa de áudio) e transforma um sinal digital em um sinal elétrico. O áudio é reproduzido pelo `tabplay~` que é a conttapartida do `tabwrite ~`

***

## 1.1.2 Amostragem e quantização

Amostragem: discretização (transformar em quantidades finitas) do **tempo** (eixo x)

Quantização: Discretização da **amplitude** (eixo y).

### Amostragem

A amostragem (SR ou R) é a quantidade de amostras de sinal digital que guardamos para cada segundo. O pd usa uma amostragem de 44100hz (44100 amostragens em um segundo). Cada amostra é tirada a 22 micro segundos (período de amostragem).

### Quantização

Da mesma forma que quantizamos a quantidade de amostras por quantidade de tempo, podemos também limitar o número de valores que uma amostra pode obter em frquência: se o número de bits do nosso sinal digital é de, por exemplo, 2 então o nosso sinal digital pode assumir 2² = 4 valores diferentes. Quanto maior a quantização, mais suave é o sinal. Quanto menor, maior um aspecto de "degrau". 

