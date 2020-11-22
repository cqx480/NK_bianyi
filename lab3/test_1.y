%{
/*************************
test_1.y
YACC file
Date: 2020/10/16
jing wu <wj8149cj@163.com>
*************************/
#include <stdio.h>
#include <stdlib.h>
#ifndef YYSTYPE
#define YYSTYPE double                  //结果定义为double型
#endif 
int yylex();                            //词法分析
extern int yyparse();
FILE* yyin;
void yyerror(const char* s );           //文法出错时调用
%}

%left '+' '-'
%left '*' '/'
%right UMINUS

%%


lines   :   lines expr '\n' { printf("%f\n", $2); }
        |   lines '\n'
        |
        ;

expr    :   expr '+' expr { $$ = $1 + $3; } 
        |   expr '-' expr { $$ = $1 - $3; }
        |   expr '*' expr { $$ = $1 * $3; }
        |   expr '/' expr { $$ = $1 / $3; }
        |   '(' expr ')' { $$ = $2; }
        |   '-' expr %prec UMINUS { $$ =-$2; }
        |   DIGIT
        ;

DIGIT   :   '0'                { $$ = 0.0; }
        |   '1'                { $$ = 1.0; }
        |   '2'                { $$ = 2.0; }
        |   '3'                { $$ = 3.0; }
        |   '4'                { $$ = 4.0; }
        |   '5'                { $$ = 5.0; }
        |   '6'                { $$ = 6.0; }
        |   '7'                { $$ = 7.0; }
        |   '8'                { $$ = 8.0; }
        |   '9'                { $$ = 9.0; }
        ;

%%

// programs section

int yylex()
{ 
    // place your token retrieving code here
    return getchar ();
}

int main(void)
{
    yyin = stdin ; 
    do {
            yyparse();
    } while (! feof(yyin)); 
    return 0;
}
void yyerror(const char* s) { 
    fprintf(stderr,"Parse error: %s\n",s);
    exit(1);
}