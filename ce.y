
%{
#include "heading.h"
int yyerror(char *s);
extern "C" int yylex();

struct type_val{
  string* type;
  int val;
  bool array;
  bool func;
  int size;
  int args;
};



map<string, type_val> tabla;
map<string, type_val> temp;
map<string, map<string, type_val> > tabla_func;
string func_actual;
int temp_args = 0; //temp de argumentos

void insertar_simbolo(string id, type_val val);
bool buscar_simbolo(string id);
bool buscar_simbolo_func(string id);
void actualizar_simbolo(string, type_val new_val);
void insertar_simbolo_func(string id, type_val val);

%}

%union{
  int		int_val;
  string* id_val;
  string*	op_val;
  string* relop_val;
  string* tipo_val;
}

%start	programa

// %token	<int_val>	INTEGER_LITERAL
// %type	<int_val>	exp

%token <tipo_val>	ENTERO_tipo
%token <tipo_val>	SIN_tipo
%token	SINO
%token	SI
%token	MIENTRAS
%token	RETORNO
%token <id_val>	MAIN

%token <int_val>	NUM
%token <id_val>	ID

%token	ADD
%token	SUB
%token	MULT
%token	DIV

%token PAR_A
%token	PAR_C
%token	LLAVE_A
%token	LLAVE_C
%token	COR_A
%token	COR_C

%token	LE
%token	GE
%token	E
%token	D
%token	L
%token	G

%token	ASSIGN

%token	END
%token	COMMA


%%

programa: lista_declaracion
{
  cout<<"Compilado!"<<endl;
};

lista_declaracion: lista_declaracion declaracion | declaracion ;

declaracion: var_declaracion declaracion | fun_declaracion declaracion | main;

var_declaracion: ENTERO_tipo ID END
    {
      if(!buscar_simbolo(string(*$2)))
      {
        type_val t;
        t.type=$1;
        t.array=false;
        t.func=false;
        insertar_simbolo(string(*$2), t);
      }
      else
      {
        string s = string(*$2);
        yyerror(const_cast<char*>(("Variable \'" + s + "\' ya definida").c_str()));
      }
    }
 | ENTERO_tipo ID COR_A NUM COR_C END
    {
      if(!buscar_simbolo(string(*$2)))
      {
        type_val t;
        t.type=$1;
        t.array=true;
        t.func=false;
        t.size=$4;
        
        insertar_simbolo(string(*$2), t);
      }
      else
      {
        string s = string(*$2);
        yyerror(const_cast<char*>(("Variable \'" + s + "\' ya definida").c_str()));
      }
    };

//tipo: ENTERO_tipo | SIN_tipo ;

fun_declaracion: ENTERO_tipo ID PAR_A params PAR_C sent_compuesta 
    {
      if(!buscar_simbolo(string(*$2)))
      {
        type_val t;
        t.type=$1;
        t.array=false;
        t.func=true;
        tabla_func[string(*$2)] = temp;
        temp.clear();
        t.args = temp_args;
        insertar_simbolo(string(*$2), t);
        temp_args = 0;
      }
      else
      {
        string s = string(*$2);
        yyerror(const_cast<char*>(("Funcion \'" + s + "\' ya definida").c_str()));
      }
    }
| SIN_tipo ID PAR_A params PAR_C sent_compuesta 
    {
      if(!buscar_simbolo(string(*$2)))
      {
        type_val t;
        t.type=$1;
        t.array=false;
        t.func=true;
        t.args = temp_args;
        tabla_func[string(*$2)] = temp;
        temp.clear();
        insertar_simbolo(string(*$2), t);
        temp_args = 0;
      }
      else
      {
        string s = string(*$2);
        yyerror(const_cast<char*>(("Funcion \'"   + s + "\' ya definida").c_str()));
      }
    };
main: ENTERO_tipo MAIN PAR_A params PAR_C sent_compuesta {
      if(!buscar_simbolo(string(*$2)))
      {
        type_val t;
        t.type=$1;
        t.array=false;
        t.func=true;
        insertar_simbolo(string(*$2), t);
        temp_args = 0;
      }
      else
      {
        yyerror(const_cast<char*>(("Funcion main ya definida")));
      }
    };

