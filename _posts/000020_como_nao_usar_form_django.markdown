---
title: "Como (não) utilizar formulários no Django"
date: 2013/02/15 13:37:00
author: Renne Rocha
categories: Django
tags: django, forms
permalink: http://rennerocha.com/2013/02/como-nao-utilizar-formularios-no-django
---
Existe uma [apresentação](http://www.slideshare.net/pydanny/advanced-django-forms-usage) muito conhecida,
realizada na [DjangoCon 2011](http://pyvideo.org/video/82/djangocon-2011--advanced-django-form-usage)
apresentando diversas práticas para trabalhar com formulários do Django. Muitas dessas dicas são
muito boas e são utilizadas por grande parte da comunidade Django.

O primeiro padrão apresentado tenta simplificar a maneira como construímos e manipulamos
formulários. Eles utilizam como exemplo uma _view_ padrão encontrada na maioria dos projetos:

$$code(lang=python)
def my_view(request):
    if request.method == 'POST':
        form = MyForm(request.POST)
        if form.is_valid():
            do_something()
            return redirect('/success')
    else:
        form = MyForm()
    return render(request, 'template.html', {'form': form})
$$/code

Neste exemplo, temos dois blocos _if_ aninhados e a variável _form_ é instanciada em dois
lugares diferentes. A maneira sugerida para simplificá-lo é a seguinte:

$$code(lang=python)
def my_view(request):
    form = MyForm(request.POST or None)
    if form.is_valid():
        do_something()
        return redirect('/success')
    return render(request, 'template.html', {'form': form})
$$/code

Neste caso, quando submetemos este formulário, o atributo _request.POST_ é uma
instância de _django.http.QueryDict_, avaliado como _True_. Deste modo o formulário
é instanciado com os valores informados pelo usuário preenchidos podendo ser
validado (_[https://docs.djangoproject.com/en/dev/ref/forms/api/#bound-and-unbound-forms](bound)_).

Caso a requisição não seja pelo método POST, este atributo não existe. O
formulário é instanciado com o parâmetro _None_ criando um formulário vazio
(_[https://docs.djangoproject.com/en/dev/ref/forms/api/#bound-and-unbound-forms](unbound)_)
que nunca será válido por não possuir dados.

Aparentemente é uma boa idéia, já que diminuímos a quantidade de linhas de código
melhorando um pouco a legibilidade do código e os pontos onde podemos ter erros.
**Porém, esta solução não funciona em 100% dos casos.**

Uma situação onde não podemos utilizar esse padrão é quando temos um formulário
apenas com campos de múltipla escolha como esse:

$$code(lang=python)
CHOICES=[('beatles','John'),
         ('beatles','Paul'),
         ('beatles','George'),
         ('beatles','Ringo')]

class MyForm(forms.Form):
    my_choices = forms.ChoiceField(choices=CHOICES, required=False, widget=forms.RadioSelect())
$$/code

Renderizando esse formulário temos um conjunto de _radio buttons_. Se não selecionarmos
nenhum deles e submetermos o formulário o _QueryDict_ de _request.POST_ é vazio, sendo
avaliado como _False_ fazendo com que eles seja instanciado com o parâmetro _None_ que nunca
será válido por ser _[https://docs.djangoproject.com/en/dev/ref/forms/api/#bound-and-unbound-forms](unbound)_.
