%{
    #include <stdio.h>
    #include <math.h>
    #include <limits.h> 
    int yylex();
    void yyerror(char *);
    extern FILE *yyin;
    extern FILE *yyout;
    extern int yylineno;
    int sym[26];
    int i = 0;
    int j = 0;
%}

/* Types */
%union
{
    char *t_str;
    int t_int;
    float t_float;
}


%token IMPORT
%token FROM
%token AS
%token SQ
%token DQ
%token ASSIGN
%token COLON
%token CLASS
%token DEF
%token INIT
%token OP
%token CP
%token SELF
%token DOT
%token COMMA
%token IF
%token ELIF
%token ELSE
%token FOR
%token IN
%token LAMBDA
%token DICT
%token ITEMS
%token SETDEFAULT

%token EQ
%token NEQ
%token LT
%token GT
%token LTEQ
%token GTEQ

%token ADD
%token SUB
%token MUL
%token DIV


%token INDENT
%token DEDENT

%token<t_float> ID
%token<t_int> INT
%token<t_float> FLOAT
%token<t_str> CLASSNAME

%left ADD SUB
%left MUL DIV

%type<t_float> calcList
%type<t_float> exp
%type<t_float> factor
%type<t_float> term
%type<t_float> num_type

%%

/************************************************************************************
                                GENERAL STATEMENTS
************************************************************************************/

root: /* empty */
    | expressions
    ;

expressions: expression
           | expressions expression
           ;

expression: string
          | import
          | assign
          | class
          | constructor
          | method
          | if
          | for
          | calcList
          | dict
          | lambda
          ;

string: SQ ID SQ
      | DQ ID DQ
      ;

block: INDENT expressions DEDENT
     ;

parameters: /* empty */
         | arg
         | parameters COMMA arg
         ;

arg: SELF
   | ID
   | INT
   ;

logical_exp: compare logical_operator compare
           ;

compare: ID
       | INT
       ;

logical_operator: EQ
                | NEQ
                | LT
                | GT
                | LTEQ
                | GTEQ
                ;

/************************************************************************************
                                IMPORT STATEMENT
************************************************************************************/

import: opt_from IMPORT ID opt_as
      ;


opt_from: /* empty */
        | FROM ID
        ;

opt_as: /* empty */
      | AS ID
      ;

/************************************************************************************
                                ASSIGN STATEMENT
************************************************************************************/

assign: ID ASSIGN num_type {sym[i] = $3; i++;}
      | ID ASSIGN string
      | SELF DOT ID ASSIGN expression
      | ID ASSIGN CLASSNAME OP parameters CP
      | ID ASSIGN ID OP parameters CP
      ;

num_type: INT {$$ = $1;}
        | FLOAT {$$ = $1;}
        ;

/************************************************************************************
                                CLASS STATEMENT
************************************************************************************/

class: CLASS CLASSNAME COLON block
     ;

/************************************************************************************
                                CONSTRUCTOR STATEMENT
************************************************************************************/

constructor: DEF INIT OP parameters CP COLON block
           ;

/************************************************************************************
                                METHOD STATEMENT
************************************************************************************/

method: DEF ID OP parameters CP COLON block
      ;

/************************************************************************************
                                IF STATEMENT
************************************************************************************/

if: IF logical_exp COLON block opt_elif opt_else
  ;

opt_elif: /* empty */
        | ELIF logical_exp COLON block
        ;

opt_else: /* empty */
        | ELSE COLON block
        ;

/************************************************************************************
                                FOR STATEMENT
************************************************************************************/

for: FOR ID IN ID COLON block
   ;


/************************************************************************************
                                CALCULUS STATEMENT
************************************************************************************/

calcList: exp {printf("Operation_result: %f\n", $1);}
        ;

exp: factor {$$ = $1;}
   | exp ADD factor {$$ = $1 + $3;}
   | exp SUB factor {$$ = $1 - $3;}
   ;


factor: term {$$ = $1;}
      | factor MUL term {$$ = $1 * $3;}
      | factor DIV factor {$$ = $1 / $3;}
      ;

term: FLOAT {$$ = $1;}
    | INT {$$ = $1;}
    | ID {$$ = sym[j]; j++;}
    ;


/************************************************************************************
                                LAMBDA STATEMENT
************************************************************************************/

lambda: LAMBDA ID COLON calcList
      ;


/************************************************************************************
                                DICTIONARY STATEMENT
************************************************************************************/

dict: dict_constructor
    | dict_items
    | dict_setdefault
    ;

dict_params: assign
           | dict_params COMMA assign
           ;

dict_constructor: ID ASSIGN DICT OP dict_params CP
                ;

dict_items: ID DOT ITEMS OP CP
          ;

dict_setdefault: ID DOT SETDEFAULT OP string COMMA string CP
               | ID DOT SETDEFAULT OP string COMMA term CP
               ;

%%

void yyerror(char *s) {
    printf("Error at line %d, %s\n", yylineno, s);
}


int main ( int argc, char **argv  ) 
{
    ++argv; --argc;
    if ( argc > 0 )
        yyin = fopen( argv[0], "r" );
    else
        yyin = stdin;
    yyout = fopen ( "output", "w" );
    int success = yyparse();
    if (success == 0)
    {
        printf("Compiled Successfully!\n");
    }   
    return 0;
}