params: lista_params | SIN_tipo ;  //Crear una variable con el numero de la lista 

lista_params: lista_params COMMA param | param ;

param: ENTERO_tipo ID 
{
   if(!buscar_simbolo_func(string(*$2)))
      {
        type_val t;
        t.type=$1;
        t.array=false;
        t.func=false;
        insertar_simbolo_func(string(*$2), t);
        temp_args++;
      }
      else
      {
        string s = string(*$2);
        yyerror(const_cast<char*>(("Variable \'" + s + "\' ya definida").c_str()));
      }
} | ENTERO_tipo ID COR_A COR_C 
{

   if(!buscar_simbolo_func(string(*$2)))
      {
        type_val t;
        t.type=$1;
        t.array=false;
        t.func=false;
        temp_args++;
        insertar_simbolo_func(string(*$2), t);
      }
      else
      {
        string s = string(*$2);
        yyerror(const_cast<char*>(("Variable \'" + s + "\' ya definida").c_str()));
      }

}| SIN_tipo ID
{

   if(!buscar_simbolo_func(string(*$2)))
      {
        type_val t;
        t.type=$1;
        t.array=false;
        t.func=false;
        temp_args++;
        insertar_simbolo_func(string(*$2), t);
      }
      else
      {
        string s = string(*$2);
        yyerror(const_cast<char*>(("Variable \'" + s + "\' ya definida").c_str()));
      }

}; 

sent_compuesta: LLAVE_A declaracion_local lista_sentencias LLAVE_C ;

declaracion_local: declaracion_local var_declaracion_func | /* empty */;

var_declaracion_func: ENTERO_tipo ID END
      {
      if(!buscar_simbolo_func(string(*$2)))
      {
        type_val t;
        t.type=$1;
        t.array=false;
        t.func=false;
        insertar_simbolo_func(string(*$2), t);
      }
      else
      {
        string s = string(*$2);
        yyerror(const_cast<char*>(("Variable \'" + s + "\' ya definida").c_str()));
      }
    }
 | ENTERO_tipo ID COR_A NUM COR_C END
    {
      if(!buscar_simbolo_func(string(*$2)))
      {
        type_val t;
        t.type=$1;
        t.array=true;
        t.func=false;
        t.size=$4;
        
        insertar_simbolo_func(string(*$2), t);
      }
      else
      {
        string s = string(*$2);
        yyerror(const_cast<char*>(("Variable \'" + s + "\' ya definida").c_str()));
      }
    };

lista_sentencias: lista_sentencias sentencia | /* empty */ ;

sentencia: sentencia_expresion | sentencia_seleccion | sentencia_iteracion | sentencia_retorno ;

sentencia_expresion: expresion END | END ;

sentencia_seleccion: SI PAR_A expresion PAR_C sentencia SINO sentencia | SI PAR_A expresion PAR_C sentencia;

sentencia_iteracion: MIENTRAS PAR_A expresion PAR_C LLAVE_A lista_sentencias LLAVE_C ;

sentencia_retorno: RETORNO END | RETORNO expresion END ;

expresion: var ASSIGN expresion | expresion_simple ;

var: ID COR_A expresion COR_C 
    {
      if(!buscar_simbolo(string(*$1)) && !buscar_simbolo_func(string(*$1)))
      {
        /* Error */
        string s = string(*$1);
        yyerror(const_cast<char*>(("Variable \'" + s + "\' no definida").c_str()));
        // yyerror("Variable no definida!");
      }
      else if(buscar_simbolo_func(string(*$1)))
      {
        if(!temp[string(*$1)].array)
        {
          string s = string(*$1);
          yyerror(const_cast<char*>(("Uso de la variable \'" + s + "\' de modo incorrecto").c_str()));
          // yyerror("Tipo de variable incorrecto!");

        }
        else if(temp[string(*$1)].func)
        {
          string s = string(*$1);
          yyerror(const_cast<char*>(("Uso de la variable \'" + s + "\' de modo incorrecto").c_str()));
          // yyerror("Tipo de variable incorrecto!");
        }
      }
      else if(buscar_simbolo(string(*$1)))
      {
        if(!tabla[string(*$1)].array)
        {
          string s = string(*$1);
          yyerror(const_cast<char*>(("Uso de la variable \'" + s + "\' de modo incorrecto").c_str()));
          // yyerror("Tipo de variable incorrecto!");

        }
        else if(tabla[string(*$1)].func)
        {
          string s = string(*$1);
          yyerror(const_cast<char*>(("Uso de la variable \'" + s + "\' de modo incorrecto").c_str()));
          // yyerror("Tipo de variable incorrecto!");
        }
      }
    }
