+--------------------------------------------------------------------------------------------------+
| author: Renne Rocha                                                                              |
+--------------------------------------------------------------------------------------------------+
| categories: Python, Django                                                                       |
+--------------------------------------------------------------------------------------------------+
| date: 2010/12/17 18:34:03                                                                        |
+--------------------------------------------------------------------------------------------------+
| permalink: http://rennerocha.com/2010/12/paginacao-simples-no-django-utilizando-generic-views/   |
+--------------------------------------------------------------------------------------------------+
| title: Paginação simples no Django utilizando generic views                                      |
+--------------------------------------------------------------------------------------------------+

As generic views são um recurso muito interessante e útil para facilitar
a execução de tarefas comuns principalmente de CRUDs. Um uso muito comum
para uma delas é quando precisamos exibir uma lista de objetos
retornados em uma pesquisa.

Para realizar essa tarefa simples (e muito comum), temos a view
object\_list.

Supondo que estamos trabalhando em um sistema de gerenciamento de
propostas de seguro e queremos criar uma página listando todos os
corretores cadastrados. Temos então a classe Corretor:

.. math::

   code(lang=python)
   # models.py
   class Corretor(models.Model):
       susep = models.CharField(max_length=6)
       nome = models.CharField(max_length=100)

/code

Então vamos alterar o arquivo de URLs para mapear a URL /corretores/
para utilizar a generic view, passando alguns parâmetros, retornando a
listagem de todos os corretores cadastrados:

$$code(lang=python) # urls.py from django.conf.urls.defaults import \*
from project.seguro.models import Corretor

urlpatterns = patterns('',
url(r'^corretores/\ :math:`', 'django.views.generic.list_detail.object_list',         {'queryset':Corretor.objects.all().order_by('nome')}, name='todos-corretores'), ) `\ $/code

O único parâmetro que é obrigatório ser passado é o queryset, que como o
próprio nome já diz indica a Queryset utilizada para buscar a lista de
dados que serão retornados pela nossa view. O template padrão utilizado
para renderizar esta view é chamado \_list.html, então criamos esse
template:

$$code(lang=ihtml)

.. raw:: html

   <html>
   <body>
     <h1>

Listagem de Corretores

.. raw:: html

   </h1>
    

.. raw:: html

   <ul>
     

{% for corretor in object\_list %}

.. raw:: html

   <li>

{{ corretor.susep }} - {{ corretor.nome }}

.. raw:: html

   </li>
     

{% endfor %}

.. raw:: html

   </ul>
   </body>
   </html>

$$/code

Pronto! Com pouquíssimas linhas de código temos agora a listagem de
todos os corretores do sistema. Mas agora surge um pequeno problema: o
que acontece se eu tiver 500 corretores cadastrados? Teremos uma página
enorme com todos eles. Para organizar isso, podemos paginar esses
resultados.

Fazemos então uma alteração no nosso mapeamento da URL, com um parâmetro
extra (paginate\_by), informando que queremos utilizar a paginação
mostrando 20 registros por página:

$$code(lang=python) # urls.py from django.conf.urls.defaults import \*
from project.seguro.models import Corretor

urlpatterns = patterns('',
url(r'^corretores/\ :math:`', 'django.views.generic.list_detail.object_list',         {'queryset':Corretor.objects.all().order_by('nome'),          'paginate_by':20}, name='todos-corretores'), ) `\ $/code

Agora, se acessarmos /corretores/ o resultado são apenas 20 registros.
Para acessar a página seguinte, podemos acessar /corretores/?page=2 e
assim por diante. Só precisamos agora melhorar o nosso template para
facilitar a navegação entre as páginas.

Esta generic view nos fornece as seguintes variáveis de contexto:

-  object\_list: lista dos objetos retornados pela Queryset informada;
-  is\_paginated: indica se o resultado está paginado ou não;
-  results\_per\_page: número de resultados por página;
-  has\_next: baseado na página atual, informa se existe uma próxima
   página;
-  has\_previous: baseado na página atual, informa se existe uma página
   anterior;
-  page: a página corrente;
-  next: a próxima página;
-  previous: a página anterior;
-  pages: número total de páginas;
-  hits: número total de registros;
-  last\_on\_page: o númeo do resultado do último registro exibido na
   lista de resultados;
-  first\_on\_page: o númeo do resultado do primeiro registro exibido na
   lista de resultados;
-  page\_range: uma lista com os números das páginas

Então podemos deixar nosso template da seguinte maneira:

$$code(lang=html)

.. raw:: html

   <html>
   <body>
     <h1>

Listagem de Corretores

.. raw:: html

   </h1>
     <p>

{{ hits }} corretores encontrados.

.. raw:: html

   </p>
    

{% if is\_paginated %}

.. raw:: html

   <p>

Exibindo corretor {{ first\_on\_page }} ao corretor {{ last\_on\_page }}
de {{ hits }} corretores.

.. raw:: html

   </p>
     

{% endif %}

.. raw:: html

   <ul>
     

{% for corretor in object\_list %}

.. raw:: html

   <li>

{{ corretor.susep }} - {{ corretor.nome }}

.. raw:: html

   </li>
     

{% endfor %}

.. raw:: html

   </ul>
    

{% if is\_paginated %} {% if has\_previous %} anterior \| {% endif %}

::

    {% for pagenumber in page_range %}
      <a href="?page={{ pagenumber }}">{{ pagenumber }}</a> |
    {% endfor %}

    {% if has_next %}
      <a href="?page={{ next }}">próxima</a>
    {% endif %}

.. raw:: html

   </body>
   </html>

$$/code

Para problemas bem simples, quando apenas precisamos exibir um conjunto
de dados, sem termos muitas regras de negócio envolvidas, o uso da
generic view agiliza muito o desenvolvimento, mas se for necessário um
maior controle sobre como a paginação é realizada, sugiro uma leitura
mais detalhada em:

[1] http://docs.djangoproject.com/en/1.2/topics/pagination/

[2] http://code.google.com/p/django-pagination/
