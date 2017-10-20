#include"tabelaSimbolos.h"

unsigned int hash(char* symbol){
    unsigned int h = 0;
    unsigned c;
    while( c = *symbol++ ) h = h * 9 ^ c;
    return h % SYM_TAB_SIZE;
}

void 