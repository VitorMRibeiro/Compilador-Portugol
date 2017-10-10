%{
#include<stdio.h>
%}

%token FIM_VARIAVEIS CARACTERE FALSO SE FACA FIM_PARA LITERAIS ALGORITMO LITERAL FIM SENAO FIM_ENQUANTO
%token MATRIZ LOGICOS VARIAVEIS LOGICO OU ENTAO PARA INTEIROS FUNCAO INTEIRO INICIO E FIM_SE
%token DE REAIS RETORNE REAL VERDADEIRO NAO ENQUANTO ATE CARACTERES PASSO 
%token MAIS SUB DIV MUL
%token IDENTIFICADOR DESCONHECIDO

%%

regraInicial: qualquerCoisa;

qualquerCoisa : | qualquerCoisa;

%%

int main(int argc, char** argv){
    yyparse();
    return 0;
}

yyerror(char* s){
    printf("%s\n", s);
}
