#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>
#include"tabelaSimbolos.h"


enum tipoNo 
{ 
    se = 0,
    enquanto, 
    para, 
    soma, 
    subtracao, 
    multiplicacao,
    divisao,
    potencia,
    negativo, 
    inteiro, 
    atribuicao,
    retorne,
    real, 
    caractere, 
    literal, 
    variavel, 
    funcao,
    igual,
    menor,
    maior,
    menorIgual,
    maiorIgual,
    diferente,
    bloco
};


union  valorExpressao{
    int inteiro;
    float real;
    char caractere;
    const char* literal;
    bool logico;
};


// the basic node structure for the tree.
struct node{
    enum tipoNo tipo;
    struct node* left;
    struct node* right;
};
typedef struct node node;

struct se{
    enum tipoNo tipo;
    node* condicao;
    node* se;
    node* senao;
};

struct enquanto{
    enum tipoNo tipo;
    node* condicao;
    node* corpo;    
};

struct para{
    enum tipoNo tipo;
    simbolo* variavel;
    int de;
    int ate;
    node* corpo;
};

struct inteiro{
    enum tipoNo tipo;
    int valor;
};

struct real{
    enum tipoNo tipo;
    float valor;
};

struct caractere{
    enum tipoNo tipo;
    char valor;
};

struct literal{
    enum tipoNo tipo;
    const char* valor;
};

struct variavel{
    enum tipoNo tipo;
    simbolo* ref;
    char nome[16]; // for debuging purposes
};

struct parametro{
    union valorExpressao valor;
    struct parametro* prox;
};

struct funcao{
    enum tipoNo tipo;
    simbolo* ref;
    struct parametro* parametroReais;
    char nome[16]; // for debuging purposes
};

struct unario{
    enum tipoNo tipo;
    node* corpo;
};


node* novoUnario(enum tipoNo tipo, node* corpo);
node* novoBasico(enum tipoNo, node*, node*);
node* novoSe(enum tipoNo, node*, node*, node*);
node* novoEnquanto(enum tipoNo, node*, node*);
node* novoPara(enum tipoNo tipo, const char* nome, int de, int ate, node* corpo);
node* novoFuncao(enum tipoNo tipo, const char* nome, struct parametro* listaParametros);
node* novaVariavel(enum tipoNo tipo, const char* nome);
node* novoLiteral(enum tipoNo tipo, const char* valor);
node* novoCaractere(enum tipoNo tipo, char valor);
node* novoReal(enum tipoNo tipo, float valor);
node* novoInteiro(enum tipoNo, int valor);

union valorExpressao avaliarArvore(node* no);
void criarJS(node*,  FILE*, const char*);
void imprimirArvore(node* no, FILE*);
void treeFree(node*);
