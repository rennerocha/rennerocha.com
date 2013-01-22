---
title: "Criptografia: Cifras de Substituição"
date: 2013/01/21 21:38:00
author: Renne Rocha
categories: Computação
tags: criptografia, cifras
permalink: http://rennerocha.com/2013/01/criptografia--cifras-de-substituicao
---
Uma cifra de substituição é um método de **criptografia** onde unidades de texto são substituídas
por unidades de texto-cifrados seguindo um sistema regular e pré-determinado. Essas unidades de texto
podem ser letras, números, pares de letras, triplas de letras ou uma combinação de todos.
Para recuperar uma mensagem cifrada, o receptor deve apenas fazer a substituição inversa.

####Cifras de Substituição Simples####

Este tipo de cifra faz o mapeamento entre uma letra do alfabeto com outra, definido por alguma regra pré-estabelecida.
Este mapeamento cria um **alfabeto de substituição** que é utilizado tanto para encriptar quanto para desencriptar uma
mensagem. Considerando as 26 letras do alfabeto, é possível gerar 26! (26 fatorial) **alfabetos de substituição**
distintos.

Apesar do número grande de **alfabetos de substituição**, estas cifras são facilmente quebradas
através de [análise de freqüência](http://pt.wikipedia.org/wiki/An%C3%A1lise_de_frequ%C3%AAncia) da ocorrência de
letras em um idioma. Com um conjunto suficientemente grande de mensagens cifradas podemos
relacionar o percentual de ocorrência das letras-cifradas com o percentual das letras no idioma do
texto-cifrado. Com isso um conjunto de combinações mais viáveis pode ser descoberto e avaliado.

####Exemplos de Cifras de Substituição Simples####

Uma das mais conhecidas cifras de substituição simples é a **[Cifra de César](http://en.wikipedia.org/wiki/Caesar_cipher)**
utilizada pelo imperador romano [Julius Caesar](http://en.wikipedia.org/wiki/Julius_Caesar). Nesta cifra um valor de
deslocamento é definido, então cada letra do texto é substituída pela letra do alfabeto referente a esse
deslocamento. Por exemplo, com um deslocamento de **3**, a letra **A** é substituída pela letra **D**,
**B** se torna **E** e assim sucessivamente. As letras do final do alfabeto, são substituídas pelas primeiras: **X** se torna
**A**, **Y** se torna **B** e **Z** se torna **C**.

Uma variação desta cifra é a [ROT13](http://en.wikipedia.org/wiki/ROT13) que é uma **Cifra de César** com deslocamento
13. A vantagem de usar esse valor para o deslocamento é que, para encriptar e para desencriptar uma mensagem, podemos
utilizar o mesmo algoritmo.

Para implementar uma cifra de substituição simples em [Python](http://python.org) podemos utilizar as seguintes funções
do módulo _[string](http://docs.python.org/2/library/string.html#module-string)_ da biblioteca padrão:
_[maketrans](http://docs.python.org/2/library/string.html#string.maketrans)_ para criar uma tabela de substituição
e a função _[translate](http://docs.python.org/2/library/string.html#string.translate)_ para fazer a conversão.

$$code(lang=python)
# Exemplo da Cifra de Cesar
import string

def encrypt(message, shift):
    original = string.ascii_uppercase
    new = original[shift:] + original[:shift]
    conversion_table = string.maketrans(original, new)
    return string.translate(message.upper(), conversion_table)

def decrypt(encrypted_message, shift):
    return encrypt(encrypted_message.upper(), -shift)
$$/code

Outro exemplo de cifra de substituição é a **Cifra de Vigenère** - uma variação da Cifra de César, descrita pela primeira vez em 1553 no livro
[La cifra del Sig. Giovan Battista Bellaso](http://en.wikipedia.org/wiki/Giovan_Battista_Bellaso). É uma cifra
simples de aprender e implementar.

Para encriptar uma mensagem, escolhemos uma palavra que será utilizada
como chave da encriptação. Cada letra desta palavra define um deslocamento
diferente que será usado na Cifra de César.

Por exemplo, se escolhermos a palavra CRIPTO para ser a chave de nossa cifra, temos os seguintes valores de deslocamentos: 3 18 9 20 15.

Queremos encriptar a seguinte frase:

TESTANDO A CIFRA DE VIGENERE

Para cada letra desta frase, usamos a Cifra de César com os deslocamentos
definidos pela palavra-chave ciclicamente:

<pre>
T  E  S  T  A  N  D  O  A  C  I  F  R  A  D  E  V  I  G  E  N  E  R  E
3  18 9  20 15 3  18 9  20 15 3  18 9  20 15 3  18 9  20 15 3  18 9  20
-----------------------------------------------------------------------
V  V  A  I  T  B  F  F  I  R  B  T  T  R  L  T  O  W  I  V  V  T  K  S
</pre>

A maior fraqueza desta cifra é a natureza repetitiva de sua chave. Se descobrimos corretamente o tamanho da letra, então o texto cifrado pode ser 
quebrado por análise de freqüência do mesmo modo que a cifra de César.

Exemplo de implementação:

$$code(lang=python)
import string

def caesar_encrypt(message, shift):
    original = string.ascii_uppercase
    new = original[shift:] + original[:shift]
    conversion_table = string.maketrans(original, new)
    return string.translate(message.upper(), conversion_table)

def encrypt(message, key):
    message_size = len(message)
    key_size = len(key)
    multiplier = (message_size / key_size) + (message_size % key_size)
    shift_values = [ord(letter) - 65 for letter in key * multiplier]
    return ''.join([caesar_encrypt(letter, shift_values[index]) for index, letter in enumerate(message)])

def decrypt(message, key):
    message_size = len(message)
    key_size = len(key)
    multiplier = (message_size / key_size) + (message_size % key_size)
    shift_values = [ord(letter) - 65 for letter in key * multiplier]
    return ''.join([caesar_encrypt(letter, -shift_values[index]) for index, letter in enumerate(message)])
$$/code

