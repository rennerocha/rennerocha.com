---
author: Renne Rocha
categories: Python, Django
date: 2010/09/22 23:12:03
permalink: http://rennerocha.com/2010/09/gerando-uma-lista-de-ternos-pitagoricos-pythagorean-triplet/
title: Gerando uma lista de Ternos Pitagóricos (Pythagirean Triplet)
---
Hoje, depois de apanhar bastante com o plugin FLOT do jQuery, resolvi entrar no site do Projeto 
Euler para gastar um tempinho resolvendo algum problema e refrescar a cabeça um pouco (pelo menos 
o problema mudou).

Escolhi o problema 9. Neste problema eu preciso encontrar um terno pitagórico que atende um 
determinado padrão. Então para resolver isso fui pesquisar um pouco sobre o que identifica um 
terno pitagórico.

> Da Wikipedia:
> A Pythagorean triple consists of three positive integers a, b, and c, such that a² + b² = c².

O problema quer que eu encontre qual o terno onde a soma dos seus termos (a + b + c) seja igual 
a 1000 (ele diz que só existe um) e retornar então a multiplicação entre os termos desse terno 
(a * b * c). A primeira tentativa é testar todos os números dentro de uma faixa de valores para 
encontrar o terno desejado:

$$code(lang=python)
#!/usr/bin/env python
def is_terno(a, b, c):
    return a**2 + b**2 == c**2
 
def resposta_problema():
    for a in range(1,500): # Vou testar somente os números entre 1 e 500
        for b in range(a+1, 500):
            for c in range(b+1,500):
                if is_terno(a,b,c):
                    if a + b + c == 1000:
                        return a, b, c, a * b * c

print resposta_problema()
$$/code

Só que esta solução por força-bruta é extremamente ineficiente (tanto que rodando ela eu não 
tive paciẽncia de esperar o fim da execução). Pesquisando um pouco, descobri que Euclides, a mais 
de dois mil anos, já havia encontrado uma maneira melhor para gerar números pitagóricos (a dedução 
desta relação pode ser vista 
<a href="http://en.wikipedia.org/wiki/Pythagorean_triple#Geometry_of_Euclid.27s_formula">aqui</a>):

Dados dois número naturais inteiros m e n (com m > n), a tupla (a, b, c) é pitagórica se:
> a = m² – n²
> b = 2mn
> c = m² + n²

Sabendo disso, o código seguinte resolve o problema.

$$code(lang=python)
#!/usr/bin/env python
def resposta_problema():
    for m in range(100):
        for n in range(m):
            a = m**2 - n**2
            b = 2 * m * n
            c = m**2 + n**2
            if a + b + c == 1000:
                return a, b, c, a * b * c
 
print resposta_problema()
$$/code

O código completo das duas soluções está em: <a href="https://github.com/rennerocha/euler/tree/master/problema_9"> https://github.com/rennerocha/euler/tree/master/problema_9</a>


$$/code

O único parâmetro que é obrigatório ser passado é o queryset, que como o próprio nome já diz 
indica a Queryset utilizada para buscar a lista de dados que serão retornados pela nossa view. O 
template padrão utilizado para renderizar esta view é chamado <model>_list.html, então criamos 
esse template:

$$code(lang=ihtml)
<!-- corretor_list.html -->
<html>
<body>
  <h1>Listagem de Corretores</h1>
 
  <ul>
  {% for corretor in object_list %}
    <li><a href="{% url detalhes_corretor corretor.id %}">{{ corretor.susep }} - {{ corretor.nome }}</a></li>
  {% endfor %}
  </ul>
</body>
</html>
$$/code

Pronto! Com pouquíssimas linhas de código temos agora a listagem de todos os corretores do sistema. 
Mas agora surge um pequeno problema: o que acontece se eu tiver 500 corretores cadastrados? Teremos 
uma página enorme com todos eles. Para organizar isso, podemos paginar esses resultados.

Fazemos então uma alteração no nosso mapeamento da URL, com um parâmetro extra (paginate_by), 
informando que queremos utilizar a paginação mostrando 20 registros por página:

$$code(lang=python)
# urls.py
from django.conf.urls.defaults import *
from project.seguro.models import Corretor
 
urlpatterns = patterns('',
    url(r'^corretores/$', 'django.views.generic.list_detail.object_list',
        {'queryset':Corretor.objects.all().order_by('nome'),
         'paginate_by':20}, name='todos-corretores'),
)
$$/code

Agora, se acessarmos /corretores/ o resultado são apenas 20 registros. Para acessar a página seguinte, 
podemos acessar /corretores/?page=2 e assim por diante. Só precisamos agora melhorar o nosso template 
para facilitar a navegação entre as páginas.

Esta generic view nos fornece as seguintes variáveis de contexto:

* object_list: lista dos objetos retornados pela Queryset informada;
* is_paginated: indica se o resultado está paginado ou não;
* results_per_page: número de resultados por página;
* has_next: baseado na página atual, informa se existe uma próxima página;
* has_previous: baseado na página atual, informa se existe uma página anterior;
* page: a página corrente;
* next: a próxima página;
* previous: a página anterior;
* pages: número total de páginas;
* hits: número total de registros;
* last_on_page: o númeo do resultado do último registro exibido na lista de resultados;
* first_on_page: o númeo do resultado do primeiro registro exibido na lista de resultados;
* page_range: uma lista com os números das páginas

Então podemos deixar nosso template da seguinte maneira:

$$code(lang=html)
<!-- corretor_list.html -->
<html>
<body>
  <h1>Listagem de Corretores</h1>
  <p>{{ hits }} corretores encontrados.</p>
 
  {% if is_paginated %}
  <p>Exibindo corretor {{ first_on_page }} ao corretor {{ last_on_page }} de {{ hits }} corretores.</p>
  {% endif %}
 
  <ul>
  {% for corretor in object_list %}
    <li><a href="{% url detalhes_corretor corretor.id %}">{{ corretor.susep }} - {{ corretor.nome }}</a></li>
  {% endfor %}
  </ul>
 
  {% if is_paginated %}
    {% if has_previous %}
      <a href="?page={{ previous }}">anterior</a> |
    {% endif %}
 
    {% for pagenumber in page_range %}
      <a href="?page={{ pagenumber }}">{{ pagenumber }}</a> |
    {% endfor %}
 
    {% if has_next %}
      <a href="?page={{ next }}">próxima</a>
    {% endif %}
</body>
</html>
$$/code

Para problemas bem simples, quando apenas precisamos exibir um conjunto de dados, sem termos 
muitas regras de negócio envolvidas, o uso da generic view agiliza muito o desenvolvimento, 
mas se for necessário um maior controle sobre como a paginação é realizada, sugiro uma leitura mais detalhada em:

[1] http://docs.djangoproject.com/en/1.2/topics/pagination/

[2] http://code.google.com/p/django-pagination/
