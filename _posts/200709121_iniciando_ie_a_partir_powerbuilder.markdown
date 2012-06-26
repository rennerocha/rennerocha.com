---
author: Renne Rocha
categories: PowerBuilder
date: 2007/09/21 18:34:03
permalink: http://rennerocha.com/2007/09/iniciando-internet-explorer-a-partir-do-powerbuilder/
title: Iniciando o Internet Explorer a partir do PowerBuilder
---
Esta semana tive que iniciar um projeto em que a principal funcionalidade seria executar a partir de um botão em uma window o Internet Explorer na máquina do cliente, abrindo uma determinada URL. Pensei em usar inicialmente a função Run(), porém uma das limitações do projeto era que a janela do navegador não poderia ter nenhuma barra de ferramentas disponível (endereço, status, favoritos, etc)

Como não é possível iniciar o IE em linha de comando com parâmetros para ocultar essas barras de ferramentas tive que procurar outra solução. Pesquisando dentro da empresa, me sugeriram utilizar um objeto OLE para fazer essa tarefa.

Pesquisando no site do MSDN, descobri o objeto <a href="http://msdn2.microsoft.com/en-us/library/aa752084.aspx">InternetExplorer</a> que permite trabalhar com uma instância do IE. Você pode configurar diversas propriedades desse objeto (como exibição das barras de ferramentas, tamanho da janela, etc). Mais informações sobre este objeto podem ser encontradas <a href="http://msdn2.microsoft.com/en-us/library/aa752084.aspx">aqui</a>.

Bom, no final fiz o seguinte código (utilizei o PowerBuilder 7) dentro do evento clicked() de um botão:

$$code(lang=python)
OLEObject uo_ie
uo_ie = CREATE OLEObject
Integer ii_handleoleobject = -999

ii_handleoleobject = uo_ie.ConnectToNewObject("InternetExplorer.Application")
IF ii_handleoleobject < 0 THEN
   DESTROY uo_ie
   MessageBox('Erro','Não foi ´possível criar o objeto OLE')
ELSE
   uo_ie.AddressBar = FALSE
   uo_ie.MenuBar = FALSE
   uo_ie.Resizable = FALSE
   uo_ie.StatusBar = FALSE
   uo_ie.ToolBar = FALSE
   uo_ie.Visible = TRUE
   uo_ie.Left = 200
   uo_ie.Top = 200
   uo_ie.Height = 500
   uo_ie.Width = 500
   uo_ie.Navigate(is_urlchamada)
   SetForegroundWindow(uo_ie.HWND)
END IF
$$/code

Declarando uma função externa (para que a janela recém-criada fique ativada):

$$code(lang=python)
FUNCTION boolean SetForegroundWindow( long hWnd ) LIBRARY "USER32"
$$/code
