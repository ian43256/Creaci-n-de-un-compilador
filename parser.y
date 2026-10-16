%code requires {
    typedef enum { N_NUMERO, N_SUMA, N_RESTA, N_MULT, N_DIV } NodeType;

    typedef struct ASTNode {
        NodeType tipo;
        int valor;
        struct ASTNode *izq;
        struct ASTNode *der;
    } ASTNode;

    ASTNode* crear_nodo_numero(int v);
    ASTNode* crear_nodo_operacion(NodeType t, ASTNode* i, ASTNode* d);
    void imprimir_arbol(ASTNode* nodo, int nivel);
    void liberar_arbol(ASTNode* nodo);
}

%code {
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

ASTNode* raiz = NULL;
}

%union {
    int val_int;
    struct ASTNode* nodo;
}

%token <val_int> NUMERO
%type <nodo> expresion programa

%left '+' '-'
%left '*' '/'

%%

programa:
    expresion { raiz = $1; $$ = $1; }
    ;

expresion:
      NUMERO                  { $$ = crear_nodo_numero($1); }
    | expresion '+' expresion { $$ = crear_nodo_operacion(N_SUMA,  $1, $3); }
    | expresion '-' expresion { $$ = crear_nodo_operacion(N_RESTA, $1, $3); }
    | expresion '*' expresion { $$ = crear_nodo_operacion(N_MULT,  $1, $3); }
    | expresion '/' expresion { $$ = crear_nodo_operacion(N_DIV,   $1, $3); }
    | '(' expresion ')'       { $$ = $2; }
    ;

%%

ASTNode* crear_nodo_numero(int v) {
    ASTNode* n = (ASTNode*)malloc(sizeof(ASTNode));
    n->tipo = N_NUMERO;
    n->valor = v;
    n->izq = n->der = NULL;
    return n;
}

ASTNode* crear_nodo_operacion(NodeType t, ASTNode* i, ASTNode* d) {
    ASTNode* n = (ASTNode*)malloc(sizeof(ASTNode));
    n->tipo = t;
    n->valor = 0;
    n->izq = i;
    n->der = d;
    return n;
}

void imprimir_arbol(ASTNode* nodo, int nivel) {
    if (nodo == NULL) return;
    for (int i = 0; i < nivel; i++) printf("  ");

    if (nodo->tipo == N_NUMERO) {
        printf("Numero: %d\n", nodo->valor);
    } else {
        printf("Operacion: ");
        switch (nodo->tipo) {
            case N_SUMA:  printf("+\n"); break;
            case N_RESTA: printf("-\n"); break;
            case N_MULT:  printf("*\n"); break;
            case N_DIV:   printf("/\n"); break;
            default: break;
        }
        imprimir_arbol(nodo->izq, nivel + 1);
        imprimir_arbol(nodo->der, nivel + 1);
    }
}

void liberar_arbol(ASTNode* nodo) {
    if (nodo == NULL) return;
    liberar_arbol(nodo->izq);
    liberar_arbol(nodo->der);
    free(nodo);
}

void yyerror(const char *s) {
    fprintf(stderr, "Error sintactico: %s\n", s);
}