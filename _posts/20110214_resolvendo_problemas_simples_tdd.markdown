---
author: Renne Rocha
categories: Python, TDD
date: 2011/02/14 15:13:00
permalink: http://rennerocha.com/2011/02/resolvendo-um-problema-simples-usando-tdd/
title: Resolvendo um problema simples usando TDD
---
Freqüentemente, quando estou com um pouco de tempo livre, eu resolvo algum dos problemas 
do Project Euler. Desta vez, eu quis praticar em casa o que tenho feito toda semana nos 
encontros do pessoal do DojoCampinas e resolvi utilizar a técnica de TDD para encontrar 
a solução.

Não escolhi (ainda) um problema complicado, então escolhi o problema 14 que é bem simples de 
resolver. Neste problema, temos a seguinte regra para gerar uma seqüência de números inteiros:

* Se n é par, o próximo número da seqüência é igual a n /2
* Se n é ímpar, o próximo número da seqüência é igual a 3n + 1

Por exemplo, se n = 13, geramos a seguinte seqüência com 10 termos:

> 13 40 20 10 5 16 8 4 2 1

Embora ainda não tenha sido provado matematicamente, sabe-se que para qualquer número inteiro 
positivo fornecido como início da seqüência, ela sempre irá terminar no número 1. Esse é parte 
do problema de Collatz e, caso alguém se interesse e consiga prová-lo, entre em contato com o 
matemático britânico Bryan Thwaites para receber a recompensa de £1,000 pela resolução.

Mas voltando ao problema inicial, devemos encontrar qual o número inteiro, menor que um milhão, 
que produz a seqüência com o maior número de termos.

O primeiro passo, foi definir uma função simples que a partir de um número retorne o próximo número 
da seqüência. Em TDD falam para sempre começar escrevendo um teste, mas eu prefiro escrever uma 
interface simples da minha solução, para que eu realmente teste o meu design e eu obtenha uma falha 
ao rodar o primeiro teste, não um erro de compilação.


$$code(lang=python)
# euler.py
def proximo_numero(numero):
    """ Retorna o próximo número da seqüência """
    pass
$$/code

O teste mais simples que pensei foi, se entrar o número 2, o próximo número é o 1. Então escrevendo 
o teste que com certeza vai falhar:

$$code(lang=python)
# teste_euler.py
import unittest
from euler import proximo_numero
 
class ProximoNumeroSequenciaTestCase(unittest.TestCase):
    def test_deve_retornar_um_se_entrada_dois(self):
        self.assertEqual(proximo_numero(2), 1)
$$/code

Então alteramos o código da função proximo_numero da maneira mais simples para fazer este teste passar.

$$code(lang=python)
# euler.py
def proximo_numero(numero):
    """ Retorna o próximo número da seqüência """
    return 1
$$/code

Qual seria o próximo teste? Eu achei que seria interessante testarmos o que deve ocorrer se a entrada 
for 3.

$$code(lang=python)
# teste_euler.py
class ProximoNumeroSequenciaTestCase(unittest.TestCase):
    def test_deve_retornar_um_se_entrada_dois(self):
        self.assertEqual(proximo_numero(2), 1)
    def test_deve_retornar_dez_se_entrada_tres(self):
        self.assertEqual(proximo_numero(3), 10)
$$/code

Então vamos fazer este teste passar. Repare que comecei a utilizar if’s para solucionar meu problema, 
e isso não é adequado, já que não vamos testar número por número. Mas por enquanto, não podemos ter 
testes falhando, a refatoração é o próximo passo.

$$code(lang=python)
# euler.py
def proximo_numero(numero):
    """ Retorna o próximo número da seqüência """
    if numero == 3:
        return 10
    else:
        return 1
$$/code

Estou “roubando” para fazer com que os testes passem e perdendo um pouco o foco no problema que 
estamos tentando resolver. Isso fica claro ao pensar no próximo teste, que pela lógica dos testes 
anteriores deve ser verificar o retorno se o número 4 for informado.

$$code(lang=python)
# teste_euler.py
class ProximoNumeroSequenciaTestCase(unittest.TestCase):
    def test_deve_retornar_um_se_entrada_dois(self):
        self.assertEqual(proximo_numero(2), 1)
    def test_deve_retornar_dez_se_entrada_tres(self):
        self.assertEqual(proximo_numero(3), 10)
    def test_deve_retornar_dois_se_entrada_quatro(self):
        self.assertEqual(proximo_numero(4), 2)
$$/code

Voltando às regras de definição da seqüência, vemos que as entradas 2 e 4 se enquadram na regra de 
números pares, onde o próximo número deve ser a metade dele. Então escrevemos o código para o teste 
passar e em seguida, podemos refatorar os nossos testes, para que eles fiquem mais claros sobre o 
que estamos testando.

$$code(lang=python)
# euler.py
def proximo_numero(numero):
    """ Retorna o próximo número da seqüência """
    if numero % 2 == 0:
        return numero / 2
    return 10
$$/code

$$code(lang=python)
# teste_euler.py
class ProximoNumeroSequenciaTestCase(unittest.TestCase):
    def test_deve_retornar_dez_se_entrada_tres(self):
        self.assertEqual(proximo_numero(3), 10)
    def test_deve_retornar_metade_se_entrada_par(self):
        self.assertEqual(proximo_numero(2), 1)
        self.assertEqual(proximo_numero(4), 2)
$$/code

Poderiamos testar a entrada 5, mas da mesma forma que as entradas pares, o que queremos testar realmente 
são os resultados para entradas ímpares. Então escrevemos mais um teste.

