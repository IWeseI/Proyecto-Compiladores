/* Mini Calculator */
/* calc.lex */

%{
#include "heading.h"
#include "y.tab.h" 
//#include "tok.h"
extern "C" int yylex();
int yyerror(char *s);
%}

digito		[0-9]
letra       [a-zA-z]
num         {digito}+
id          {letra}+

%%

"entero"    { yylval.tipo_val = new std::string(yytext); return ENTERO_Tipo; }
"sin_tipo"  { yylval.tipo_val = new std::string(yytext); return SIN_tipo; }

"sino"      { return SINO; }
"si"        { return SI; }
"mientras"  { return MIENTRAS; }
"retorno"   { return RETORNO; }
"main"      { return MAIN; }

{num}	{ yylval.int_val = atoi(yytext); return NUM; }
{id}	{ yylval.id_val = new std::string(yytext); return ID; }

"+"		{ yylval.op_val = new std::string(yytext); return ADD; }
"-"		{ yylval.op_val = new std::string(yytext); return SUB; }
"*"		{ yylval.op_val = new std::string(yytext); return MULT; }
"/"		{ yylval.op_val = new std::string(yytext); return DIV; }

"("		{ return PAR_A; }
")"		{ return PAR_C; }
"{"		{ return LLAVE_A; }
"}"		{ return LLAVE_C; }
"["		{ return COR_A; }
"]"		{ return COR_C; }

"<="    { yylval.relop_val = new std::string(yytext); return LE; }
">="    { yylval.relop_val = new std::string(yytext); return GE; }
"=="    { yylval.relop_val = new std::string(yytext); return E; }
"!="    { yylval.relop_val = new std::string(yytext); return D; }
"<"     { yylval.relop_val = new std::string(yytext); return LE; }
">"     { yylval.relop_val = new std::string(yytext); return G; }

"="    { return ASSIGN; }

";"    { return END; }
","    { return COMMA; }


[ \t]*		{}
[\n]		{ yylineno++;	}

.		{ std::cerr << "SCANNER "; yyerror(""); exit(1);	}