| ID 
    {
      if(!buscar_simbolo(string(*$1)) && !buscar_simbolo_func(string(*$1)))
      {
        /* Error */
        string s = string(*$1);
        yyerror(const_cast<char*>(("Variable \'" + s + "\' no definida").c_str()));
        // yyerror("Variable no definida!");
      }else if(buscar_simbolo_func(string(*$1))){
        if(temp[string(*$1)].array)
        {
          string s = string(*$1);
          yyerror(const_cast<char*>(("Uso de la variable \'" + s + "\' de modo incorrecto").c_str()));
          // yyerror("Tipo de variable incorrecto!");

        }
        else if(temp[string(*$1)].func)
        {
          string s = string(*$1);
          yyerror(const_cast<char*>(("Uso de la variable \'" + s + "\' de modo incorrecto").c_str()));
          // yyerror("Tipo de variable incorrecto!");
        }
      }
      else if(buscar_simbolo(string(*$1))){
        if(tabla[string(*$1)].array)
        {
          string s = string(*$1);
          yyerror(const_cast<char*>(("Uso de la variable \'" + s + "\' de modo incorrecto").c_str()));
          // yyerror("Tipo de variable incorrecto!");

        }
        else if(tabla[string(*$1)].func)
        {
          string s = string(*$1);
          yyerror(const_cast<char*>(("Uso de la variable \'" + s + "\' de modo incorrecto").c_str()));
          // yyerror("Tipo de variable incorrecto!");
        }
      }
      
    };

expresion_simple: expresion_aditiva relop expresion_aditiva | expresion_aditiva ;

relop: L | LE | G | GE | E | D ;

expresion_aditiva: expresion_aditiva addop term | term ;

addop: ADD | SUB ;

term: term mulop factor | factor ;

mulop: MULT | DIV ;

factor: PAR_A expresion PAR_C | var | call | NUM ;

call: ID PAR_A args PAR_C 
    {
      if(!buscar_simbolo(string(*$1)))
      {
        /* Error */
        yyerror(const_cast<char*>("Variable no definido!"));
      }
      else if(tabla[string(*$1)].array)
      {
        yyerror(const_cast<char*>("Tipo de variable incorrecto!"));
      }
      else if(!tabla[string(*$1)].func)
      {
        yyerror(const_cast<char*>("Tipo de variable incorrecto!"));
      }
      else if (tabla[string(*$1)].args != temp_args)
      {
        string s = string(*$1);
        yyerror(const_cast<char*>(("Fallo en el ingreso de argumentos de " + s +"()").c_str()));
      }

      temp_args = 0;
      /*

      llamar a los paramatros de la funcion ID y verificar con lo que tenemos de args
      
      */
    };

args: 

lista_arg 
{
}
| /* empty */ 
{

}
;  

// definir si esta es vacia o no, y ademas, traer el tipo

lista_arg: 

lista_arg COMMA expresion 
{
  temp_args++;
}
| expresion 
{
  temp_args++;
}
;

%%

int yyerror(string s)
{
  extern int yylineno;	// defined and maintained in lex.c
  // extern char *yytext;	// defined and maintained in lex.c
  
  cerr << "ERROR: " << s  << " en la linea " << yylineno << endl;
  exit(1);
}

int yyerror(char *s)
{
  return yyerror(string(s));
}

void insertar_simbolo(string id, type_val val)
{
  tabla[id]=val;
}

void insertar_simbolo_func(string id, type_val val)
{
  temp[id]=val;
}

bool buscar_simbolo(string id)
{
  return tabla.find(id)!=tabla.end();
}
bool buscar_simbolo_func(string id)
{
  return temp.find(id)!=temp.end();
}