#define SYM_TAB_SIZE 999


enum tipo {inteiro, real, logico, caractere, literal, funcao};

// estrutura de um identificador na tabela de simbolos.
struct id{
    enum tipo tipoId;
    const char* nome;
    void* endereco;
    struct id* prox;
};
typedef struct id id;


// estrutura de valor de um token.
struct tokenVal{
    int inteiro;          // para literais inteiros.
    float real;           // para literais reais.
    char caractere;       // para literais de caractere.
    const char* literal;  // para literais de literais.
    const char* nome;     // para identificadores.
};
typedef struct tokenVal YYSTYPE;
#ifndef YYSTYPE_IS_DECLARED
    #define YYSTYPE_IS_DECLARED 1
#endif

// declaração da tabela de simbolos.
#ifndef tabelaSimbolos
    id* tabelaSimbolos[SYM_TAB_SIZE];
#else
    extern id* tabelaSimbolos[SYM_TAB_SIZE];
#endif


void inserir(id* novoId, id** lista);               // insere novo nó em uma lista de identificadores (função só deve ser usada internamente).
void remover(const char* nome, id** lista);         // remove um nó na lista que tenha o nome correspondente.
id* buscaNome(const char* nome, id* lista);         // retorna um ponteiro para o nó que contem o nome buscado.
void buscarInserir(const char* nome, id** lista);   // busca por um nome na lista e se não for encontrado, insere um nó com o nome no inicio da lista.
unsigned int hash(const char*);                     // embaralha os bits do nome e retorna um indice da tabela de simbolos.


