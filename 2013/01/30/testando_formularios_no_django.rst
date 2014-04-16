Testando formulários no Django
=========================================

.. author:: default
.. categories:: none
.. tags:: none
.. comments::

Uma das primeiras dúvidas de quem está começando a desenvolver
aplicações em Django e quer ter uma boa cobertura de testes é saber que
tipo de testes devem ser escritos.

A `documentação do
Django <https://docs.djangoproject.com/en/dev/topics/testing/>`__ sobre
testes é superficial, apresentando diversas ferramentas que podem ser
utilizadas para escrevermos os nossos testes unitários com exemplos
muito simples que ajudam pouco a saber o que, quando e como testar as
partes da aplicação.

A `biblioteca de manipulação de
formulários <https://docs.djangoproject.com/en/dev/topics/forms/>`__ é
uma das mais utilizadas do framework e os formulários criados possuem
com muita freqüência uma grande quantidade de regras de negócios e
validações que **devem** ser testadas.

Como na maioria das vezes utilizamos o formulário dentro de uma view,
uma abordagem comum de testes é utilizar o `cliente de
testes <https://docs.djangoproject.com/en/dev/topics/testing/overview/#module-django.test.client>`__
do Django e fazer requisições POST na *view* que o utiliza passando um
dicionário com os dados de preenchimento dele.

Por exemplo, temos um formulário que recebe informações de um endereço:

.. code-block:: python

   # forms.py
   class AddressForm(forms.Form):
       street = forms.CharField(max_length=32)
       number = forms.CharField(max_length=7)
       complement = forms.CharField(max_length=10, required=False)
       city = forms.CharField(max_length=50, required=False)

O padrão mais comum de usar esse formulário é através de uma *view* que
recebe os dados via *POST,* verifica se o formulário está válido e o salva
caso esteja válido ou retorna uma lista de erros no caso contrário:

.. code-block:: python

   # views.py
   def add_address(request):
       if request.method == 'POST':
           form = AddressForm(request.POST)
           if form.is_valid():
               address = form.save()
               return HttpResponseRedirect('/success/')
       else:
           form = AddressForm()
       return render_to_response('new_address.html', {'form': form})

Podemos testar esse formulário indiretamente, fazendo requisições à *view*
*add_address* passando como parâmetros *POST* as informações desejadas e
verificando o conteúdo da resposta à requisição.

.. code-block:: python

   # tests.py
   class AddressView(TestCase): 
   
       def test_city_is_required(self):
           self.client.login(username=self.username, password=self.password)

           invalid_data = {'street': 'Baker Street',
                           'number': '123',
                           'complement': ''})
           response = self.client.post('/add_address/', data=invalid_data)

           # Verificamos se existe um formulário no nosso retorno
           self.assertTrue('form' in response.context)

           form = response.context['form']

           # Verificamos se no formulário retornado
           # temos o erro desejado
           self.assertEqual(form.errors['city'],
                            [u"This field is required."])

Porém neste caso não estamos testando realmente o formulário e sim sua
integração junto a *view*. Caso o formulário seja utilizado de outra
maneira (em outra *view* por exemplo), não temos como garantir que ele
continuará funcionando corretamente.

Por exemplo, ao invés de fazer o teste acima passar modificando o
formulário (colocando **required=True** no campo **city** do formulário),
podemos fazer essa validação direto na *view*. O teste passa, mas se
utilizarmos este formulário em outra *view* não teremos essa validação.

.. code-block:: python

   # views.py
   def add address(request):
       if request.method == 'POST':
           form = AddressForm(request.POST)
           if not form.cleaned_data['city']:
               form.errors['city'] = ['This field is required.', ]
           else:
               if form.is_valid():
                   address = form.save()
                   return HttpResponseRedirect('/success/')
       else:
           form = AddressForm()
       return render_to_response('new_address.html', {'form': form})

**Sim, eu sei que essa é uma maneira pouco usual de resolver este
problema. O ponto que quero levantar é que dependendo do que estamos
testando, o código que faz o teste passar não precisa necessariamente
estar dentro da classe de formulário.**

Porém, como o formulário é uma classe como qualquer outra, podemos
testá-la diretamente instanciando-a, preenchendo seus campos e chamando
seus métodos de validação e de armazenamento diretamente, verificando
então sua saída.

.. code-block:: python

   # tests\forms.py
   class AddressFormTestCase(TestCase):

       def test_city_is_required(self):
           invalid_form = AddressForm(
               data={'street': 'Baker Street', 
                     'number': '221B', 'complement': ''})
            self.assertFalse(invalid_form.is_valid())
            self.assertEqual(invalid\_form.errors['city'], [u"This field is required."])

            valid_form = AddressForm(data={'street': 'Baker Street',
                                           'number': '221B',
                                           'complement': '',
                                           'city': 'London'})
            self.assertTrue(valid_form.is_valid())

Fazendo este teste passar:

.. code-block:: python

   # forms.py
   class AddressForm(forms.Form):
       street = forms.CharField(max_length=32)
       number = forms.CharField(max_length=7)
       complement = forms.CharField(max_length=10, required=False)
       city = forms.CharField(max_length=50, required=True)

Como eu estou garantindo que o comportamento do formulário está correto,
quando eu for testar alguma *view* que o utilize, eu não preciso de muitos
testes. Na *view* de exemplo, eu preciso fazer basicamente testes para
essas condições:

* Testar a renderização do formulário vazio
* Testar a submissão de um formulário preenchido com dados válidos
* Testar a submissão de um formulário preenchido com dados inválidos

Assim consigo isolar ainda mais meus testes facilitando a reutilização
de partes da minha aplicação.
