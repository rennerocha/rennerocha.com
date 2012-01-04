---
author: Renne Rocha
categories: lhc, Python
tags: Python, LHC
date: 2012/01/05 13:37:00
draft: true
title: Manipulando arquivo INI com Python
---
O formato de arquivos INI é um padrão para armazenar informações de configuração de aplicativos e 
alguns sistemas operacionais (o MS-Windows utilizava esse padrão para suas configurações em versões
antigas). Um arquivo INI é simplesmente um arquivo de texto com uma estrutura bem definida composta
basicamente por seções e opções.

Um exemplo de aplicação que utiliza este formato é o <a href="">Trac</a>. Cada projeto do Trac criado 
possui um arquivo trac.ini contendo boa parte das configurações necessárias para o seu funcionamento. 
Por ser altamente customizável, é interessante ter a possibilidade de alterar esses valores de 
configuração de uma maneira automática.

Em Python, em sua biblioteca padrão, existe o módulo ConfigParser (renomeado para configparser no Python 3.0) 
que, através da classe ConfigParser fornece um conjunto de métodos para trabalhar com arquivos desse tipo.





