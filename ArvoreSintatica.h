#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>
#include"tabelaSimbolos.h"


enum tipoNo 
{
    inteiro,
    real,
    caractere,
    literal,
    logico, 
    se,
    enquanto, 
    para, 
    soma, 
    subtracao, 
    multiplicacao,
    divisao,
    potencia,
    negativo, 
    atribuicao,
    retorne,
    variavel, 
    funcao,
    igual,
    menor,
    maior,
    menorIgual,
    maiorIgual,
    diferente,
    bloco,
    e,
    ou,
};


// the basic node structure for the tree.
struct node{
    int tipo;
    int linha;
    struct node* left;
    struct node* right;
};
typedef struct node node;

struct se{
    enum tipoNo tipo;
    int linha;
    node* condicao;
    node* se;
    node* senao;
};

struct enquanto{
    enum tipoNo tipo;
    int linha;
    node* condicao;
    node* corpo;    
};

struct para{
    enum tipoNo tipo;
    int linha;
    char variavel[16];
    int de;
    int ate;
    int passo;
    node* corpo;
};

struct inteiro{
    enum tipoNo tipo;
    int linha;
    int valor;
};

struct real{
    enum tipoNo tipo;
    int linha;
    float valor;
};

struct caractere{
    enum tipoNo tipo;
    int linha;
    char valor;
};

struct literal{
    enum tipoNo tipo;
    int linha;
    const char* valor;
};

struct variavel{
    enum tipoNo tipo;
    int linha;
    char nome[16]; 
};

struct parametroReal{
    node* expr;
    struct parametroReal* prox;
};

struct funcao{
    enum tipoNo tipo;
    int linha;
    char nome[16]; 
    struct parametroReal* parametrosReais;
};

struct unario{
    enum tipoNo tipo;
    int linha;
    node* corpo;
};

node* novoUnario(enum tipoNo tipo, node* corpo, int linha);
node* novoBasico(enum tipoNo, node*, node*, int linha);
node* novoSe(enum tipoNo, node*, node*, node*, int linha);
node* novoEnquanto(enum tipoNo, node*, node*, int linha);
node* novoPara(enum tipoNo tipo, const char* nome, int de, int ate, int passo, node* corpo, int linha);
node* novoFuncao(enum tipoNo tipo, const char* nome, struct parametroReal* listaParametros, int linha);
node* novaVariavel(enum tipoNo tipo, const char* nome, int linha);
node* novoLiteral(enum tipoNo tipo, const char* valor, int linha);
node* novoCaractere(enum tipoNo tipo, char valor, int linha);
node* novoReal(enum tipoNo tipo, float valor, int linha);
node* novoInteiro(enum tipoNo, int valor, int linha);

union valorExpressao avaliarArvore(node* no);
void criarJS(node*,  FILE*, const char*);
void imprimirArvore(node* no, FILE*);
void treeFree(node*);
