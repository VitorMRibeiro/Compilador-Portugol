%option noyywrap yylineno

%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"TabelaSimbolos.h"
#include"Portugol_Parser.tab.h"

extern void yyerror(const char* s);
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
"**"                    { return EXP; }
"+"                     { return MAIS; }
"-"                     { return SUB; }
">="                    { return MAIOR_IGUAL; }
">"                     { return MAIOR; }
"<"                     { return MENOR; }
"<="                    { return MENOR_IGUAL; }
"="                     { return IGUAL; }
":="                    { return ATRIBUICAO; }
"<>"                    { return DIFERENTE; }
"/"                     { return DIV; }
"*"                     { return MUL; }
"("                     { return ABRE_PARENTESES; }
")"                     { return FECHA_PARENTESES; }
","                     { return VIRGULA; }
";"                     { return PONTO_VIRGULA; }
":"                     { return DOIS_PONTOS;}


[0-9]+                                      { yylval.inteiro = atoi(yytext); return CONSTANTE_INTEIRO; }
[0-9]+\.[0-9]+                              { yylval.real = atof(yytext); return CONSTANTE_REAL; }
\"[^\"\n]*\"                                { 
                                                // TODO nao esquecer de desalocar essa memoria depois.
                                                yylval.literal = malloc(sizeof(char) * (strlen(yytext) + 1));
                                                strcpy(yylval.literal, yytext); 
                                                return CONSTANTE_LITERAL; 
                                            }
\'[^\"\'\n]\'                               { yylval.caractere = yytext[0]; return CONSTANTE_CARACTERE; }
[a-zA-Z][a-zA-Z0-9_]{0,14}                  { 
                                                // TODO nao esquecer de desalocar essa memoria depois.
                                                yylval.nome = malloc(sizeof(char) * (strlen(yytext) + 1));
                                                strcpy(yylval.nome, yytext);
                                                return IDENTIFICADOR;
                                            }
\/\/.*\n                                    { /* ignora comentarios de uma linha */ }
\/\*(([^\/\*])|(\/[^\*])|(\*[^\/]))*\*\/    { /* ignora comentarios multi linha */ }
[ \n\t\r]                                   { /* ignora espaços, tabulações e quebras de linha */ }
.                                           { yyerror("erro lexico, simbolo invalido"); return ERRO; }
<<EOF>>                                      return FIM_ARQUIVO;

%%

