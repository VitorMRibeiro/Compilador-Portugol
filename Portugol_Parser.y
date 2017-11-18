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
%token ERRO
%token FIM_ARQUIVO 0

%nonassoc ATRIBUICAO
%nonassoc IGUAL MENOR MENOR_IGUAL MAIOR MAIOR_IGUAL DIFERENTE
%left MAIS SUB
%left MUL DIV
%right EXP


%type <real> CONSTANTE_REAL  
%type <inteiro> CONSTANTE_INTEIRO

%%

inicio: definicao_Funcoes declaracao_Algoritmo bloco_Declaracao_Variaveis INICIO bloco_Instrucoes FIM definicao_Funcoes;

declaracao_Algoritmo: ALGORITMO IDENTIFICADOR PONTO_VIRGULA;

bloco_Declaracao_Variaveis:
                          | VARIAVEIS declaracao_Variaveis FIM_VARIAVEIS
                          ; 

declaracao_Variaveis: identificadores DOIS_PONTOS INTEIRO PONTO_VIRGULA
                    | identificadores DOIS_PONTOS LITERAL PONTO_VIRGULA
                    | identificadores DOIS_PONTOS CARACTERE PONTO_VIRGULA
                    | identificadores DOIS_PONTOS REAL PONTO_VIRGULA
                    | identificadores DOIS_PONTOS LOGICO PONTO_VIRGULA
 
                    | declaracao_Variaveis identificadores DOIS_PONTOS INTEIRO PONTO_VIRGULA
                    | declaracao_Variaveis identificadores DOIS_PONTOS LITERAL PONTO_VIRGULA
                    | declaracao_Variaveis identificadores DOIS_PONTOS CARACTERE PONTO_VIRGULA
                    | declaracao_Variaveis identificadores DOIS_PONTOS REAL PONTO_VIRGULA
                    | declaracao_Variaveis identificadores DOIS_PONTOS LOGICO PONTO_VIRGULA
                    ;

identificadores: IDENTIFICADOR
               | identificadores VIRGULA IDENTIFICADOR
               ;

definicao_Funcoes:  
                 | definicao_Funcoes definicao_Funcao 
                 ; 

definicao_Funcao: cabecalho bloco_Declaracao_Variaveis INICIO bloco_Instrucoes FIM
                ;

cabecalho: FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS INTEIRO
         | FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS REAL
         | FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS LITERAL
         | FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS LOGICO
         | FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS CARACTERE
         ;

parametros: 
          | parametro
          | parametro varios_Parametros
          ;

varios_Parametros: VIRGULA parametro
                 | varios_Parametros VIRGULA parametro
                 ;

parametro: IDENTIFICADOR DOIS_PONTOS INTEIRO 
         | IDENTIFICADOR DOIS_PONTOS REAL
         | IDENTIFICADOR DOIS_PONTOS CARACTERE
         | IDENTIFICADOR DOIS_PONTOS LITERAL
         | IDENTIFICADOR DOIS_PONTOS LOGICO 
         ;


bloco_Instrucoes: 
                | bloco_Instrucoes atribuicao PONTO_VIRGULA 
                | bloco_Instrucoes chamada_Funcao PONTO_VIRGULA
                | bloco_Instrucoes RETORNE expr PONTO_VIRGULA
                | bloco_Instrucoes se 
                | bloco_Instrucoes enquanto 
                | bloco_Instrucoes para 
                ;

enquanto: ENQUANTO expr_Bool FACA bloco_Instrucoes FIM_ENQUANTO;

para: PARA IDENTIFICADOR DE CONSTANTE_INTEIRO ATE CONSTANTE_INTEIRO passo FACA bloco_Instrucoes FIM_PARA;

passo:
     | PASSO CONSTANTE_INTEIRO
     | PASSO SUB CONSTANTE_INTEIRO
     ;

se: SE expr_Bool ENTAO bloco_Instrucoes alternativa FIM_SE;

alternativa: 
           | SENAO bloco_Instrucoes 
           ;

expr_Bool: expr IGUAL expr
         | expr MAIOR expr
         | expr MENOR expr
         | expr MAIOR_IGUAL expr
         | expr MENOR_IGUAL expr
         | expr DIFERENTE expr
         ;

atribuicao: IDENTIFICADOR ATRIBUICAO expr;

expr: expr MAIS expr
    | expr SUB expr
    | expr MUL expr
    | expr DIV expr
    | ABRE_PARENTESES expr FECHA_PARENTESES
    | CONSTANTE_INTEIRO
    | CONSTANTE_REAL
    | CONSTANTE_CARACTERE
    | CONSTANTE_LITERAL
    | IDENTIFICADOR
    | chamada_Funcao
    ;

chamada_Funcao: IDENTIFICADOR ABRE_PARENTESES parametros_Reais FECHA_PARENTESES;

parametros_Reais: 
                | expr
                | expr varios_Parametros_Reais
                ;

varios_Parametros_Reais: VIRGULA expr
                       | varios_Parametros_Reais VIRGULA expr
                       ;



%%

int main(int argc, char** argv){
    memset(tabelaSimbolos, 0, sizeof(id*) * SYM_TAB_SIZE); // inicializa tabela de simbolos com NULL.
    yyparse();
    return 0;
}

void yyerror(char* s){
    printf("%s\n", s);
    printf("linha %d\n", yylineno);
}
