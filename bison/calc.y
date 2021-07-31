/* Mini Calculator */
/* calc.y */

%{
#include "heading.h"
int yyerror(char *s);
extern "C" int yylex();

struct type_val{
  int type;
  int val;
};

map<string, type_val> tabla;

void insertar_simbolo(string id, type_val val);
bool buscar_simbolo(string id);
void actualizar_simbolo(string, type_val new_val);

%}

%union{
  int		int_val;
  string* id_val;
  string*	op_val;
  string* relop_val;
  string* tipo_val;
}

%start	programa

%token	<int_val>	INTEGER_LITERAL
%type	<int_val>	exp

%left	ENTERO_tipo
%left	SIN_tipo
%left	SINO
%left	SI
%left	MIENTRAS
%left	RETORNO
%left	MAIN

%left	NUM
%left	ID

%left	ADD
%left	SUB
%left	MULT
%left	DIV

%left PAR_A
%left	PAR_C
%left	LLAVE_A
%left	LLAVE_C
%left	COR_A
%left	COR_C

%left	LE
%left	GE
%left	E
%left	D
%left	L
%left	G

%left	ASSIGN

%left	END
%left	COMMA


%%

programa: lista_declaracion;

lista_declaracion: lista_declaracion declaracion | declaracion ;

declaracion: var_declaracion | fun_declaracion ;

var_declaracion: ENTERO_tipo ID END | ENTERO_tipo ID COR_A NUM COR_C END ;

tipo: ENTERO_tipo | SIN_tipo ;

fun_declaracion: tipo ID PAR_A params PAR_C sent_compuesta ;

params: lista_params | SIN_tipo ;

lista_params: lista_params COMMA param | param ;

param: tipo ID | tipo ID COR_A COR_C ;

sent_compuesta: LLAVE_A declaracion_local lista_sentencias LLAVE_C ;

declaracion_local: declaracion_local var_declaracion | /* empty */ ;

lista_sentencias: lista_sentencias sentencia | /* empty */ ;

sentencia: sentencia_expresion | sentencia_seleccion | sentencia_iteracion | sentencia_retorno ;

sentencia_expresion: expresion END | END ;

sentencia_seleccion: SI PAR_A expresion PAR_C sentencia | SI PAR_A expresion PAR_C sentencia SINO sentencia ;

sentencia_iteracion: MIENTRAS PAR_A expresion PAR_C LLAVE_A lista_sentencias LLAVE_C ;

sentencia_retorno: RETORNO END | RETORNO expresion END ;

expresion: var ASSIGN expresion | expresion_simple ;

var: ID | ID COR_A expresion COR_C ;

expresion_simple: expresion_aditiva relop expresion_aditiva | expresion_aditiva ;

relop: L | LE | G | GE | E | D ;

expresion_aditiva: expresion_aditiva addop term | term ;

addop: ADD | SUB ;

term: term mulop factor | factor ;

mulop: MULT | DIV ;

factor: PAR_A expresion PAR_C | var | call | NUM ;

call: ID PAR_A args PAR_C ;

args: lista_arg | /* empty */ ;

lista_arg: lista_arg COMMA expresion | expresion ;

%%

int yyerror(string s)
{
  extern int yylineno;	// defined and maintained in lex.c
  extern char *yytext;	// defined and maintained in lex.c
  
  cerr << "ERROR: " << s << " at symbol \"" << yytext;
  cerr << "\" on line " << yylineno << endl;
  exit(1);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}

void insertar_simbolo(string id, type_val val){
  tabla[id]=val;
}

bool buscar_simbolo(string id){
  return tabla.find(id)!=tabla.end();
}

