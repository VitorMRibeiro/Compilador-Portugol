%{
#include<stdio.h>
#include<string.h>
#include"TabelaSimbolos.h"

void yyerror(char* s);
int yylex();
extern int yylineno;

%}

%union {
    int inteiro;
    char caractere;
    float real;
    const char* literal;
    char nome[16];
}

%token FIM_VARIAVEIS CARACTERE FALSO SE FACA FIM_PARA LITERAIS ALGORITMO LITERAL FIM SENAO FIM_ENQUANTO
%token MATRIZ LOGICOS VARIAVEIS LOGICO OU ENTAO PARA INTEIROS FUNCAO INTEIRO INICIO E FIM_SE
%token DE REAIS RETORNE REAL VERDADEIRO NAO ENQUANTO ATE CARACTERES PASSO 
%token MAIS SUB DIV MUL MAIOR_IGUAL MENOR_IGUAL MAIOR MENOR IGUAL DIFERENTE ATRIBUICAO
%token IDENTIFICADOR CONSTANTE_INTEIRO CONSTANTE_REAL CONSTANTE_LITERAL CONSTANTE_CARACTERE
%token ABRE_PARENTESES FECHA_PARENTESES VIRGULA PONTO_VIRGULA DOIS_PONTOS
%token ERRO FIM_ARQUIVO

%type <real> CONSTANTE_REAL 
%type <inteiro> CONSTANTE_INTEIRO

%%

inicio : declaracao_Algoritmo (bloco_Declaracao_Variaveis)? declaracao_Funcao* EOF;

declaracao_Algoritmo : ALGORITMO IDENTIFICADOR PONTO_VIRGULA;

bloco_Declaracao_Variaveis : VARIAVEIS (declaracao_Variavel PONTO_VIRGULA)+ FIM_VARIAVEIS;

declaracao_Variavel \* tipos primitivos *\
                   : IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS INTEIRO
                   | IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS LITERAL
                   | IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS CARACTERE
                   | IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS REAL
                   | IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS LOGICO; 



%%

int main(int argc, char** argv){
    memset(tabelaSimbolos, 0, sizeof(id*) * SYM_TAB_SIZE); // inicializa tabela de simbolos com NULL.
    yyparse();
    //while(yylex() != FIM_ARQUIVO) {}
    return 0;
}

void yyerror(char* s){
    printf("%s\n", s);
}
