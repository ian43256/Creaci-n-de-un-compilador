
%{
#include <stdio.h>
#include <stdlib.h>
#include "parser.tab.h"

static int columna = 1;
static int col_inicio = 1;

#define YY_USER_ACTION col_inicio = columna; columna += yyleng;
%}

%option noyywrap

%%

[0-9]+      { yylval.val_int = atoi(yytext); return NUMERO; }
[ \t\r]+    { /* ignorar espacios */ }
\n          { columna = 1; return 0; }
[-+*/()]    { return yytext[0]; }
.           { fprintf(stderr, "Caracter invalido: %s\n", yytext); }

%%
