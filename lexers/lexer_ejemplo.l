%{
#include <stdio.h>
%}

%option noyywrap

%%

[0-9]+          { printf("NUMERO: %s\n", yytext); }
[-+*/()]        { printf("OPERADOR: %s\n", yytext); }
[ \t\r\n]+      { /* ignorar espacios */ }
.               { printf("INVALIDO: %s\n", yytext); }

%%

int main(void) {
    yylex();
    return 0;
}