#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"

extern ASTNode* raiz;
int yyparse(void);

int main(void) {
    printf("Escribe una expresion (ej. 2+3*(4-1)) y presiona Enter:\n");
    if (yyparse() == 0) {
        printf("\nArbol de sintaxis abstracta:\n");
        imprimir_arbol(raiz, 0);

        exportar_dot(raiz, "arbol.dot");
        int r = system("\"C:\\Program Files (x86)\\Graphviz\\bin\\dot.exe\" -Tpng arbol.dot -o arbol.png");
        if (r == 0) {
            printf("\nImagen generada: arbol.png\n");
        } else {
            printf("\nNo se pudo generar el PNG. Verifica que Graphviz este instalado (dot -V).\n");
        }

        liberar_arbol(raiz);
    }
    return 0;
}