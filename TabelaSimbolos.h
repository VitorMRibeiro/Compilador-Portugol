#include<stdbool.h>
#define SYM_TAB_SIZE 999


// estrutura de um identificador na tabela de simbolos.
struct simbolo{
    int tipo;
    char nome[16];
    void* endereco;
    struct simbolo* prox;
};
typedef struct simbolo simbolo;


// declaração da tabela de simbolos.
#ifndef tabelaSimbolos
    simbolo* tabelaSimbolos[SYM_TAB_SIZE];
#else
    extern simbolo* tabelaSimbolos[SYM_TAB_SIZE];
#endif


void* endereco(const char*);
void inserirReal(const char*, float);
bool comparaTipo(const char*, int);
void definirTipo(const char*, int);                              // define o tipo da variavel.
void inserirInteiro(const char* nome, int valor) ;               // insere um inteiro no endereço.
void remover(const char* nome, simbolo** lista);                 // remove um nó na lista que tenha o nome correspondente.
simbolo* buscaNome(const char* nome);                            // retorna um ponteiro para o nó que contem o nome buscado.
void buscarInserir(const char* nome);                            // busca por um nome na lista e se não for encontrado, insere um nó com o nome no inicio da lista.
unsigned int hash(const char*);                                  // embaralha os bits do nome e retorna um indice da tabela de simbolos.

