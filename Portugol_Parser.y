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

inicio : declaracao_Algoritmo (bloco_Declaracao_Variaveis)? declaracao_Funcao* INICIO algoritmo FIM EOF;

declaracao_Algoritmo : ALGORITMO IDENTIFICADOR PONTO_VIRGULA;

bloco_Declaracao_Variaveis : VARIAVEIS declaracao_Variaveis FIM_VARIAVEIS;

declaracao_Variaveis 
                   : IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS INTEIRO    
                   | IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS LITERAL
                   | IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS CARACTERE
                   | IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS REAL
                   | IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS LOGICO
                   
                   | declaracao_Variaveis IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS INTEIRO    
                   | declaracao_Variaveis IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS LITERAL
                   | declaracao_Variaveis IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS CARACTERE
                   | declaracao_Variaveis IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS REAL
                   | declaracao_Variaveis IDENTIFICADOR ( "," IDENTIFICADOR)* DOIS_PONTOS LOGICO

definicao_Funcao : declaracao_Funcao bloco_Declaracao_Variaveis INICIO corpo_Funcao FIM

declaracao_Funcao: FUNCAO IDENTIFICADOR ABRE_PARENTESES (|parametro|parametro (VIRGULA parametro)*) FECHA_PARENTESES DOIS_PONTOS INTEIRO
                 | FUNCAO IDENTIFICADOR ABRE_PARENTESES (|parametro|parametro (VIRGULA parametro)*) FECHA_PARENTESES DOIS_PONTOS REAL
                 | FUNCAO IDENTIFICADOR ABRE_PARENTESES (|parametro|parametro (VIRGULA parametro)*) FECHA_PARENTESES DOIS_PONTOS LITERAL
                 | FUNCAO IDENTIFICADOR ABRE_PARENTESES (|parametro|parametro (VIRGULA parametro)*) FECHA_PARENTESES DOIS_PONTOS LOGICO
                 | FUNCAO IDENTIFICADOR ABRE_PARENTESES (|parametro|parametro (VIRGULA parametro)*) FECHA_PARENTESES DOIS_PONTOS CARACTERE;

parametros : IDENTIFICADOR DOIS_PONTOS INTEIRO 
           | IDENTIFICADOR DOIS_PONTOS REAL
           | IDENTIFICADOR DOIS_PONTOS CARACTERE
           | IDENTIFICADOR DOIS_PONTOS LITERAL
           | IDENTIFICADOR DOIS_PONTOS LOGICO 

algoritmo : "corpo algoritmo";

corpo_Funcao : "corpo funcao";


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
