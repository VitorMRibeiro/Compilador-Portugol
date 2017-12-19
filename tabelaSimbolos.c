#include"tabelaSimbolos.h"
#include<stdio.h>
#include<stdlib.h>
#include<string.h>

unsigned int hash(const char* symbol){
    unsigned int h = 0;
    unsigned c;
    while( c = *symbol++ ) h = h * 9 ^ c;
    return h % SYM_TAB_SIZE;
}


void* endereco(const char* nome){
    // simbolo* i;
    // if(i = buscaNome(nome)){
    //     if()
    //     return i->endereco;
    // }
    return NULL;
}

void inserir(simbolo* novoId, simbolo** lista){
    novoId->prox = *lista;
    *lista = novoId;
}

// insere uma nova variavel na tabela de simbolos.
bool inserirVariavel(const char* nomeId, const char* escopo, int tipo){
    simbolo** lista = &(tabelaSimbolos[hash(nomeId)]);
    if(!buscaNome(nomeId, escopo)){
        struct IDvariavel* novoId;
        novoId = malloc(sizeof(struct IDfuncao));
        strcpy(novoId->nome, nomeId);
        strcpy(novoId->escopo, escopo);
        novoId->endereco = NULL;    
        novoId->prox = NULL;
        novoId->tipo = sym_variavel;
        novoId->var_tipo = tipo;
        inserir( (simbolo*) novoId, lista);
        return true;
    }
    return false;
}

// insere uma nova funcao na tabela de simbolos.
bool inserirFuncao(const char* nomeId){
    simbolo** lista = &(tabelaSimbolos[hash(nomeId)]);
    if(!buscaNome(nomeId, "algoritmo")){
        struct IDfuncao* novoId;
        novoId = malloc(sizeof(struct IDfuncao));
        strcpy(novoId->nome, nomeId);
        strcpy(novoId->escopo, "algoritmo");
        novoId->listaParametros = NULL;
        novoId->prox = NULL;
        novoId->tipo = sym_funcao;
        inserir( (simbolo*) novoId, lista);
        return true;
    }
    return false;
}


simbolo* buscaNome(const char* nome, const char* escopo){
    simbolo* lista = tabelaSimbolos[hash(nome)];
    simbolo* iterador;
    iterador = lista;
    while(iterador != NULL){
        if(!  (strcmp(&(iterador->nome[0]), nome) && strcmp(&(iterador->escopo[0]), escopo))  ){
            return iterador;
        }
        iterador = iterador->prox;
    }
    return NULL;
}


void definirTipoRetorno(const char* nomeId, int tipo){
    struct IDfuncao* f;
    if(f = (struct IDfuncao*) buscaNome(nomeId, "algoritmo")){
        f->tipo_retorno = tipo;
    }    
}
    

void definirParametros(const char* nomeId, struct parametros* listaParametros){
    struct IDfuncao* f;
    if(f = (struct IDfuncao*) buscaNome(nomeId, "algoritmo")){
        f->listaParametros = listaParametros;
    }    
}

void inserirCorpoFuncao(const char* nomeId, void* corpo){
    struct IDfuncao* f;
    if(f = (struct IDfuncao*) buscaNome(nomeId, "algoritmo")){
        f->corpo = corpo;
    }  
}


void inserirInteiro(const char* nome, const char* escopo, int valor){
    struct IDvariavel* i;
    if(i = (struct IDvariavel*) buscaNome(nome, escopo)){
        i->endereco = malloc(sizeof(int));
        *(int*)(i->endereco) = valor;
    }
}

void inserirReal(const char* nome, const char* escopo, float valor){
    struct IDvariavel* i;
    if(i = (struct IDvariavel*) buscaNome(nome, escopo)){
        i->endereco = malloc(sizeof(float));
        *(float*)(i->endereco) = valor;
    }
}

void remover(const char* nome, const char* escopo, simbolo** lista){
    simbolo* iterador;
    simbolo* anterior;
    if(*lista != NULL){
        anterior = *lista;
        iterador = (*lista)->prox;

        // remover no inicio da lista.
        if(  !(strcmp((*lista)->nome, nome) && strcmp((*lista)->escopo, escopo))  ){
            *lista = (*lista)->prox;
            if(anterior -> tipo == sym_variavel){
                free( ((struct IDvariavel* ) anterior)->endereco);
            }
            free(anterior);
        }
        // remover no meio ou final.
        while(iterador != NULL){
            if(  !(strcmp((*lista)->nome, nome) && strcmp((*lista)->escopo, escopo))  ){
                anterior->prox = iterador->prox;
                if(anterior -> tipo == sym_variavel){
                    free( ((struct IDvariavel* ) anterior)->endereco);
                    free(iterador);
                }
            }
            anterior = iterador;
            iterador = iterador->prox;
        }
    }
}


