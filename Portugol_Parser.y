%{
#include<stdio.h>
#include<string.h>
#include"TabelaSimbolos.h"
%}

%token FIM_VARIAVEIS CARACTERE FALSO SE FACA FIM_PARA LITERAIS ALGORITMO LITERAL FIM SENAO FIM_ENQUANTO
%token MATRIZ LOGICOS VARIAVEIS LOGICO OU ENTAO PARA INTEIROS FUNCAO INTEIRO INICIO E FIM_SE
%token DE REAIS RETORNE REAL VERDADEIRO NAO ENQUANTO ATE CARACTERES PASSO 
%token MAIS SUB DIV MUL MAIOR_IGUAL MENOR_IGUAL MAIOR MENOR IGUAL DIFERENTE
%token IDENTIFICADOR CONSTANTE_INTEIRO CONSTANTE_REAL CONSTANTE_LITERAL CONSTANTE_CARACTERE
%token ABRE_PARENTESES FECHA_PARENTESES VIRGULA PONTO_VIRGULA
%token ERRO

%%

regraInicial: ;

%%

int main(int argc, char** argv){
    //yyparse();
    memset(tabelaSimbolos, 0, sizeof(var*) * SYM_TAB_SIZE); // inicializa tabela de simbolos com NULL.
    while(yylex() != ERRO) {}
    return 0;
}

yyerror(char* s){
    printf("%s\n", s);
}
