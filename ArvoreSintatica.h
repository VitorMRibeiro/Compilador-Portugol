#include<stdlib.h>

enum tipoNo { se, enquanto, para, soma, subtracao, mutiplicacao, inteiro, real, caractere, literal, variavel, funcao };


// the basic node structure for the tree.
struct node{
    enun tipoNo tipo;
    struct node* left;
    struct node* right;
};
typedef struct node node;

struct se{
    enum tipoNo tipo;
    node* condicao;
    node* entao;
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
    unsigned int de;
    unsigned int ate;
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
};

struct funcao{
    enum tipoNo tipo;
    simbolo* ref;
    parametro* parametroReais;
};

node* novoBasico(enum tipoNo, node*, node*);
node* novoSe(enum tipoNo, node*, node*, node*);
node* novoEnquanto(enum tipoNo, node*, node*);
node* novoPara();
node* novoFuncao(enum tipoNo tipo, const char* nome, parametro* listaParametros);
node* novaVariavel(enum tipoNo tipo, const char* nome);
node* novoLiteral(enum tipoNo tipo, const char* valor);
node*...





