/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INTEGER_LITERAL = 258,
    ENTERO_tipo = 259,
    SIN_tipo = 260,
    SINO = 261,
    SI = 262,
    MIENTRAS = 263,
    RETORNO = 264,
    MAIN = 265,
    NUM = 266,
    ID = 267,
    ADD = 268,
    SUB = 269,
    MULT = 270,
    DIV = 271,
    PAR_A = 272,
    PAR_C = 273,
    LLAVE_A = 274,
    LLAVE_C = 275,
    COR_A = 276,
    COR_C = 277,
    LE = 278,
    GE = 279,
    E = 280,
    D = 281,
    L = 282,
    G = 283,
    ASSIGN = 284,
    END = 285,
    COMMA = 286
  };
#endif
/* Tokens.  */
#define INTEGER_LITERAL 258
#define ENTERO_tipo 259
#define SIN_tipo 260
#define SINO 261
#define SI 262
#define MIENTRAS 263
#define RETORNO 264
#define MAIN 265
#define NUM 266
#define ID 267
#define ADD 268
#define SUB 269
#define MULT 270
#define DIV 271
#define PAR_A 272
#define PAR_C 273
#define LLAVE_A 274
#define LLAVE_C 275
#define COR_A 276
#define COR_C 277
#define LE 278
#define GE 279
#define E 280
#define D 281
#define L 282
#define G 283
#define ASSIGN 284
#define END 285
#define COMMA 286

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 22 "calc.y"

  int		int_val;
  string* id_val;
  string*	op_val;
  string* relop_val;
  string* tipo_val;

#line 127 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
