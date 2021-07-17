/* Mini Calculator */
/* calc.lex */

%{
// #include <stdlib.h>
// #include <stdio.h>
#include "heading.h"
//#include "y.tab.h" 
//#include "tok.h"
extern "C" int yylex();
int yyerror(char *s);
%}

digito		[0-9]
letra       [a-zA-z]
num         {digito}+
id          {letra}+

%%

"entero"    { printf("ENTERO_Tipo "); }
"sin_tipo"  { printf("SIN_tipo "); }

"sino"      { printf("SINO "); }
"si"        { printf("SI "); }
"mientras"  { printf("MIENTRAS "); }
"retorno"   { printf("RETORNO "); }
"main"      { printf("MAIN "); }

"+"		{ printf("ADD "); }
"-"		{ printf("SUB "); }
"*"		{ printf("MULT "); }
"/"		{ printf("DIV "); }

"("		{ printf("PAR_A "); }
")"		{ printf("PAR_C "); }
"{"		{ printf("LLAVE_A "); }
"}"		{ printf("LLAVE_C "); }
"["		{ printf("COR_A "); }
"]"		{ printf("COR_C "); }

"<="    { printf("LE "); }
">="    { printf("GE "); }
"=="    { printf("E "); }
"!="    { printf("D "); }
"<"     { printf("LE "); }
">"     { printf("G "); }

"="    { printf("ASSIGN "); }

";"    { printf("END "); }
","    { printf("COMMA "); }

{num}	{ printf("NUM "); }
{id}	{ printf("ID "); }

[ \t]*		{}
[\n]		{ yylineno++;	}

.		{ printf("Error ");	}
%%