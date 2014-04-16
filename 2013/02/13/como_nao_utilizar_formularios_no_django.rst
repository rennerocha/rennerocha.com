Como (não) utilizar formulários no Django
=========================================

.. author:: default
.. categories:: none
.. tags:: none
.. comments::

Existe uma `apresentação`_ muito conhecida, realizada na `DjangoCon
2011`_ apresentando diversas práticas para trabalhar com formulários do
Django. Muitas dessas dicas são muito boas e são utilizadas por grande
parte da comunidade Django.

O primeiro padrão apresentado tenta simplificar a maneira como
construímos e manipulamos formulários. Eles utilizam como exemplo uma
*view* padrão encontrada na maioria dos projetos:

.. code-block:: python

   def my_view(request):
       if request.method == 'POST':
           form = MyForm(request.POST)
           if form.is_valid():
               do_something()
               return redirect('/success')
       else:
           form = MyForm()
       return render('template.html', {'form': form}, request=request)

Neste exemplo, temos dois blocos *if* aninhados e a variável *form* é
instanciada em dois lugares diferentes. A maneira sugerida para
simplificá-lo é a seguinte:

.. code-block:: python

   def my_view(request):
       form = MyForm(request.POST or None)
       if form.is_valid():
           do_something()
           return redirect('/success')
       return render('template.html', {'form': form}, request=request)

Neste caso, quando submetemos este formulário, o atributo *request.POST*
é uma instância de *django.http.QueryDict*, avaliado como *True*. Deste
modo o formulário é instanciado com os valores informados pelo usuário
preenchidos podendo ser validado (`bound`_).

Aparentemente é uma boa idéia, já que diminuímos a quantidade de linhas 
de código melhorando um pouco a legibilidade do código e reduzindo os
locais onde podemos ter erros. **Porém, esta solução não funciona em 100% 
dos casos.**

Uma situação onde não podemos utilizar esse padrão é quando temos um 
formulário apenas com campos de múltipla escolha como esse:

.. code-block:: python

   CHOICES=[('beatles','John'),
            ('beatles','Paul'),
            ('beatles','George'),
            ('beatles','Ringo')]

   class MyForm(forms.Form):
       my_choices = forms.ChoiceField(choices=CHOICES, 
                                      required=False, 
                                      widget=forms.RadioSelect())

Renderizando esse formulário temos um conjunto de *radio buttons*. Se 
não selecionarmos nenhum deles e submetermos o formulário o *QueryDict*
de *request.POST* é vazio, sendo avaliado como *False* fazendo com que 
ele seja instanciado com o parâmetro *None* que nunca será válido por 
ser `unbound`_.

.. _apresentação: http://www.slideshare.net/pydanny/advanced-django-forms-usage
.. _DjangoCon 2011: http://pyvideo.org/video/82/djangocon-2011--advanced-django-form-usage
.. _bound: https://docs.djangoproject.com/en/dev/ref/forms/api/#bound-and-unbound-forms
.. _unbound: https://docs.djangoproject.com/en/dev/ref/forms/api/#bound-and-unbound-forms
