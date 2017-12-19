#include<stdbool.h>
#define SYM_TAB_SIZE 999


enum tipoSimbolo{ sym_variavel, sym_funcao };
enum tipoVariavel{ var_inteiro, var_real, var_caractere, var_literal, var_logico, indefinido };

// estrutura de um identificador na tabela de simbolos.
struct simbolo{
    int tipo;
    char nome[16];
    char escopo[16];
    struct simbolo* prox;
};
typedef struct simbolo simbolo;

struct IDvariavel{
    int tipo;
    char nome[16];
    char escopo[16];
    struct simbolo* prox;
    int var_tipo;
    void* endereco;
};

struct parametros{
    int tipo;
    char nome[16];
    struct parametros* prox;
};

struct IDfuncao{
    int tipo;
    char nome[16];
    char escopo[16];
    struct simbolo* prox;
    struct parametros* listaParametros;
    int tipo_retorno;
    void* corpo;
};

// declaração da tabela de simbolos.
#ifndef tabelaSimbolos
    simbolo* tabelaSimbolos[SYM_TAB_SIZE];
#else
    extern simbolo* tabelaSimbolos[SYM_TAB_SIZE];
#endif


unsigned int hash(const char*);                      // embaralha os bits do nome e retorna um indice da tabela de simbolos.
void* endereco(const char*);
void inserirReal(const char*, const char*, float);   // insere um real no endereço de uma variavel.
void inserirInteiro(const char*, const char*, int) ; // insere um inteiro no endereço de uma variavel.
void remover(const char*, const char*, simbolo**);   // remove um nó na lista que tenha o nome correspondente.
simbolo* buscaNome(const char*, const char*);        // retorna um ponteiro para o nó que contem o nome buscado.
bool inserirVariavel(const char*, const char*, int);
bool inserirFuncao(const char*);
void definirTipoRetorno(const char*, int);
void definirParametros(const char*, struct parametros*);
void inserirCorpoFuncao(const char*, void*);


