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
    BEG = 258,
    END = 259,
    ASSIGN = 260,
    TO = 261,
    PRINT = 262,
    SCAN = 263,
    COMMA = 264,
    OPEN = 265,
    CLOSE = 266,
    IF = 267,
    ENDIF = 268,
    THEN = 269,
    ELSE = 270,
    WHILE = 271,
    ENDWHILE = 272,
    DO = 273,
    RETURN = 274,
    ENDELSE = 275,
    START_PROCEDURE = 276,
    END_FUNCTION = 277,
    ENDDOWHILE = 278,
    FOR = 279,
    REPEAT = 280,
    ENDFOR = 281,
    FROM = 282,
    READ = 283,
    QUOTE = 284,
    VAR = 285,
    NUM = 286,
    DATATYPE = 287,
    RELOP = 288,
    LOGOP = 289,
    BOOL = 290,
    MD = 291,
    AS = 292,
    Q = 293,
    NAME_PROCEDURE = 294
  };
#endif
/* Tokens.  */
#define BEG 258
#define END 259
#define ASSIGN 260
#define TO 261
#define PRINT 262
#define SCAN 263
#define COMMA 264
#define OPEN 265
#define CLOSE 266
#define IF 267
#define ENDIF 268
#define THEN 269
#define ELSE 270
#define WHILE 271
#define ENDWHILE 272
#define DO 273
#define RETURN 274
#define ENDELSE 275
#define START_PROCEDURE 276
#define END_FUNCTION 277
#define ENDDOWHILE 278
#define FOR 279
#define REPEAT 280
#define ENDFOR 281
#define FROM 282
#define READ 283
#define QUOTE 284
#define VAR 285
#define NUM 286
#define DATATYPE 287
#define RELOP 288
#define LOGOP 289
#define BOOL 290
#define MD 291
#define AS 292
#define Q 293
#define NAME_PROCEDURE 294

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 65 "yaccfile.y"

char code[100];

#line 139 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
