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

bool compTipo(const char* nome, enum tipo compTipo){
    simbolo* lista = tabelaSimbolos[hash(nome)];
    simbolo* i;
    if(i = buscaNome(nome, lista)){
        if( compTipo == i->tipoId )
            return true;
        else
            return false;
    }
    else{
        return false;
    }
    
}

void* endereco(const char* nome){
    simbolo* lista = tabelaSimbolos[hash(nome)];
    simbolo* i;
    if(i = buscaNome(nome, lista)){
        return i->endereco;
    }
    return NULL;
}

bool busca(const char* nome){
    simbolo* lista = tabelaSimbolos[hash(nome)];
    if(buscaNome(nome, lista))
        return true;
    else
        return false;
}

void inserir(simbolo* novoId, simbolo** lista){
    novoId->prox = *lista;
    *lista = novoId;
}

void buscarInserir(const char* nomeId){
    simbolo** lista = &(tabelaSimbolos[hash(nomeId)]);
    if(!buscaNome(nomeId, *lista)){
        simbolo* novoId;
        novoId = malloc(sizeof(simbolo));
        strcpy(novoId->nome, nomeId);
        novoId->endereco = NULL;
        inserir(novoId, lista);
        printf("insercao completa\n");
    }
}

simbolo* buscaNome(const char* nome, simbolo* lista){
    simbolo* iterador;
    iterador = lista;
    while(iterador != NULL){
        if(!strcmp(&(iterador->nome[0]), nome)){
            return iterador;
        }
        iterador = iterador->prox;
    }
    return NULL;
}

void definirTipo(const char* nome, enum tipo tipoId){
    simbolo* lista = tabelaSimbolos[hash(nome)];
    simbolo* i;
    if(i = buscaNome(nome, lista)){
        i->tipoId = tipoId;
    }    
}

void inserirInteiro(const char* nome, int valor){
    simbolo* lista = tabelaSimbolos[hash(nome)];
    simbolo* i;
    if(i = buscaNome(nome, lista)){
        i->endereco = malloc(sizeof(int));
        *(int*)(i->endereco) = valor;
    }
 }

void inserirReal(const char* nome, float valor){
    simbolo* lista = tabelaSimbolos[hash(nome)];
    simbolo* i;
    if(i = buscaNome(nome, lista)){
        i->endereco = malloc(sizeof(float));
        *(float*)(i->endereco) = valor;
    }
}

void remover(const char* nome, simbolo** lista){
    simbolo* iterador;
    simbolo* anterior;
    if(*lista != NULL)
    {
        anterior = *lista;
        iterador = (*lista)->prox;

        // remover no inicio da lista.
        if(!strcmp((*lista)->nome, nome)){
            *lista = (*lista)->prox;
            free(anterior->endereco);
            free(anterior);
        }
        // remover no meio ou final.
        while(iterador != NULL){
            if(!strcmp(iterador->nome, nome)){
                anterior->prox = iterador->prox;
                free(iterador);
            }
            anterior = iterador;
            iterador = iterador->prox;
        }
    }
}



