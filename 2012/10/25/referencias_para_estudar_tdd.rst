+-------------------------------------------------------------------------+
| author: Renne Rocha                                                     |
+-------------------------------------------------------------------------+
| categories: TDD                                                         |
+-------------------------------------------------------------------------+
| tags: TDD                                                               |
+-------------------------------------------------------------------------+
| date: 2012/10/25 21:51:02                                               |
+-------------------------------------------------------------------------+
| permalink: http://rennerocha.com/2012/10/referencias-para-estudar-tdd   |
+-------------------------------------------------------------------------+
| title: Referências para estudar TDD                                     |
+-------------------------------------------------------------------------+

*Test-Driven Development* (TDD) é uma técnica para desenvolvimento de
software que define um processo simples que repetido auxilia o
desenvolvedor fornecendo um *feedback* rápido de decisões de *design* no
código, encorajando soluções simples e, por fazer com que praticamente
todo o código esteja coberto por testes, permite que o desenvolvedor
tenha confiança para realizar mudanças no código pois é mais difícil
alterar uma parte do sistema sem ter um retorno rápido se o trecho de
código alterado tem impacto em outras partes do sistema.

O ciclo do TDD é muito fácil de ser ensinado. Temos apenas um pequeno
conjunto de passos:

1. Adicione um teste simples de uma pequena parte da funcionalidade que
   você quer desenvolver. Este teste irá falhar, pois ainda a
   funcionalidade não foi implementada.
2. Escrever o código mais simples possível que faça este teste passar (e
   não faça nenhum teste anterior falhar).
3. Refatorar o código resultante (código de produção e código de teste).
4. Reiniciar o ciclo com um novo teste.

.. figure:: /media/img/tdd_cycle.jpg
   :alt: Fluxograma TDD

   Fluxograma TDD
Apesar de parecer muito simples, é necessário muito cuidado e
experiência para saber quais testes escrever, o que significa escrever o
código mais simples possível (simples é diferente de mal-feito) e
principalmente não esquecer de fazer o passo de refatoração.

Para realmente aprender TDD é necessário muito estudo com a leitura de
livros, participação em Coding Dojos e principalmente escrever o máximo
de código possível. A seguir eu listo alguns livros e sites que podem
ser usados como referência para quem está começando ou quer aprofundar
mais o estudo desta técnica.

Livros
^^^^^^

**`Test Driven Development: By
Example <http://www.amazon.com/Test-Driven-Development-Addison-Wesley-Signature/dp/0321146530/>`__**

*Autor*: Kent Beck

Principal referência para quem quer começar a trabalhar com TDD. O livro
é dividido em três partes. Nas duas primeiras dois projetos são
desenvolvidos ilustrando várias técnicas que podem ser facilmente usadas
para melhorar a qualidade do projeto do seu código. Na terceira parte,
padrões de organização e definição de testes e refatoração de código
utilizados nas primeiras partes do livro são compilados servindo como
uma ótima referência para leitura posterior.

**`Growing Object-Oriented Software, Guided by
Tests <http://www.amazon.com/dp/0321503627/>`__**

*Autores*: Steve Freeman, Nat Pryce

Considerado o livro-texto da escola londrina de TDD (a escola clássica é
descrita no livro do Kent Beck). Os autores descrevem o processo que
eles utilizam, os princípios que eles se guiam e algumas ferramentas
utilizadas para fazer com que os testes guiem a estrutura do código
orientado a objetos, e com o uso de objetos Mock descobrir e descrever
relações e interações entre esses objetos. Para saber mais sobre a
diferença entre a escola Londrina e a escola Clássica de TDD, `leia este
artigo <http://codemanship.co.uk/parlezuml/blog/?postid=987>`__.

**`Test-Driven Development: Teste e Design no Mundo
Real <https://casadocodigo.refersion.com/l/847.1482>`__**

*Autor*: Mauricio Aniche

O mercado brasileiro tem poucas opções de material técnico de qualidade
em português mas a editora **`A Casa do
Código <http://www.casadocodigo.com.br/>`__** entrou no mercado
recentemente com muitos títulos interessantes, entre eles esse livro
escrito por um dos profissionais que é referência em TDD no país (este
foi o tema de sua tese de mestrado na USP). Ainda não li o livro, mas já
participei de um Workshop com o autor e acompanho o seu blog. Conhecendo
o seu trabalho, fico a vontade de indicar este livro.

**`Lean-Agile Acceptance Test-Driven Development: Better Software
Through
Collaboration <http://www.amazon.com/Lean-Agile-Acceptance-Test-Driven-Development-Collaboration/dp/0321714083/>`__**

*Autor*: Ken Pugh

Este livro apresenta as idéias de ATDD (Acceptance Test-Driven
Development), que incentiva a colaboração de toda a equipe do projeto
(clientes, desenvolvedores e testadores) na definição de critérios
claros de aceitação dos requisitos de um sistema. Apesar de não tratar
de técnicas de desenvolvimento de código, é uma abordagem eficiente de
definir o que precisa ser desenvolvido facilitando a utilização do TDD
melhorando significativamente a qualidade do software e a produtividade
dos desenvolvedores.

**`Refactoring: Improving the Design of Existing
Code <http://www.amazon.com/Refactoring-Improving-Design-Existing-Code/dp/0201485672/>`__**

*Autores*: Martin Fowler, Kent Beck, John Brant, William Opdyke, Don
Robert

O terceiro passo do TDD é a refatoração, porém ele é freqüentemente
esquecido e negligenciado. A ênfase dos programadores fica sendo
escrever testes falhando, corrigindo-os o mais rapidamente possível para
continuar escrevendo novos testes. Mas a **refatoração** é uma parte
fundamental do processo. Este livro apresenta uma discussão dos
princípios de refatoração com vários exemplos de como utilizá-los.

Na Internet
^^^^^^^^^^^

**`Refactoring <http://sourcemaking.com/refactoring>`__** Uma referência
com dezenas de exemplos de como utilizar técnicas de refatoração de
código. Deve estar na lista de favoritos de qualquer desenvolvedor.

**`Blog do Mauricio Aniche <http://www.aniche.com.br/tag/tdd/>`__**
Alguns artigos sobre TDD escritos por um dos principais pesquisadores de
TDD do Brasil.

**`Top 100 Software Testing
Blogs <http://www.testingminded.com/2010/04/top-100-software-testing-blogs.html/>`__**
Uma lista com links para 100 blogs sobre teste de software.

**`Clean Coders <http://www.cleancoders.com/>`__** Uma série de vídeos
feitos por Robert Martin (mais conhecido como *Uncle Bob*) sobre vários
assuntos fundamentais para quem quer programar melhor.
