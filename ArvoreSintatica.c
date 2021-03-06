// funcoes de criacao e avaliacao da arvore sintatica
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

const char* enumToString(enum tipoNo);

void criarJS(node* no, FILE* arq, const char* nome){

    fprintf(arq, "\t\t\"name\" : \"%s\",\n", nome);
    fprintf(arq, "\t\t\"children\" : [\n");
    fprintf(arq, "\t\t{\n");
    
    imprimirArvore(no, arq);

    fprintf(arq, "\t\t}\n\t\t]");
    
}

void imprimirArvore(node* no, FILE* arq){
    if( no != NULL){
        fprintf(arq, "\t\t\"name\": \"%s\",\n", enumToString(no->tipo));
        fprintf(arq, "\t\t\"children\": [\n");
        switch(no->tipo){
            case se: 
                fprintf(arq, "\t\t{\n");
                imprimirArvore(((struct se*)no)->condicao, arq);
                fprintf(arq, "\t\t},\n");
                fprintf(arq, "\t\t{\n");
                imprimirArvore(((struct se*)no)->se, arq);
                fprintf(arq, "\t\t},\n");
                fprintf(arq, "\t\t{\n");
                imprimirArvore(((struct se*)no)->senao, arq);
                fprintf(arq, "\t\t}\n");
                break;
            case enquanto:
                fprintf(arq, "\t\t{\n");
                imprimirArvore(((struct enquanto*)no)->condicao, arq);
                fprintf(arq, "\t\t},\n");
                fprintf(arq, "\t\t{\n");
                imprimirArvore(((struct enquanto*)no)->corpo, arq);
                fprintf(arq, "\t\t}\n");
                break;
            case para:
                fprintf(arq, "\t\t{\n");
                imprimirArvore(((struct para*)no)->corpo, arq);
                fprintf(arq, "\t\t}\n");
                break;
            case inteiro:
                fprintf(arq, "\t\t{\n");
                fprintf(arq, "\t\t\"name\": \"%d\",\n", ((struct inteiro*)no)->valor, arq);
                fprintf(arq, "\t\t}\n");
                break;
            case real:
                fprintf(arq, "\t\t{\n");
                fprintf(arq, " \t\t\"name\" : \"%f\",\n ", ((struct real*)no)->valor, arq);
                fprintf(arq, "\t\t}\n");
                break;
            case literal:
                fprintf(arq, "\t\t{\n");
                fprintf(arq, " \t\t\"name\" : \"%s\",\n ", ((struct literal*)no)->valor, arq);
                fprintf(arq, "\t\t}\n");
                break;
            case caractere:
                fprintf(arq, "\t\t{\n");
                fprintf(arq, " \t\t\"name\" : \"%c\",\n ", ((struct caractere*)no)->valor, arq);
                fprintf(arq, "\t\t}\n");
                break;
            case variavel:
                fprintf(arq, "\t\t{\n");
                fprintf(arq, "\t\t\"name\" : \"%s\",\n", ((struct variavel*)no)->nome, arq);
                fprintf(arq, "\t\t}\n");
                break;
            case funcao:
                fprintf(arq, "\t\t{\n");
                fprintf(arq, "\t\t\"name\" : \"%s\",\n", ((struct funcao*)no)->nome, arq);
                fprintf(arq, "\t\t}\n");
                break;
            case negativo:
                fprintf(arq, "\t\t{\n");
                imprimirArvore(((struct unario*)no)->corpo, arq);
                fprintf(arq, "\t\t}\n");
                break;
            case retorne:
                fprintf(arq, "\t\t{\n");
                imprimirArvore(((struct unario*)no)->corpo, arq);
                fprintf(arq, "\t\t}\n");
                break;
            default:
                fprintf(arq, "\t\t{\n");
                imprimirArvore(no->left, arq);
                fprintf(arq, "\t\t},\n");
                fprintf(arq, "\t\t{\n");
                imprimirArvore(no->right, arq);
                fprintf(arq, "\t\t}\n");
                break;
        }
        fprintf(arq, "\t\t]\n");
    }
}


const char* enumToString(enum tipoNo tipo){
    switch(tipo){
        case se: 
            return "se";
            break;
        case enquanto: 
            return "enquanto";
            break; 
        case para: 
            return "para";
            break; 
        case soma: 
            return "soma";
            break; 
        case subtracao: 
            return "subtracao";
            break; 
        case multiplicacao: 
            return "multiplicacao";
            break;
        case divisao: 
            return "divisao";
            break;
        case potencia: 
            return "potencia";
            break;
        case negativo: 
            return "negativo";
            break; 
        case inteiro: 
            return "inteiro";
            break; 
        case atribuicao: 
            return "atribuicao";
            break;
        case retorne: 
            return "retorne";
            break;
        case real: 
            return "real";
            break; 
        case caractere: 
            return "caractere";
            break; 
        case literal: 
            return "literal";
            break; 
        case variavel: 
            return "variavel";
            break; 
        case funcao: 
            return "funcao";
            break;
        case igual: 
            return "igual";
            break;
        case menor: 
            return "menor";
            break;
        case maior: 
            return "maior";
            break;
        case menorIgual: 
            return "menorIgual";
            break;
        case maiorIgual: 
            return "maiorIgual";
            break;
        case diferente: 
            return "diferente";
            break;
        case bloco:
            return "bloco";
            break;
        defaul:
            return "bad node type";
    }
}