#include"tabelaSimbolos.h"
#include<stdlib.h>
#include<string.h>

unsigned int hash(const char* symbol){
    unsigned int h = 0;
    unsigned c;
    while( c = *symbol++ ) h = h * 9 ^ c;
    return h % SYM_TAB_SIZE;
}

void inserir(id* novoId, id** lista){
    novoId->prox = *lista;
    *lista = novoId;
}

void buscarInserir(const char* nomeId, id** lista){
    if(!buscaNome(nomeId, *lista)){
        id* novoId;
        novoId = malloc(sizeof(id));
        novoId->nome = nomeId;
        inserir(novoId, lista);
    }
}

id* buscaNome(const char* nome, id* lista){
    id* iterador;
    iterador = lista;
    while(iterador != NULL){
        if(!strcmp(iterador->nome, nome)){
            return iterador;
        }
        iterador = iterador->prox;
    }
    return NULL;
}

void remover(const char* nome, id** lista){
    id* iterador;
    id* anterior;
    if(*lista != NULL)
    {
        anterior = *lista;
        iterador = (*lista)->prox;

        // remover no inicio da lista.
        if(!strcmp((*lista)->nome, nome)){
            *lista = (*lista)->prox;
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



