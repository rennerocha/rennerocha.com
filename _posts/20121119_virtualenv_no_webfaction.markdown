---
author: Renne Rocha
categories: Python, Webfaction
tags: Webfaction, Python
date: 2012/11/19 19:35:02
permalink: http://rennerocha.com/2012/11/virtualenv-no-webfaction
title: Ambientes Python isolados na sua conta do Webfaction
---
O [Webfaction](http://www.webfaction.com/?affiliate=rennerocha) é um dos serviços de 
hospedagem mais amigáveis para aplicações [Python](http://python.org) que conheço.
Com preços convidativos, um suporte técnico de alta qualidade e grande flexibilidade
na instalação e configuração de diversas ferramentas, é minha primeira escolha para hospedar
minhas aplicações.

Como temos a liberdade de utilizar diferentes versões de frameworks e pacotes, é fundamental 
separá-los de alguma maneira para evitar conflitos. A melhor maneira para fazer isso em projetos
[Python](http://python.org) é utilizar o [virtualenv](http://pypi.python.org/pypi/virtualenv).

Como o próprio nome indica, o [virtualenv](http://pypi.python.org/pypi/virtualenv) cria ambientes 
virtuais isolados de modo que, se você instalar um pacote em um deles, ele não irá afetar nenhum 
outro. Basicamente ele altera o [sys.path](http://docs.python.org/2/library/sys.html#sys.path)
que define os caminhos onde os módulos são buscados pelo interpretador.

Para ajudar no gerenciamento desses ambientes, temos o 
[virtualenvwrapper](http://www.doughellmann.com/projects/virtualenvwrapper/), um conjunto de extensões 
para o [virtualenv](http://pypi.python.org/pypi/virtualenv) que facilita a criação, utilização e exclusão
de ambientes. Iremos instalar as duas ferramentas no ambiente do [Webfaction](http://www.webfaction.com/?affiliate=rennerocha).

#### Definindo a versão padrão do Python ####

Nos servidores do [Webfaction](http://www.webfaction.com/?affiliate=rennerocha), a versão padrão do 
[Python](http://pythong.org) em linha de comando é a 2.6. Para utilizar a versão 2.7 é necessário
criar um _alias_ na sua conta:

* Abra uma [sessão SSH](http://docs.webfaction.com/user-guide/access.html) na sua conta
* Edite o arquivo _$HOME/.bashrc_ e acrescente a seguinte linha no final do arquivo:
$$code(lang=bash, linenums=false)
alias python=python2.7
$$/code
* Recarregue o arquivo com o comando: _source $HOME/.bashrc_
* A partir de agora, todas as sessões SSH usarão essa versão do Python como padrão

#### Instalando ####

Instalar um pacote Python nos servidores do Webfaction é muito fácil. O módulo
[easy_install](http://packages.python.org/distribute/easy_install.html) está instalado
para todos os usuários:

$$code(lang=bash, linenums=false)
easy_install-2.7 pip
pip install virtualenv virtualenvwrapper
$$/code

#### Configurando ####

Para completar a instalação, edite novamente o arquivo _$HOME/.bashrc_ e adicione
as seguintes configurações:

$$code(lang=bash, linenums=false)
# set the workonhome and virtualenvwrapper_python
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2.7
# add the virtualenvwrapper hook
source $HOME/bin/virtualenvwrapper.sh
$$/code

Pronto! Você já tem o necessário para criar ambientes virtuais na sua conta.
