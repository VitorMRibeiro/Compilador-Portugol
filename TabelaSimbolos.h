#define SYM_TAB_SIZE 999

enum tipo {inteiro, real, logico, caractere, literal, funcao};

struct id{
    enum tipo tipoVar;
    const char* nome;
    void* endereco;
    struct id* prox;
};
typedef struct id id;

void inserir(id* novoId, id** lista);
void remover(const char* nome, id** lista);
id* buscaNome(const char* nome, id* lista);
void buscarInserir(const char* nome, id** lista);
unsigned int hash(const char*);

#ifndef tabelaSimbolos
    id* tabelaSimbolos[SYM_TAB_SIZE];
#else
    extern id* tabelaSimbolos[SYM_TAB_SIZE];
#endif