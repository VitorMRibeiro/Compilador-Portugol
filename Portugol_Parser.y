%{
#include<stdio.h>
#include<string.h>
#include"ArvoreSintatica.h"

void yyerror(char* s);
int yylex();
extern int yylineno;

%}

%union {
    struct node* AST_Node;
    int inteiro;
    char caractere;
    float real;
    char* literal;
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
%nonassoc NEGATIVO


%type <real> CONSTANTE_REAL  
%type <inteiro> CONSTANTE_INTEIRO
%type <caractere> CONSTANTE_CARACTERE
%type <literal> CONSTANTE_LITERAL 
%type <nome> IDENTIFICADOR declaracao_Algoritmo cabecalho
%type <AST_Node> expr expr_Bool bloco_Instrucoes chamada_Funcao atribuicao
%type <AST_Node> se para enquanto alternativa
%%

inicio: declaracao_Algoritmo bloco_Declaracao_Variaveis INICIO bloco_Instrucoes FIM definicao_Funcoes { printf("algoritmo %s:\n", $1); imprimirArvore($4); printf("\n\n\n");};

declaracao_Algoritmo: ALGORITMO IDENTIFICADOR PONTO_VIRGULA { strcpy($$, $2); };

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

definicao_Funcao: cabecalho bloco_Declaracao_Variaveis INICIO bloco_Instrucoes FIM { printf("funcao %s:\n", $1); imprimirArvore($4); printf("\n\n\n")}
                ;

cabecalho: FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS INTEIRO { strcpy($$, $2); }
         | FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS REAL { strcpy($$, $2); }
         | FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS LITERAL { strcpy($$, $2); }
         | FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS LOGICO { strcpy($$, $2); }
         | FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS CARACTERE { strcpy($$, $2); }
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


bloco_Instrucoes:  { $$ = NULL; }
                | atribuicao PONTO_VIRGULA      bloco_Instrucoes { $$ = novoBasico(bloco, $1, $3); }
                | chamada_Funcao PONTO_VIRGULA  bloco_Instrucoes { $$ = novoBasico(bloco, $1, $3); } 
                | RETORNE expr PONTO_VIRGULA    bloco_Instrucoes { $$ = novoBasico(bloco, novoUnario(retorne, $2), $4); }
                | se                            bloco_Instrucoes { $$ = novoBasico(bloco, $1, $2); } 
                | enquanto                      bloco_Instrucoes { $$ = novoBasico(bloco, $1, $2); }
                | para                          bloco_Instrucoes { $$ = novoBasico(bloco, $1, $2); }
                ;

enquanto: ENQUANTO expr_Bool FACA bloco_Instrucoes FIM_ENQUANTO { $$ = novoEnquanto(enquanto, $2, $4); };

para: PARA IDENTIFICADOR DE CONSTANTE_INTEIRO ATE CONSTANTE_INTEIRO passo FACA bloco_Instrucoes FIM_PARA { $$ = novoPara(para, $2, $4, $6, $9); };

passo:
     | PASSO CONSTANTE_INTEIRO
     | PASSO SUB CONSTANTE_INTEIRO
     ;

se: SE expr_Bool ENTAO bloco_Instrucoes alternativa FIM_SE { $$ = novoSe(se, $2, $4, $5); };

alternativa: { $$ = NULL; }
           | SENAO bloco_Instrucoes { $$ = $2; }
           ;

expr_Bool: expr IGUAL expr { $$ = novoBasico(igual, $1, $3); }
         | expr MAIOR expr { $$ = novoBasico(maior, $1, $3); }
         | expr MENOR expr { $$ = novoBasico(menor, $1, $3); }
         | expr MAIOR_IGUAL expr { $$ = novoBasico(maiorIgual, $1, $3); }
         | expr MENOR_IGUAL expr { $$ = novoBasico(menorIgual, $1, $3); }
         | expr DIFERENTE expr { $$ = novoBasico(diferente, $1, $3); }
         ;

atribuicao: IDENTIFICADOR ATRIBUICAO expr { $$ = novoBasico(atribuicao, novaVariavel(variavel, $1), $3); };

expr: expr MAIS expr                        { $$ = novoBasico(soma, $1, $3); }
    | expr SUB expr                         { $$ = novoBasico(subtracao, $1, $3); }
    | expr MUL expr                         { $$ = novoBasico(multiplicacao, $1, $3); }
    | expr DIV expr                         { $$ = novoBasico(divisao, $1, $3); }
    | expr EXP expr                         { $$ = novoBasico(potencia, $1, $3); }
    | ABRE_PARENTESES expr FECHA_PARENTESES { $$ = $2; }
    | SUB expr %prec NEGATIVO               { $$ = novoUnario(negativo, $2); }
    | CONSTANTE_INTEIRO                     { $$ = novoInteiro(inteiro, $1); }
    | CONSTANTE_REAL                        { $$ = novoReal(real, $1); }
    | CONSTANTE_CARACTERE                   { $$ = novoCaractere(caractere, $1); }
    | CONSTANTE_LITERAL                     { $$ = novoLiteral(literal, $1); }
    | IDENTIFICADOR                         { $$ = novaVariavel(variavel, $1);}
    | chamada_Funcao                        { $$ = $1; }
    ;

chamada_Funcao: IDENTIFICADOR ABRE_PARENTESES parametros_Reais FECHA_PARENTESES { $$ = novoFuncao(funcao, $1, NULL); };

parametros_Reais: 
                | expr
                | expr varios_Parametros_Reais
                ;

varios_Parametros_Reais: VIRGULA expr
                       | varios_Parametros_Reais VIRGULA expr
                       ;



%%

int main(int argc, char** argv){
    memset(tabelaSimbolos, 0, sizeof(simbolo*) * SYM_TAB_SIZE); // inicializa tabela de simbolos com NULL.
    yyparse();
    return 0;
}

void yyerror(char* s){
    printf("%s\n", s);
    printf("linha %d\n", yylineno);
}
