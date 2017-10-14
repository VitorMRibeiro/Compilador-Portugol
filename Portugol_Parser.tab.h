/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

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

#ifndef YY_YY_PORTUGOL_PARSER_TAB_H_INCLUDED
# define YY_YY_PORTUGOL_PARSER_TAB_H_INCLUDED
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
    FIM_VARIAVEIS = 258,
    CARACTERE = 259,
    FALSO = 260,
    SE = 261,
    FACA = 262,
    FIM_PARA = 263,
    LITERAIS = 264,
    ALGORITMO = 265,
    LITERAL = 266,
    FIM = 267,
    SENAO = 268,
    FIM_ENQUANTO = 269,
    MATRIZ = 270,
    LOGICOS = 271,
    VARIAVEIS = 272,
    LOGICO = 273,
    OU = 274,
    ENTAO = 275,
    PARA = 276,
    INTEIROS = 277,
    FUNCAO = 278,
    INTEIRO = 279,
    INICIO = 280,
    E = 281,
    FIM_SE = 282,
    DE = 283,
    REAIS = 284,
    RETORNE = 285,
    REAL = 286,
    VERDADEIRO = 287,
    NAO = 288,
    ENQUANTO = 289,
    ATE = 290,
    CARACTERES = 291,
    PASSO = 292,
    MAIS = 293,
    SUB = 294,
    DIV = 295,
    MUL = 296,
    IDENTIFICADOR = 297,
    ERRO = 298
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PORTUGOL_PARSER_TAB_H_INCLUDED  */
