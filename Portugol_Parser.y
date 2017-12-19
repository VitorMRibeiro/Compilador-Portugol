%{
#include<stdio.h>
#include<string.h>
#include"ArvoreSintatica.h"

void yyerror(const char* s);
int yylex();
extern int yylineno;
extern node* algoritmo;
const char* escopo;
%}

%union {
    struct node* AST_Node;
    struct parametros* listaParametros;
    struct parametroReal* listaParametrosReais;
    int inteiro;
    char caractere;
    float real;
    char* literal;
    char* nome;
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
%left E OU
%nonassoc IGUAL MENOR MENOR_IGUAL MAIOR MAIOR_IGUAL DIFERENTE
%left MAIS SUB
%left MUL DIV
%right EXP
%nonassoc NEGATIVO


%type <real> CONSTANTE_REAL 
%type <inteiro> CONSTANTE_INTEIRO passo
%type <caractere> CONSTANTE_CARACTERE
%type <literal> CONSTANTE_LITERAL 
%type <nome> IDENTIFICADOR declaracao_Algoritmo cabecalho
%type <AST_Node> expr expr_Bool bloco_Instrucoes chamada_Funcao atribuicao
%type <AST_Node> se para enquanto alternativa
%type <listaParametrosReais> parametros_Reais varios_Parametros_Reais
%type <listaParametros> parametro parametros varios_Parametros
%%

inicio: declaracao_Algoritmo bloco_Declaracao_Variaveis INICIO bloco_Instrucoes FIM definicao_Funcoes
{
    algoritmo = $4;
};

declaracao_Algoritmo: ALGORITMO IDENTIFICADOR PONTO_VIRGULA { $$ = $2; escopo = "algoritmo"; };

bloco_Declaracao_Variaveis:
                          | VARIAVEIS declaracao_Variaveis FIM_VARIAVEIS
                          ; 


declaracao_Variaveis: 

IDENTIFICADOR DOIS_PONTOS INTEIRO PONTO_VIRGULA { 
    if(!inserirVariavel($1, escopo, var_inteiro)){
        yyerror("redeclaracao de variavel");
    }
} 
| IDENTIFICADOR DOIS_PONTOS LITERAL PONTO_VIRGULA { 
    if(!inserirVariavel($1, escopo, var_literal)){
	    yyerror("redeclaracao de variavel");
    } 
}
| IDENTIFICADOR DOIS_PONTOS CARACTERE PONTO_VIRGULA { 
    if(!inserirVariavel($1, escopo, var_caractere)){
		yyerror("redeclaracao de variavel");
	} 
}
| IDENTIFICADOR DOIS_PONTOS REAL PONTO_VIRGULA { 
    if(!inserirVariavel($1, escopo, var_real)){
		yyerror("redeclaracao de variavel");
	} 
}
| IDENTIFICADOR DOIS_PONTOS LOGICO PONTO_VIRGULA { 
    if(!inserirVariavel($1, escopo, var_logico)){
		yyerror("redeclaracao de variavel");
	} 
}

| declaracao_Variaveis IDENTIFICADOR DOIS_PONTOS INTEIRO PONTO_VIRGULA { 
    if(!inserirVariavel($2, escopo, var_inteiro)){
		yyerror("redeclaracao de variavel");
	} 
}
| declaracao_Variaveis IDENTIFICADOR DOIS_PONTOS LITERAL PONTO_VIRGULA { 
    if(!inserirVariavel($2, escopo, var_literal)){
		yyerror("redeclaracao de variavel");
	} 
}
| declaracao_Variaveis IDENTIFICADOR DOIS_PONTOS CARACTERE PONTO_VIRGULA { 
    if(!inserirVariavel($2, escopo, var_caractere)){
		yyerror("redeclaracao de variavel");
	} 
}
| declaracao_Variaveis IDENTIFICADOR DOIS_PONTOS REAL PONTO_VIRGULA { 
    if(!inserirVariavel($2, escopo, var_real)){
		yyerror("redeclaracao de variavel");
	} 
}
| declaracao_Variaveis IDENTIFICADOR DOIS_PONTOS LOGICO PONTO_VIRGULA { 
    if(!inserirVariavel($2, escopo, var_logico)){
		yyerror("redeclaracao de variavel");
	} 
};


definicao_Funcoes:  
                 | definicao_Funcoes definicao_Funcao 
                 ; 

definicao_Funcao: cabecalho bloco_Declaracao_Variaveis INICIO bloco_Instrucoes FIM { inserirCorpoFuncao($1, $4); }
                ;

cabecalho: 

FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES 
{ 
    $$ = $2;
    inserirFuncao($2);
    definirTipoRetorno($2, indefinido);
    definirParametros($2, $4);
    escopo = $2;
}
| FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS INTEIRO 
{ 
    $$ = $2;
    inserirFuncao($2);
    definirTipoRetorno($2, var_inteiro);
    definirParametros($2, $4);
    escopo = $2;
}
| FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS REAL
{
    $$ = $2;
    inserirFuncao($2);
    definirTipoRetorno($2, var_real);
    definirParametros($2, $4);
    escopo = $2;
}
| FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS LITERAL 
{
    $$ = $2;
    inserirFuncao($2);
    definirTipoRetorno($2, var_literal);
    definirParametros($2, $4); 
    escopo = $2;
}
| FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS LOGICO 
{ 
    $$ = $2; 
    inserirFuncao($2);
    definirTipoRetorno($2, var_logico);
    definirParametros($2, $4);
    escopo = $2;
}
| FUNCAO IDENTIFICADOR ABRE_PARENTESES parametros FECHA_PARENTESES DOIS_PONTOS CARACTERE
{
    $$ = $2;
    inserirFuncao($2);
    definirTipoRetorno($2, var_caractere);
    definirParametros($2, $4);
    escopo = $2;
};

parametros: 
{
    $$ = NULL;
}
| parametro{
    $$ = $1;
}
| parametro varios_Parametros{
    $1->prox = $2;
};

varios_Parametros: 

VIRGULA parametro{
    $$ = $2;
}
| VIRGULA parametro varios_Parametros{
    $2->prox = $3;
    $$ = $2;
};

parametro: 

IDENTIFICADOR DOIS_PONTOS INTEIRO {
    $$ = malloc(sizeof(struct parametros));
    strcpy($$->nome, $1);
    $$->tipo = var_inteiro;
    $$->prox = NULL;
}
| IDENTIFICADOR DOIS_PONTOS REAL{
    $$ = malloc(sizeof(struct parametros));
    strcpy($$->nome, $1);
    $$->tipo = var_real;
    $$->prox = NULL;
}
| IDENTIFICADOR DOIS_PONTOS CARACTERE{
    $$ = malloc(sizeof(struct parametros));
    strcpy($$->nome, $1);
    $$->tipo = var_caractere;
    $$->prox = NULL;
}
| IDENTIFICADOR DOIS_PONTOS LITERAL{
    $$ = malloc(sizeof(struct parametros));
    strcpy($$->nome, $1);
    $$->tipo = var_literal;
    $$->prox = NULL;
}
| IDENTIFICADOR DOIS_PONTOS LOGICO{
    $$ = malloc(sizeof(struct parametros));
    strcpy($$->nome, $1);
    $$->tipo = var_logico;
    $$->prox = NULL;
};


bloco_Instrucoes:  { $$ = NULL; }
                | atribuicao PONTO_VIRGULA      bloco_Instrucoes { $$ = novoBasico(bloco, $1, $3, yylineno); }
                | chamada_Funcao PONTO_VIRGULA  bloco_Instrucoes { $$ = novoBasico(bloco, $1, $3, yylineno); } 
                | RETORNE expr PONTO_VIRGULA    bloco_Instrucoes { $$ = novoBasico(bloco, novoUnario(retorne, $2, yylineno), $4, yylineno); }
                | se                            bloco_Instrucoes { $$ = novoBasico(bloco, $1, $2, yylineno); } 
                | enquanto                      bloco_Instrucoes { $$ = novoBasico(bloco, $1, $2, yylineno); }
                | para                          bloco_Instrucoes { $$ = novoBasico(bloco, $1, $2, yylineno); }
                ;

enquanto: ENQUANTO expr_Bool FACA bloco_Instrucoes FIM_ENQUANTO { $$ = novoEnquanto(enquanto, $2, $4, yylineno); };

para: PARA IDENTIFICADOR DE CONSTANTE_INTEIRO ATE CONSTANTE_INTEIRO passo FACA bloco_Instrucoes FIM_PARA { $$ = novoPara(para, $2, $4, $6, $7, $9, yylineno); };

passo: { $$ = 1; }
     | PASSO CONSTANTE_INTEIRO { $$ = $2; }
     | PASSO SUB CONSTANTE_INTEIRO { $$ = - $3; }
     ;

se: SE expr_Bool ENTAO bloco_Instrucoes alternativa FIM_SE { $$ = novoSe(se, $2, $4, $5, yylineno); };

alternativa: { $$ = NULL; }
           | SENAO bloco_Instrucoes { $$ = $2; }
           ;

expr_Bool: VERDADEIRO { $$ = novoInteiro(logico, 1, yylineno); }
         | FALSO { $$ = novoInteiro(logico, 0, yylineno); }
         | IDENTIFICADOR { $$ = novaVariavel(variavel, $1, yylineno); free($1); }
         | expr_Bool E expr_Bool { $$ = novoBasico(e, $1, $3, yylineno); }
         | expr_Bool OU expr_Bool { $$ = novoBasico(ou, $1, $3, yylineno); }
         | expr IGUAL expr { $$ = novoBasico(igual, $1, $3, yylineno); }
         | expr MAIOR expr { $$ = novoBasico(maior, $1, $3, yylineno); }
         | expr MENOR expr { $$ = novoBasico(menor, $1, $3, yylineno); }
         | expr MAIOR_IGUAL expr { $$ = novoBasico(maiorIgual, $1, $3, yylineno); }
         | expr MENOR_IGUAL expr { $$ = novoBasico(menorIgual, $1, $3, yylineno); }
         | expr DIFERENTE expr { $$ = novoBasico(diferente, $1, $3, yylineno); }
         ;

atribuicao: IDENTIFICADOR ATRIBUICAO expr { $$ = novoBasico(atribuicao, novaVariavel(variavel, $1, yylineno), $3, yylineno); };

expr: expr MAIS expr                        { $$ = novoBasico(soma, $1, $3, yylineno); }
    | expr SUB expr                         { $$ = novoBasico(subtracao, $1, $3, yylineno); }
    | expr MUL expr                         { $$ = novoBasico(multiplicacao, $1, $3, yylineno); }
    | expr DIV expr                         { $$ = novoBasico(divisao, $1, $3, yylineno); }
    | expr EXP expr                         { $$ = novoBasico(potencia, $1, $3, yylineno); }
    | ABRE_PARENTESES expr FECHA_PARENTESES { $$ = $2; }
    | SUB expr %prec NEGATIVO               { $$ = novoUnario(negativo, $2, yylineno); }
    | CONSTANTE_INTEIRO                     { $$ = novoInteiro(inteiro, $1, yylineno); }
    | CONSTANTE_REAL                        { $$ = novoReal(real, $1, yylineno); }
    | CONSTANTE_CARACTERE                   { $$ = novoCaractere(caractere, $1, yylineno); }
    | CONSTANTE_LITERAL                     { $$ = novoLiteral(literal, $1, yylineno); }
    | IDENTIFICADOR                         { $$ = novaVariavel(variavel, $1, yylineno); free($1); }
    | chamada_Funcao                        { $$ = $1; }
    ;

chamada_Funcao: IDENTIFICADOR ABRE_PARENTESES parametros_Reais FECHA_PARENTESES { $$ = novoFuncao(funcao, $1, $3, yylineno); free($1); };

parametros_Reais: { $$ = NULL; }
                | expr { $$ = malloc(sizeof(struct parametroReal)); $$->expr = $1; $$->prox = NULL; }
                | expr varios_Parametros_Reais { $$ = malloc(sizeof(struct parametroReal)); $$->expr = $1; $$->prox = $2; }
                ;

varios_Parametros_Reais: VIRGULA expr { $$ = malloc(sizeof(struct parametroReal)); $$->expr = $2; $$->prox = NULL; }
                       | VIRGULA expr varios_Parametros_Reais { $$ = malloc(sizeof(struct parametroReal)); $$->expr = $2; $$->prox = $3; } 
                       ;



%%


void yyerror(const char* s){
    printf("Erro: %s, linha %d\n", s, yylineno);
}

