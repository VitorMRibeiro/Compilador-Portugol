#define SYM_TAB_SIZE 999

enum tipo {inteiro, real, logico, caractere};

struct var{
    enum tipo tipoVar;
    char* nome;
    void* endereco;
    struct var* prox;
};
typedef struct var var;

var* buscaNome(char*);
void inserir(var*);
void remover(char*);

#ifndef tabelaSimbolos
    var* tabelaSimbolos[SYM_TAB_SIZE];
#else
    extern var* tabelaSimbolos[SYM_TAB_SIZE];
#endif