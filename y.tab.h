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
    IMPORT = 258,
    FROM = 259,
    AS = 260,
    SQ = 261,
    DQ = 262,
    ASSIGN = 263,
    COLON = 264,
    CLASS = 265,
    DEF = 266,
    INIT = 267,
    OP = 268,
    CP = 269,
    SELF = 270,
    DOT = 271,
    COMMA = 272,
    IF = 273,
    ELIF = 274,
    ELSE = 275,
    FOR = 276,
    IN = 277,
    LAMBDA = 278,
    DICT = 279,
    ITEMS = 280,
    SETDEFAULT = 281,
    EQ = 282,
    NEQ = 283,
    LT = 284,
    GT = 285,
    LTEQ = 286,
    GTEQ = 287,
    ADD = 288,
    SUB = 289,
    MUL = 290,
    DIV = 291,
    INDENT = 292,
    DEDENT = 293,
    ID = 294,
    INT = 295,
    FLOAT = 296,
    CLASSNAME = 297
  };
#endif
/* Tokens.  */
#define IMPORT 258
#define FROM 259
#define AS 260
#define SQ 261
#define DQ 262
#define ASSIGN 263
#define COLON 264
#define CLASS 265
#define DEF 266
#define INIT 267
#define OP 268
#define CP 269
#define SELF 270
#define DOT 271
#define COMMA 272
#define IF 273
#define ELIF 274
#define ELSE 275
#define FOR 276
#define IN 277
#define LAMBDA 278
#define DICT 279
#define ITEMS 280
#define SETDEFAULT 281
#define EQ 282
#define NEQ 283
#define LT 284
#define GT 285
#define LTEQ 286
#define GTEQ 287
#define ADD 288
#define SUB 289
#define MUL 290
#define DIV 291
#define INDENT 292
#define DEDENT 293
#define ID 294
#define INT 295
#define FLOAT 296
#define CLASSNAME 297

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 17 "parser.y" /* yacc.c:1909  */

    char *t_str;
    int t_int;
    float t_float;

#line 144 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
