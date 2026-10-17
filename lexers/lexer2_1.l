
%{
#include <stdio.h>
%}

%option noyywrap

%{
extern FILE *yyin;
extern FILE *yyout;
%}

%%

"if"|"else"|"while"|"for"|"int"|"float"|"return" {
    fprintf(yyout, "PALABRA_RESERVADA: %s\n", yytext);
}

[a-zA-Z_][a-zA-Z0-9_]* {
    fprintf(yyout, "IDENTIFICADOR: %s\n", yytext);
}

[0-9]+ {
    fprintf(yyout, "NUMERO: %s\n", yytext);
}

[-+*/=(){};,] {
    fprintf(yyout, "SIMBOLO: %s\n", yytext);
}

[ \t\r\n]+ {
    /* Ignorar espacios */
}

. {
    fprintf(yyout, "INVALIDO: %s\n", yytext);
}

%%

int main(void) {
    yyin = fopen("programa.txt", "r");

    if (yyin == NULL) {
        printf("Error: no se pudo abrir programa.txt\n");
        return 1;
    }

    yyout = fopen("out.txt", "w");

    if (yyout == NULL) {
        printf("Error: no se pudo crear out.txt\n");
        fclose(yyin);
        return 1;
    }

    yylex();

    fclose(yyin);
    fclose(yyout);

    printf("Analisis terminado. Revisa out.txt\n");

    return 0;
}
