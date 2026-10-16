%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"
%}

%option noyywrap

%%

[0-9]+      { yylval.val_int = atoi(yytext); return NUMERO; }
[ \t\r]+    { /* ignorar espacios */ }
\n          { return 0; }
[-+*/()]    { return yytext[0]; }
.           { fprintf(stderr, "Caracter invalido: %s\n", yytext); }

%%