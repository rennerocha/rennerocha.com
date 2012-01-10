---
author: Renne Rocha
categories: lhc, Python
tags: Python, LHC
date: 2012/01/05 13:37:00
title: Manipulando arquivo INI com Python
---
O formato de arquivos INI é um padrão para armazenar informações de configuração de aplicativos e 
alguns sistemas operacionais (versões antigas do MS-Windows utilizavam esse padrão manter algumas de 
suas configurações). Um arquivo INI é simplesmente um arquivo de texto com uma estrutura bem definida 
composta basicamente por *seções* e *opções*.

Um exemplo de aplicação que utiliza este formato é o **[Trac](http://trac.edgewall.org/ "Trac")**, ferramenta
para controle de mudanças em projetos de software. Cada projeto do **[Trac](http://trac.edgewall.org/ "Trac")** 
criado possui o arquivo *trac.ini* contendo a maioria das configurações necessárias para o seu funcionamento. 
Por ser altamente customizável, é interessante ter a possibilidade de alterar esses valores de 
configuração de uma maneira automática.

### Criando um arquivo de configuração

Em Python, em sua biblioteca padrão, existe o módulo **[ConfigParser](http://docs.python.org/library/configparser.html "ConfigParser")** 
(renomeado para *configparser* no Python 3.0) que, através da classe *ConfigParser* fornece um conjunto de métodos para 
trabalhar com arquivos desse tipo.

Criar um arquivo de configuração é simples. Precisamos de uma instância da classe *ConfigParser*

$$code(lang=python)
import ConfigParser
config = ConfigParser.ConfigParser()
$$/code

Essa instância (*config*), ainda não possui nenhuma informação (um arquivo vazio caso seja armazenada agora), 
então precisamos incluir *seções* e *opções* com valores nela. Vamos incluir duas seções: *section1* e *section2* 
utilizando o método 
**[add_section](http://docs.python.org/library/configparser.html#ConfigParser.RawConfigParser.add_section "add_section")**:

$$code(lang=python)
config.add_section('section1')
config.add_section('section2')
$$/code

Em cada seção adicionada, podemos definir opções com seus respectivos valores utilizando o método
**[set](http://docs.python.org/library/configparser.html#ConfigParser.RawConfigParser.set "set")**. O primeiro 
parâmetro deste método é a seção onde o valor será incluído, o segundo parâmetro é a opção e o terceiro o valor desejado.

$$code(lang=python)
config.set('section1', 'opcao1', 'valor1')
config.set('section1', 'opcao2', 'valor2')
config.set('section2', 'outraopcao', 'valor')
config.set('section2', 'numerico', '123')
$$/code

Após essas operações, teríamos um arquivo de configuração desta maneira:

> [section1]    
> opcao1 = valor1    
> opcao2 = valor2   
>  
> [section2]   
> outraopcao = valor   
> numerico = 123   

### Abrindo um arquivo de configuração já existente

Até agora estamos criando um novo arquivo de configuração, porém normalmente o que queremos fazer é alterar 
as configurações de um arquivo já existente. Se tivermos um arquivo chamado *config.ini*, utilizamos o método 
**[read](http://docs.python.org/library/configparser.html#ConfigParser.RawConfigParser.read "read")** indicando
como argumento, uma lista com o nome dos arquivos que devem ser lidos (nesse caso, apenas um):

$$code(lang=python)
import ConfigParser
config = ConfigParser.ConfigParser()
config.read(['config.ini'])
$$/code

Feito isso, podemos manipular essa instância de *ConfigParser* da mesma maneira como já fizemos anteriormente.

### Lendo seções e valores

Após efetuar a leitura de um arquivo de configuração, queremos ser capazes de obter as informações 
armazenadas nele. Por exemplo, se eu quiser saber todas as seções existentes do arquivo *config.ini* 
que estamos utilizando como exemplo:

$$code(lang=python)
>>> c.sections() # Retorna uma lista com todas as seções existentes
['section1', 'section2']
$$/code

Sabendo o nome da seção, podemos obter todos as suas opções e valores associados:
$$code(lang=python)
>>> # Retorna uma lista de tuplas (nome, valor) para cada opção na seção informada
... c.items('section1')
[('opcao1', 'valor1'), ('opcao2', 'valor2')]
$$/code

Se quisermos o valor de uma opção específica:
$$code(lang=python)
>>> # Retorna o valor da opcao2 na section1
... c.get('section1', 'opcao2')
'valor2'
$$/code

O método **[get](http://docs.python.org/library/configparser.html#ConfigParser.RawConfigParser.get "get")** sempre retorna 
uma string. Caso saibamos com antecedência o tipo do valor que estamos obtendo, podemos usar métodos específicos: 
**[getint](http://docs.python.org/library/configparser.html#ConfigParser.RawConfigParser.getint "getint")**, 
**[getfloat](http://docs.python.org/library/configparser.html#ConfigParser.RawConfigParser.getfloat "getfloat")** e 
**[getboolean](http://docs.python.org/library/configparser.html#ConfigParser.RawConfigParser.getboolean "getboolean")**.

$$code(lang=python)
>>> valor = config.get('section2', 'numerico')
>>> type(valor)
<type 'str'>
>>> valor = config.getint('section2', 'numerico')
>>> type(valor)
<type 'int'>
$$/code

### Editando seções e valores

Como já foi apresentado, os métodos 
**[add_section](http://docs.python.org/library/configparser.html#ConfigParser.RawConfigParser.add_section "add_section")** 
e **[set](http://docs.python.org/library/configparser.html#ConfigParser.RawConfigParser.set "set")** são utilizados para 
adicionar novas seções e definir suas opções e valores respectivamente. 

Outros métodos úteis são o 
**[remove_section](http://docs.python.org/library/configparser.html#ConfigParser.RawConfigParser.remove_section "remove_section")**, 
que exclui uma seção e todas as opções associadas e o **[remove_option](http://docs.python.org/library/configparser.html#ConfigParser.RawConfigParser.remove_option "remove_option")** que exclui uma opção em uma determinada seção.

$$code(lang=python)
>>> # Excluindo uma seção
... config.sections()
['section1', 'section2']
>>> config.remove_section('section2')
True
>>> config.sections()
['section1']
$$/code

$$code(lang=python)
>>> # Excluindo uma opção
... config.items('section2')
[('outraopcao', 'valor'), ('numerico', '123')]
>>> config.remove_option('section2', 'outraopcao')
True
>>> config.items('section2')
[('numerico', '123')]
$$/code

### Armazenando o arquivo 

A instância de ConfigParser é uma representação de um arquivo de configuração. Depois de 
fazer a personalização desejada, é necessário salvá-lo no sistema de arquivos. Isso é feito utilizando o método
**[write](http://docs.python.org/library/configparser.html#ConfigParser.RawConfigParser.write "write")**:

Este código abre um arquivo chamado *config.ini* para escrita, excluindo todo o conteúdo existente 
e armazena a representação do arquivo de configuração:

$$code(lang=python)
with open('config.ini', 'w') as cfgfile:
    config.write(cfgfile)
$$/code

### Exemplo

Aqui temos um exemplo de como criar através de código um arquivo de configuração de uma aplicação 
hipotetica, indicando dados de conexão do banco de dados e repositório: 
**[https://gist.github.com/1590437](https://gist.github.com/1590437 "Exemplo de criação de arquivo INI")**
