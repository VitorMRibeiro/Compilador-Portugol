// funcoes de criacao e avaliacao da arvore sintatica
#include<stdio.h>
#include<string.h>
#include"ArvoreSintatica.h"

node* novoBasico(enum tipoNo tipo, node* left, node* right){
    node* novoNo = malloc(sizeof(node));
    novoNo->tipo = tipo;
    novoNo->left = left;
    novoNo->right = right;
    return novoNo;
}

node* novoSe(enum tipoNo tipo, node* condicao, node* se, node* senao){
    struct se* novo = malloc(sizeof(struct se));
    novo->tipo = tipo;
    novo->condicao = condicao;
    novo->se = se;
    novo->senao = senao;
    return (node*) novo;
}

node* novoEnquanto(enum tipoNo tipo, node* condicao, node* corpo){
    struct enquanto* novo = malloc(sizeof(struct enquanto));
    novo->tipo = tipo;
    novo->condicao = condicao;
    novo->corpo = corpo;
    return (node*) novo;
}

node* novoPara(enum tipoNo tipo, const char* nome, int de, int ate, node* corpo){
    struct para* novo = malloc(sizeof(struct para));
    novo->tipo = tipo;
    novo->variavel = buscaNome(nome);
    novo->de = de;
    novo->ate = ate;
    novo->corpo = corpo;
}

node* novoFuncao(enum tipoNo tipo, const char* nome, struct parametro* listaParametros){
    struct funcao* novo = malloc(sizeof(struct funcao));
    novo->tipo = tipo;
    novo->ref = buscaNome(nome);
    novo->parametroReais = listaParametros;    
    strcpy(novo->nome, nome); // for debuging purposes.
    return (node*) novo;
}

node* novaVariavel(enum tipoNo tipo, const char* nome){
    struct variavel* novo = malloc(sizeof(struct variavel));
    novo->tipo = tipo;
    novo->ref = buscaNome(nome);
    strcpy(novo->nome, nome); // for debuging purpose.
    return (node*) novo;
}

node* novoLiteral(enum tipoNo tipo, const char* valor){
    struct literal* novo = malloc(sizeof(struct literal));
    novo->tipo = tipo;
    novo->valor = valor;
    return (node*) novo;
}

node* novoCaractere(enum tipoNo tipo, char valor){
    struct caractere* novo = malloc(sizeof(struct caractere));
    novo->tipo = tipo;
    novo->valor = valor;
    return (node*) novo;
}

node* novoReal(enum tipoNo tipo, float valor){
    struct real* novo = malloc(sizeof(struct real));
    novo->tipo = tipo;
    novo->valor = valor;
    return (node*) novo;
}

node* novoInteiro(enum tipoNo tipo, int valor){
    struct inteiro* novo = malloc(sizeof(struct inteiro));
    novo->tipo = tipo;
    novo->valor = valor;
}

node* novoUnario(enum tipoNo tipo, node* corpo){
    struct unario* novo = malloc(sizeof(struct unario));
    novo->tipo = tipo;
    novo->corpo = corpo;
    return (node*) novo;
}

void imprimeEnum(enum tipoNo);

void imprimirArvore(node* no){
    if( no != NULL){
        imprimeEnum(no->tipo);
        printf(" ( ");
        switch(no->tipo){
            case se: 
                imprimirArvore(((struct se*)no)->condicao);
                imprimirArvore(((struct se*)no)->se);
                imprimirArvore(((struct se*)no)->senao);
                break;
            case enquanto:
                imprimirArvore(((struct enquanto*)no)->condicao);
                imprimirArvore(((struct enquanto*)no)->corpo);
                break;
            case para:
                imprimirArvore(((struct para*)no)->corpo);
                break;
            case inteiro:
                printf(" %d ", ((struct inteiro*)no)->valor);
                break;
            case real:
                printf(" %f ", ((struct real*)no)->valor);
                break;
            case literal:
                printf(" %s ", ((struct literal*)no)->valor);
                break;
            case caractere:
                printf(" %c ", ((struct caractere*)no)->valor);
                break;
            case variavel:
                printf("%s", ((struct variavel*)no)->nome);
                break;
            case funcao:
                printf("%s", ((struct funcao*)no)->nome);
                break;
            case negativo:
                imprimirArvore(((struct unario*)no)->corpo);
                break;
            case retorne:
                imprimirArvore(((struct unario*)no)->corpo);
                break;
            default:
                imprimirArvore(no->left);
                imprimirArvore(no->right);
                break;
        }
        printf(" ) ");
    }
}


void imprimeEnum(enum tipoNo tipo){
    switch(tipo){
        case se: 
            printf("se");
            break;
        case enquanto: 
            printf("enquanto");
            break; 
        case para: 
            printf("para");
            break; 
        case soma: 
            printf("soma");
            break; 
        case subtracao: 
            printf("subtracao");
            break; 
        case multiplicacao: 
            printf("multiplicacao");
            break;
        case divisao: 
            printf("divisao");
            break;
        case potencia: 
            printf("potencia");
            break;
        case negativo: 
            printf("negativo");
            break; 
        case inteiro: 
            printf("inteiro");
            break; 
        case atribuicao: 
            printf("atribuicao");
            break;
        case retorne: 
            printf("retorne");
            break;
        case real: 
            printf("real");
            break; 
        case caractere: 
            printf("caractere");
            break; 
        case literal: 
            printf("literal");
            break; 
        case variavel: 
            printf("variavel");
            break; 
        case funcao: 
            printf("funcao");
            break;
        case igual: 
            printf("igual");
            break;
        case menor: 
            printf("menor");
            break;
        case maior: 
            printf("maior");
            break;
        case menorIgual: 
            printf("menorIgual");
            break;
        case maiorIgual: 
            printf("maiorIgual");
            break;
        case diferente: 
            printf("diferente");
            break;
        case bloco:
            printf("bloco");
            break;
        defaul:
            printf("bad node type");
    }
}