---
author: Renne Rocha
categories: Programação
tags: C++, ODBC
date: 2007/10/15 14:34:03
permalink: http://rennerocha.com/2007/10/criando-uma-conexao-odbc-utilizando-cpp/
title: Criando uma conexão ODBC utilizando C++
---
Ao escrever um código que efetua uma interação com um sistema de banco de dados, normalmente é necessário incluir trechos de código específicos do banco de dados utilizado. Se você quiser utilizar um banco de dados Sybase, Access ou PostgreSQL, será necessário a escrita de três códigos diferentes.

Utilizando o <a href="http://en.wikipedia.org/wiki/ODBC">ODBC</a> (Open Data Base Connectivy), você fará chamadas a funções da API do ODBC (combinadas com queries SQL). O gerenciador ODBC saberá como executar a função desejada no banco de dados escolhido. É necessário apenas que você tenha instalado no seu computador, um driver ODBC específico do banco de dados que você estará utilizando.

Existem implementações de ODBC para vários sistemas operacionais, porém vamos tratar aqui apenas da implementação da Microsoft (<a href="http://msdn2.microsoft.com/en-us/library/ms710252.aspx">Microsoft Open Database Connectivity (ODBC)</a>).

Os passos básicos para efetuar uma conexão a um base dados, efetuar um query e encerrar essa conexão podem ser vistos no <a href="http://msdn2.microsoft.com/en-us/library/ms714078.aspx">fluxograma</a> abaixo.

![Basic ODBC Application Steps](/img/20071015_odbc.jpg "Basic ODBC Application Steps")

Não vou explicar o funcionamento de cada uma dessas funções (você pode pesquisar uma a uma se desejar). Acredito que um pequeno exemplo de código em C++ possa ser muito mais didático para a utilização rápida.

Neste exemplo, uma conexão com uma fonte de dados ODBC é realizada e o conteúdo de dois campos é buscado e exibido na tela (caso haja algum registro).

<strong>Exemplo 1</strong> - Selecionando campos de uma tabela - Compilado no Visual C++ 6.0

$$code(lang=c++)
#include <windows.h>
#include <stdio.h>
#include <iostream.h>
#include <string.h>
#include <sqlext.h>

int main(int argc, char* argv[])
{
    UCHAR campo1[100];
    UCHAR campo2[100];

    // Query SQL que será executada
    unsigned char szSqlStr[255];
    strcpy((char*)szSqlStr, "SELECT campo1, campo2 FROM tabela WHERE condicao = '2'");

    SDWORD cbCampo1; // Model buffer bytes recieved
    SDWORD cbCampo2; // Model buffer bytes recieved

    SQLRETURN retcode;
    SQLHENV henv;  // Environment handle
    SQLHDBC hdbc;  // Connection handle
    SQLHSTMT hstmt;  // Statement handle

    UCHAR szDSN[SQL_MAX_DSN_LENGTH] = "nome_fonte"; // Data Source Name buffer
    UCHAR* szUID = (unsigned char *) "user_id"; // User ID buffer
    UCHAR* szPasswd = (unsigned char *) "pass"; // Password buffer

    // Alocando manipulador de ambiente
    retcode = SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &henv);

    // Definir atributo de ambiente de versão do ODBC
    retcode = SQLSetEnvAttr(henv, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0); 
 
    // Alocando manipulador de conexão
    retcode = SQLAllocHandle(SQL_HANDLE_DBC, henv, &hdbc); 

    // Conexão com a fonte de dados
    retcode = SQLConnect(hdbc, szDSN, SQL_NTS, szUID, SQL_NTS, szPasswd, SQL_NTS); 

    // Alocando manipulador da query
    retcode = SQLAllocHandle(SQL_HANDLE_STMT, hdbc, &hstmt); 

    // Executa a query
    retcode = SQLExecDirect(hstmt, szSqlStr, SQL_NTS);
    if(retcode == SQL_SUCCESS || retcode == SQL_SUCCESS_WITH_INFO) {
        SQLBindCol (hstmt, 1, SQL_C_CHAR, campo1, sizeof(campo1), &cbCampo1);
        SQLBindCol (hstmt, 2, SQL_C_CHAR, campo2, sizeof(campo2), &cbCampo2);
        retcode = SQLFetch (hstmt);
        if(retcode != SQL_NO_DATA_FOUND) {
            // Se encontrou dados
            cout << "Campo 1: " << campo1 << endl;
            cout << "Campo 2: " << campo2 << endl;
        } else {
            cout << "Nenhum registro encontrado";
        }
    }

    // Libera manipulador da query
    retcode = SQLFreeHandle(SQL_HANDLE_STMT, hstmt);

    // Desconecta da fonte de dados
    retcode = SQLDisconnect(hdbc);

    // Libera manipuladorde conexão
    retcode = SQLFreeHandle(SQL_HANDLE_DBC, hdbc);

    // Libera manipulador de ambiente
    retcode = SQLFreeHandle(SQL_HANDLE_ENV, henv);

    return 0;
}
$$/code