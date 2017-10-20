%option noyywrap yylineno

%{
#include<stdio.h>
#include"Portugol_Parser.tab.h"
#include"TabelaSimbolos.h"
%}

%%

"fim-variaveis"         { return FIM_VARIAVEIS; }
"caractere"             { return CARACTERE; }
"falso"                 { return FALSO; }
"se"                    { return SE; }
"faca"                  { return FACA; }
"fim-para"              { return FIM_PARA; }
"literais"              { return LITERAIS; }
"algoritmo"             { return ALGORITMO; }
"literal"               { return LITERAL; }
"fim"                   { return FIM; }
"senao"                 { return SENAO; }
"fim-enquanto"          { return FIM_ENQUANTO; }
"matriz"                { return MATRIZ; }
"logicos"               { return LOGICOS; }
"variaveis"             { return VARIAVEIS; }
"logico"                { return LOGICO; }
"ou"                    { return OU; }
"entao"                 { return ENTAO; }
"para"                  { return PARA; }
"inteiros"              { return INTEIROS; }
"funcao"                { return FUNCAO; }
"inteiro"               { return INTEIRO; }
"inicio"                { return INICIO; }
"e"                     { return E; }
"fim-se"                { return FIM_SE; }
"de"                    { return DE; }
"reais"                 { return REAIS; }
"retorne"               { return RETORNE; }
"real"                  { return REAL; }
"verdadeiro"            { return VERDADEIRO; }
"nao"                   { return NAO; }
"enquanto"              { return ENQUANTO; }
"ate"                   { return ATE; }
"caracteres"            { return CARACTERES; }
"passo"                 { return PASSO; }
"+"                     { return MAIS; }
"-"                     { return SUB; }
">="                    { return MAIOR_IGUAL; }
">"                     { return MAIOR; }
"<"                     { return MENOR; }
"<="                    { return MENOR_IGUAL; }
"="                     { return IGUAL; }
"<>"                    { return DIFERENTE; }
"/"                     { return DIV; }
"*"                     { return MUL; }
"("                     { return ABRE_PARENTESES; }
")"                     { return FECHA_PARENTESES; }
","                     { return VIRGULA; }
";"                     { return PONTO_VIRGULA; }


[0-9]+                                      { printf("CONSTANTE INTEIRO\n"); return CONSTANTE_INTEIRO; }
[0-9]+\.[0-9]+                              { printf("CONSTANTE REAL\n"); return CONSTANTE_REAL; }
\"[^\"\n]*\"                                { printf("CONSTANTE LITERAL\n"); return CONSTANTE_LITERAL; }
\'[^\"\'\n]\'                               { printf("CONSTANTE CARACTERE\n"); return CONSTANTE_CARACTERE; }
[a-zA-Z][a-zA-Z0-9_]{0,14}                  { printf("IDENTIFICADOR\n"); return IDENTIFICADOR; }
\\\\.*\n                                    { printf("COMENTARIO UMA LINHA\n"); }
\\\*(([^\\\*])|(\\[^\*])|(\*[^\\]))*\*\\    { printf("COMENTARIO MULTI LINHA\n"); }
[ \n\t\r]                                   { /* ignora espaços, tabulações e quebras de linha */ }
.                                           { printf("erro lexico na linha %d\n", yylineno); return ERRO; }

%%

