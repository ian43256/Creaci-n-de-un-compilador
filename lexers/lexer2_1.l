
%{
#include <stdio.h>
%}

%option noyywrap

%%

"if"|"else"|"while"|"for"|"int"|"float"|"return" {
    printf("PALABRA_RESERVADA: %s\n", yytext);
}

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("IDENTIFICADOR: %s\n", yytext);
}

[0-9]+ {
    printf("NUMERO: %s\n", yytext);
}

[-+*/=(){};,] {
    printf("SIMBOLO: %s\n", yytext);
}

[ \t\r\n]+ {
    /* ignorar espacios */
}

. {
    printf("INVALIDO: %s\n", yytext);
}

%%

int main(void) {
    yylex();
    return 0;
}
