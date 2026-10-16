#include <stdio.h>
#include "parser.tab.h"

extern ASTNode* raiz;
int yyparse(void);

int main(void) {
    printf("Escribe una expresion (ej. 2+3*(4-1)) y presiona Enter:\n");
    if (yyparse() == 0) {
        printf("\nArbol de sintaxis abstracta:\n");
        imprimir_arbol(raiz, 0);
        liberar_arbol(raiz);
    }
    return 0;
}
