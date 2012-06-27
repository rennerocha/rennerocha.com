---
author: Renne Rocha
categories: Programa��o
tags: C++, ODBC
date: 2007/10/15 14:34:03
permalink: http://rennerocha.com/2007/10/criando-uma-conexao-odbc-utilizando-cpp/
title: Criando uma conex�o ODBC utilizando C++
---
Ao escrever um c�digo que efetua uma intera��o com um sistema de banco de dados, normalmente � necess�rio incluir trechos de c�digo espec�ficos do banco de dados utilizado. Se voc� quiser utilizar um banco de dados Sybase, Access ou PostgreSQL, ser� necess�rio a escrita de tr�s c�digos diferentes.

Utilizando o <a href="http://en.wikipedia.org/wiki/ODBC">ODBC</a> (Open Data Base Connectivy), voc� far� chamadas a fun��es da API do ODBC (combinadas com queries SQL). O gerenciador ODBC saber� como executar a fun��o desejada no banco de dados escolhido. � necess�rio apenas que voc� tenha instalado no seu computador, um driver ODBC espec�fico do banco de dados que voc� estar� utilizando.

Existem implementa��es de ODBC para v�rios sistemas operacionais, por�m vamos tratar aqui apenas da implementa��o da Microsoft (<a href="http://msdn2.microsoft.com/en-us/library/ms710252.aspx">Microsoft Open Database Connectivity (ODBC)</a>).

Os passos b�sicos para efetuar uma conex�o a um base dados, efetuar um query e encerrar essa conex�o podem ser vistos no <a href="http://msdn2.microsoft.com/en-us/library/ms714078.aspx">fluxograma</a> abaixo.

![Basic ODBC Application Steps](/img/20071015_odbc.jpg "Basic ODBC Application Steps")

N�o vou explicar o funcionamento de cada uma dessas fun��es (voc� pode pesquisar uma a uma se desejar). Acredito que um pequeno exemplo de c�digo em C++ possa ser muito mais did�tico para a utiliza��o r�pida.

Neste exemplo, uma conex�o com uma fonte de dados ODBC � realizada e o conte�do de dois campos � buscado e exibido na tela (caso haja algum registro).

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

    // Query SQL que ser� executada
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

    // Definir atributo de ambiente de vers�o do ODBC
    retcode = SQLSetEnvAttr(henv, SQL_ATTR_ODBC_VERSION, (void*)SQL_OV_ODBC3, 0); 
 
    // Alocando manipulador de conex�o
    retcode = SQLAllocHandle(SQL_HANDLE_DBC, henv, &hdbc); 

    // Conex�o com a fonte de dados
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

    // Libera manipuladorde conex�o
    retcode = SQLFreeHandle(SQL_HANDLE_DBC, hdbc);

    // Libera manipulador de ambiente
    retcode = SQLFreeHandle(SQL_HANDLE_ENV, henv);

    return 0;
}
$$/code