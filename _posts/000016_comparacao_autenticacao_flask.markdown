---
title: "Três opções para autenticação de usuários em Flask"
date: 2012/12/01 13:37:00
author: Renne Rocha
categories: Flask
tags: flask, autenticação
permalink: http://rennerocha.com/2012/12/tres-opcoes-autenticacao-usuarios-flask
draft: True
---
Para quem quer desenvolver aplicações web em Python mas não quer utilizar um 
framework com _[baterias incluídas](http://docs.python.org/2/tutorial/stdlib.html#batteries-included)_
como o [Django](https://www.djangoproject.com/), existem diversas opções de micro-frameworks que, 
apesar do *micro* no nome podem atender qualquer tipo de projeto.

O [Flask](flask.pocoo.org) é um dos micro-frameworks mais utilizado. Seu objetivo é fornecer apenas as 
funcionalidades fundamentais para uma aplicação web funcionar, porém ser muito fácil de se extender.
Você pode decidir como armazenar os seus dados, qual motor de _templates_ utilizar, 
como estruturar sua aplicação. Você toma todas as decisões.

Uma das funcionalidades que não é incluída por padrão, é a autenticação de usuários. Ao invés
de ser obrigado a utilizar um determinado esquema de autenticação 
([como no Django](https://docs.djangoproject.com/en/dev/topics/auth/)),
você é livre para definir como irá armazenar as informações dos usuários, os modos de autenticação,
as integrações com outros sistemas (como o [OAuth](http://oauth.net/) e [OpenID](http://openid.net/)).

Felizmente existem várias extensões já desenvolvidas para quem não quer desenvolver a sua própria
e irei nos próximos _posts_ analisar três deles:

* flask-login - http://pypi.python.org/pypi/Flask-Login
* flask-auth - http://pypi.python.org/pypi/Flask-Auth
* flask-security - http://flask-security.readthedocs.org/en/latest/