$$code(lang=python)
# teste_euler.py
class ProximoNumeroSequenciaTestCase(unittest.TestCase):
    def test_deve_retornar_dez_se_entrada_tres(self):
        self.assertEqual(proximo_numero(3), 10)
    def test_deve_retornar_metade_se_entrada_par(self):
        self.assertEqual(proximo_numero(2), 1)
        self.assertEqual(proximo_numero(4), 2)
    def test_deve_retornar_3n_mais_um_se_entrada_impar(self):
        self.assertEqual(proximo_numero(3), 10)
        self.assertEqual(proximo_numero(5), 16)
$$/code

$$code(lang=python)
# euler.py
def proximo_numero(numero):
    """ Retorna o próximo número da seqüência """
    if numero % 2 == 0:
        return numero / 2
    return 3 * numero + 1
$$/code

Podemos testar uma grande quantidade de números pares e ímpares para confirmar a nossa implementação. 
Apesar de já saber que o teste vai funcionar, eu particularmente considero que existem ocasiões em que 
as vezes é bom criar alguns testes a mais. Muitos podem discordar disso  Fazendo isso e refatorando um 
pouquinho, acabamos com os seguintes códigos:

$$code(lang=python)
# teste_euler.py
class ProximoNumeroSequenciaTestCase(unittest.TestCase):
     def test_deve_retornar_metade_se_entrada_par(self):
        # Testando todos os números pares de 2 a 200
        for entrada in xrange(2,202, 2):
            self.assertEqual(proximo_numero(entrada), entrada / 2)
    def test_deve_retornar_3n_mais_um_se_entrada_impar(self):
        # Testando todos os números ímpares de 3 a 201
        for entrada in xrange(3,202, 2):
            self.assertEqual(proximo_numero(entrada), 3 * entrada + 1)
$$/code

$$code(lang=python)
# euler.py
def proximo_numero(numero):
    """ Retorna o próximo número da seqüência """
    return numero / 2 if numero % 2 == 0 else 3 * numero + 1
$$/code

O próximo passo é obter uma seqüência completa a partir de um número inicial. Então vou criar uma nova 
função que me retorne esta seqüência.

$$code(lang=python)
# euler.py
def obter_sequencia(inicio):
    """ Retorna a seqüêmcia """
    pass
$$/code

Escrevendo os testes. Vou colocar todos de uma vez, para que este post não fique tão longo, mas fui 
criando um teste de cada vez, implementando o código, até que todos passassem. No github, é possível 
acompanhar os commits e entender passo-a-passo como foi o desenvolvimento.

$$code(lang=python)
# teste_euler.py
class ObterSequenciaTestCase(unittest.TestCase):
    def teste_obtem_sequencia_a_partir_do_dois(self):
        self.assertEquals(sequencia(2), [2, 1])
    def teste_obtem_sequencia_a_partir_de_tres(self):
        self.assertEquals(sequencia(3), [3, 10, 5, 16, 8, 4, 2, 1])
    def teste_obtem_sequencia_a_partir_de_quatro(self):
        self.assertEquals(sequencia(4), [4, 2, 1])
    def teste_obtem_sequencia_a_partir_de_nove(self):
        self.assertEquals(sequencia(9), [ 9, 28, 14,  7, 22, 11, 34, 17, 52, 26, 13, 40, 20, 10, 5, 16,  8,  4,  2, 1])
$$/code

$$code(lang=python)
# euler.py
def sequencia(inicio):
    """ Retorna a seqüência a partir do número inicial """
    retorno = [inicio]
    proximo = proximo_numero(inicio)
    retorno.append(proximo)
    while proximo != 1:
        proximo = proximo_numero(proximo)
        retorno.append(proximo)
    return retorno
$$/code

Com isso eu consigo obter seqüências a partir de qualquer número inicial. Agora para resolver o 
problema eu preciso de uma maneira de, a partir de várias seqüências eu descobrir qual é a maior. 
Novamente uma nova função, e um conjunto de testes:

$$code(lang=python)
# teste_euler.py
class MaiorSequenciaTestCase(unittest.TestCase):
    def teste_maior_sequencia_ate_tres(self):
        self.assertEquals(maior_sequencia(3), 3)
    def teste_maior_sequencia_ate_quatro(self):
        self.assertEquals(maior_sequencia(4), 3)
    def teste_maior_sequencia_ate_seis(self):
        self.assertEquals(maior_sequencia(6), 6)
$$/code

$$code(lang=python)
# euler.py
def maior_sequencia(limite):
    maior_sequencia = 0
    for valor in xrange(1, limite + 1):
        tamanho_sequencia = len(sequencia(valor))
        if tamanho_sequencia > maior_sequencia:
            valor_maior_sequencia = valor
            maior_sequencia = tamanho_sequencia
    return valor_maior_sequencia
$$/code

Pronto, com esse código e conjunto de testes, já é possível encontrar a solução do problema. 
Um código bem simples vai encontrar a solução:

$$code(lang=python)
# problema14.py
from euler import maior_sequencia
print "Which starting number, under one million, produces the longest chain? %i" % ( maior_sequencia(10**6), )
$$/code

Esta solução não é a mais eficiente, porém não estava preocupado com eficiência do código 
neste momento. Mas com esse conjunto de código podemos continuar o desenvolvimento fazendo 
refatorações até obter uma resposta mais rápida.

O código completo está em: <a href="https://github.com/rennerocha/euler/tree/master/problema_14">https://github.com/rennerocha/euler/tree/master/problema_14</a>
