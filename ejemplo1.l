%{
#include <math.h>
#include <stdio.h>
int line = 1;
%}

DIGITO [0-9]
LETRA [a-zA-z]
NL [\n\r]
DIGITOS {DIGITO}+

%%
\r?\n                                      { ++line; printf("\n");}
"if"                                      printf("<IF> ");
"else"                                    printf("<ELSE> ");
"("                                       printf("<PAR_BEGIN> ");
")"                                       printf("<PAR_END> ");
"<"|">"|"<="|">="|"=="                    printf("<REL_OP, \'%s\'> ", yytext);
"="                                       printf("<ASSIGN_OP> ");
"/"                                       printf("<DIV_OP> ");
"^"                                       printf("<EXP_OP> ");
"*"                                       printf("<MUL_OP> ");
"+"                                       printf("<SUM_OP> ");
"-"                                       printf("<RES_OP> ");
{LETRA}({LETRA}|{DIGITO})*                printf( "<ID, %s> ", yytext);
{DIGITOS}(.{DIGITOS})?(E[+-]?{DIGITOS})?  printf( "<NUMBER, %s> ", yytext );



[ \t]+
.                                         printf( "Error en la linea %d, caracter %s no soportado ", line, yytext );
%%
