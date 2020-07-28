%{
    #include "y.tab.h"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <limits.h> 

    struct StackNode { 
        int data; 
        struct StackNode* next; 
    }; 
    
    struct StackNode* newNode(int data);
    int isEmpty(struct StackNode* root);
    void push(struct StackNode** root, int data);
    int pop(struct StackNode** root);
    int peek(struct StackNode* root);

    struct StackNode* stack = NULL;
    
    
%}

%x LINESTART
%s NORMAL

%option noyywrap
%option yylineno

id                          [_a-zA-Z][_a-zA-Z0-9]*
className                   [A-Z][a-zA-Z0-9]*
integer                     [0-9]+
float                       {integer}\.{integer}
singleQuote                 \'\'\'(.|[\r\n])*\'\'\'
doubleQuote                 \"\"\"(.|[\r\n])*\"\"\"

%%


<INITIAL>.*|\n              {
                                yyless(0);
                                BEGIN(LINESTART);
                                push(&stack, 0);
                            }
                            
<LINESTART>[ \t]*           {
                                int depth = yyleng;
                                
                                if (depth < peek(stack))
                                {
                                    pop(&stack);
                                    yyless(0);
                                    return DEDENT;
                                }
                                
                                BEGIN(NORMAL);
                                
                                if (depth > peek(stack))
                                {
                                    push(&stack, depth);
                                    printf("INDENT\n");
                                    return INDENT;
                                }
                            }
                            
<LINESTART>.                { 
                                yyless(0);
                                
                                if (peek(stack) > 0)
                                {
                                    pop(&stack);
                                    printf("DEDENT\n");
                                    return DEDENT;
                                }
                                
                                BEGIN(NORMAL);
                            }
                            
<LINESTART><<EOF>>          {
                                if (peek(stack) > 0)
                                {
                                    pop(&stack);
                                    printf("DEDENT\n");
                                    return DEDENT;
                                }
                                
                                BEGIN(NORMAL);
                            }
       
\n                          {   
                                BEGIN(LINESTART);
                            }


"import"                    {printf("%s\n", yytext); return IMPORT;}
"from"                      {printf("%s\n", yytext); return FROM;}
"as"                        {printf("%s\n", yytext); return AS;}
"="                         {printf("%s\n", yytext); return ASSIGN;}
"'"                         {printf("%s\n", yytext); return SQ;}
\"                          {printf("%s\n", yytext); return DQ;}
":"                         {printf("%s\n", yytext); return COLON;}
"class"                     {printf("%s\n", yytext); return CLASS;}
"def"                       {printf("%s\n", yytext); return DEF;}
"__init__"                  {printf("%s\n", yytext); return INIT;}
"("                         {printf("%s\n", yytext); return OP;}
")"                         {printf("%s\n", yytext); return CP;}
"self"                      {printf("%s\n", yytext); return SELF;}
"."                         {printf("%s\n", yytext); return DOT;}
","                         {printf("%s\n", yytext); return COMMA;}
"if"                        {printf("%s\n", yytext); return IF;}
"elif"                      {printf("%s\n", yytext); return ELIF;}
"else"                      {printf("%s\n", yytext); return ELSE;}
"for"                       {printf("%s\n", yytext); return FOR;}
"in"                        {printf("%s\n", yytext); return IN;}
"lambda"                    {printf("%s\n", yytext); return LAMBDA;}
"dict"                      {printf("%s\n", yytext); return DICT;}
"items"                     {printf("%s\n", yytext); return ITEMS;}
"setdefault"                {printf("%s\n", yytext); return SETDEFAULT;}

"=="                        {printf("%s\n", yytext); return EQ;}
"!="                        {printf("%s\n", yytext); return NEQ;}
"<"                         {printf("%s\n", yytext); return LT;}
">"                         {printf("%s\n", yytext); return GT;}
"<="                        {printf("%s\n", yytext); return LTEQ;}
">="                        {printf("%s\n", yytext); return GTEQ;}

"+"                         {printf("%s\n", yytext); return ADD;}
"-"                         {printf("%s\n", yytext); return SUB;}
"*"                         {printf("%s\n", yytext); return MUL;}
"/"                         {printf("%s\n", yytext); return DIV;}

#.*                         {printf("SingleLineComments\n");}
{singleQuote}               {printf("SingleQuoteComments\n");}
{doubleQuote}               {printf("DoubleQuoteComments\n");}


{className}                 {printf("%s\n", yytext); yylval.t_str = strdup(yytext); return CLASSNAME;}
{id}                        {printf("%s\n", yytext); yylval.t_str = strdup(yytext); return ID;}
{integer}                   {printf("%s\n", yytext); yylval.t_int = atoi(yytext); return INT;}
{float}                     {printf("%s\n", yytext); yylval.t_float = atof(yytext); return FLOAT;}



%%

struct StackNode* newNode(int data) 
{ 
    struct StackNode* stackNode = (struct StackNode*)malloc(sizeof(struct StackNode)); 
    stackNode->data = data; 
    stackNode->next = NULL; 
    return stackNode; 
} 

int isEmpty(struct StackNode* root) 
{ 
    return !root; 
} 

void push(struct StackNode** root, int data) 
{ 
    struct StackNode* stackNode = newNode(data); 
    stackNode->next = *root; 
    *root = stackNode; 
} 

int pop(struct StackNode** root) 
{ 
    if (isEmpty(*root))
    {
        return INT_MIN; 
    }
    struct StackNode* temp = *root; 
    *root = (*root)->next; 
    int popped = temp->data; 
    free(temp); 

    return popped; 
} 

int peek(struct StackNode* root) 
{ 
    if (isEmpty(root))
    {
        return INT_MIN;
    }
    return root->data; 
}
