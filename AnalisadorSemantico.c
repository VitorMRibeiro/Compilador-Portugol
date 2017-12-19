#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include"ArvoreSintatica.h"

node* algoritmo;
extern void yyparse();
extern void yyerror(const char* s);
int treeWalker(node* root, const char* escopo);

int matrizCoercao[][5] = {
    {0, 1, -1, 3, -1},
    {1, 1, -1, 3, -1},
    {-1, -1, 2, 3, -1},
    {3, 3, 3, 3, -1},
    {-1, -1, -1, -1, -1}
};

int matrizCoercaoAtribuicao[][5] = {
    {1, 1, 0, 0, 0},
    {1, 1, 0, 0, 0},
    {0, 0, 1, 1, 0},
    {0, 0, 0, 1, 0},
    {0, 0, 0, 0, 1}
};

int main(int argc, char** argv){
    algoritmo = malloc(sizeof(node));

    memset(tabelaSimbolos, 0, sizeof(simbolo*) * SYM_TAB_SIZE); // inicializa tabela de simbolos com NULL.
    yyparse();

    treeWalker(algoritmo, "algoritmo");

}

int treeWalker(node* root, const char* escopo){
    if( root != NULL ){
        switch (root->tipo){
            case se:
                treeWalker( ((struct se*) root)->condicao, escopo );
                treeWalker( ((struct se*) root)->se, escopo );
                treeWalker( ((struct se*) root)->senao, escopo );
                break;
            case enquanto:
                treeWalker( ((struct enquanto*) root)->condicao, escopo );
                treeWalker( ((struct enquanto*) root)->corpo, escopo );
                break; 
            case para:
                treeWalker( ((struct para*) root)->corpo, escopo );
                break; 
            case soma:
                {
                    int left = treeWalker( root->left, escopo );
                    int right = treeWalker( root->right, escopo );                   
                    if( matrizCoercao[left][right] != -1 ){
                        return matrizCoercao[left][right];
                    }                   
                    else{
                        printf("Erro: tipos invalidos para a operacao '+', linha %d\n", root->linha);
                    }
                }
                break; 
            case subtracao:
            {
                int left = treeWalker( root->left, escopo );
                int right = treeWalker( root->right, escopo );
                if( matrizCoercao[left][right] != -1 ){
                    return matrizCoercao[left][right];
                }                   
                else{
                    printf("Erro: tipos invalidos para a operacao '-', linha %d\n", root->linha);
                }
            }
                break; 
            case multiplicacao:
                {
                    int left = treeWalker( root->left, escopo );
                    int right = treeWalker( root->right, escopo );                   
                    if( left == var_inteiro && right == var_inteiro ){
                        return var_inteiro;
                    }
                    if( left == var_real && right == var_inteiro){
                        return var_real;
                    }
                    if( left == var_inteiro && right == var_real){
                        return var_real;
                    }
                    if( left == var_real && right == var_real ){
                        return var_real;
                    }
                    printf("Erro: tipos invalidos para a operacao '*', linha %d\n", root->linha);
                }
                break;
            case divisao:
                {
                    int left = treeWalker( root->left, escopo );
                    int right = treeWalker( root->right, escopo );                   
                    if( left == var_inteiro && right == var_inteiro ){
                        return var_inteiro;
                    }
                    if( left == var_real && right == var_inteiro){
                        return var_real;
                    }
                    if( left == var_inteiro && right == var_real){
                        return var_real;
                    }
                    if( left == var_real && right == var_real ){
                        return var_real;
                    }
                    printf("Erro: tipos invalidos para a operacao '/', linha %d\n", root->linha);
                }
                break;
            case potencia:
                {
                    int left = treeWalker( root->left, escopo );
                    int right = treeWalker( root->right, escopo );                   
                    if( left == var_inteiro && right == var_inteiro ){
                        return var_inteiro;
                    }
                    if( left == var_real && right == var_inteiro){
                        return var_real;
                    }
                    if( left == var_inteiro && right == var_real){
                        return var_real;
                    }
                    if( left == var_real && right == var_real ){
                        return var_real;
                    }
                    printf("Erro: tipos invalidos para a operacao '/', linha %d\n", root->linha);
                }
                break;
            case negativo:
                {
                    int u = treeWalker( ((struct unario*) root)->corpo, escopo );
                    if( u == var_inteiro ){
                        return var_inteiro;
                    }
                    if( u == var_real){
                        return var_real;
                    }
                    printf("Erro: tipo invalido para a operacao '-'(unario), linha %d\n", root->linha);
                }
                break; 
            case inteiro:
                return var_inteiro;
                break; 
            case atribuicao:
                // TODO verificar se o tipo da expressão a direita bate com o tipo da variavel.
                {
                    int Tipolval = treeWalker( root->left, escopo );
                    int Tiporval = treeWalker( root->right, escopo );
                    if( !matrizCoercaoAtribuicao[Tiporval][Tipolval] && Tipolval != indefinido ){
                        printf("Erro: tipo da variavel nao corresponde ao tipo atribuido, linha %d\n", root->linha);
                    }
                }
                break;
            case retorne:
                // TODO verificar se o tipo de retorno bate com o declarado pela funcao.
                treeWalker( ((struct unario*) root)->corpo, escopo );
                break;
            case real:
                return var_real;
                break; 
            case caractere:
                return var_caractere;
                break; 
            case literal:
                return var_literal;
                break; 
            case variavel:
                {
                    struct IDvariavel* v;
                    if( v = (struct IDvariavel*) buscaNome( ((struct variavel*) root)->nome,escopo) ){
                        return v->var_tipo;
                    }
                    else{
                        printf("Erro: variavel '%s' nao declarada, linha %d\n", ((struct variavel*) root)->nome, root->linha);
                    }                 
                }
                break; 
            case funcao:
                {
                    struct IDfuncao* f;
                    if( f = (struct IDfuncao*)  buscaNome( ((struct funcao*) root)->nome, "algoritmo" ) ){
                        // TODO verificar se os tipos dos parametros reais batem com os formais.
                        struct parametroReal* pr = ((struct funcao*) root)->parametrosReais;
                        struct parametros* pf = f->listaParametros;
                        int i = 1;
                        // itera sobre os parametros.
                        while( pr != NULL && pf != NULL){
                            // fazer a comparacao aqui.
                            if( pr != NULL ){
                                if( pf != NULL ){
                                    if( !matrizCoercaoAtribuicao[treeWalker(pr->expr, escopo)][pf->tipo] ){
                                        printf("Erro: tipo do argumento %d da funcao '%s' nao pode ser implicitamente coagido para o tipo esperado, linha %d\n", i, ((struct funcao*) root)->nome, root->linha);
                                    }
                                }
                                else{
                                    printf("Erro: muitos argumentos para a funcao '%s', linha %d\n", ((struct funcao*) root)->nome, root->linha);
                                }
                            }
                            else{
                                printf("Erro: poucos argumentos para a funcao '%s', linha %d\n", ((struct funcao*) root)->nome, root->linha);
                            }
                            if( pr != NULL ){
                                pr = pr->prox;
                            }
                            if( pf != NULL ){
                                pf = pf->prox;
                            }
                            i++;
                        }
                        return f->tipo_retorno;
                    }
                    else{
                        printf("Erro: funcao '%s' nao definida, linha %d\n", ((struct funcao*)root)->nome, root->linha );
                    }
                }
            break;
            case igual:
                treeWalker( root->left, escopo );
                treeWalker( root->right, escopo );
                break;
            case menor:
                treeWalker( root->left, escopo );
                treeWalker( root->right, escopo );
                break;
            case maior:
                treeWalker( root->left, escopo );
                treeWalker( root->right, escopo );
                break;
            case menorIgual:
                treeWalker( root->left, escopo );
                treeWalker( root->right, escopo );
                break;
            case maiorIgual:
                treeWalker( root->left, escopo );
                treeWalker( root->right, escopo );
                break;
            case diferente:
                treeWalker( root->left, escopo );
                treeWalker( root->right, escopo );
                break;
            case bloco:
                treeWalker( root->left, escopo );
                treeWalker( root->right, escopo );
                break;
            case e:
                treeWalker( root->left, escopo );
                treeWalker( root->right, escopo );
                break;
            case ou:
                treeWalker( root->left, escopo );
                treeWalker( root->right, escopo );
                break;
            default:
                break;
        }
    }
    return indefinido;
}
