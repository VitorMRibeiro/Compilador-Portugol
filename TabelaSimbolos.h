#define SYM_TAB_SIZE 999

enum tipo {inteiro, real, logico, caractere, literal, funcao};

struct id{
    enum tipo tipoVar;
    char* nome;
    void* endereco;
    struct id* prox;
};
typedef struct id id;

void inserir(id*);
void remover(const char*);
id* buscaNome(const char*);
unsigned int hash(const char*);

#ifndef tabelaSimbolos
    id* tabelaSimbolos[SYM_TAB_SIZE];
#else
    extern var* tabelaSimbolos[SYM_TAB_SIZE];
#endif