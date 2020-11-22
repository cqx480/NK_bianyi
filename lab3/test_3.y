%{
/*************************
test_3.y
YACC file
Date: 2020/10/17
jing wu <wj8149cj@163.com>
*************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#ifndef YYSTYPE
#define YYSTYPE char*           //定义yystype得到的结果类型
#endif 
char idStr[50];
char numStr[50];
int yylex();                    //词法分析函数
extern int yyparse();
FILE* yyin;
void yyerror(const char*s );    //自带函数，文法出错时调用
%}

%token DIGIT
%token ID
%token ADD SUB
%token MUL DIV
%token LBRACKET RBRACKET

%left ADD SUB
%left MUL DIV
%right UMINUS

%%


lines   :   lines expr '\n' { printf("%s\n", $2); }
        |   lines '\n'
        |
        ;

expr    :   expr ADD expr { $$ = (char *)malloc(50*sizeof(char));strcpy($$,$1);strcat($$,$3);strcat($$,"+ ");} 
        |   expr SUB expr { $$ = (char *)malloc(50*sizeof(char));strcpy($$,$1);strcat($$,$3);strcat($$,"- ");}
        |   expr MUL expr { $$ = (char *)malloc(50*sizeof(char));strcpy($$,$1);strcat($$,$3);strcat($$,"* ");}
        |   expr DIV expr { $$ = (char *)malloc(50*sizeof(char));strcpy($$,$1);strcat($$,$3);strcat($$,"/ ");}
        |   LBRACKET expr RBRACKET {$$ = (char *)malloc(50*sizeof(char));strcpy($$,$2);}
        |   SUB expr %prec UMINUS { (char *)malloc(50*sizeof(char));strcpy($$,$1);strcat($$,$2);} //%prec表示‘-’优先级等同于UMINUS
        |   DIGIT         {$$ = (char *)malloc(50*sizeof(char));strcpy($$,$1);strcat($$," ");}
        |   ID            {$$ = (char *)malloc(50*sizeof(char));strcpy($$,$1);strcat($$," ");}
        ;

%%


int yylex()
{ 
    int t;
    while(1){
        t = getchar();
        if (t == ' ' || t == '\t') {
            ;
        }
        else if (t == '+'){
            return ADD;
        }
        else if (t == '-'){
            return SUB;
        }
        else if (t == '*'){
            return MUL;
        }
        else if (t == '/'){
            return DIV;
        }
        else if (t == '('){
            return LBRACKET;
        }
        else if (t == ')'){
            return RBRACKET;
        }
        else if ((t >= '0' &&  t <= '9')){
            int ti=0;
            while((t >= '0' &&  t <= '9')){
                numStr[ti]=t;
                t = getchar();
                ti++;
            }
            numStr[ti]='\0';
            yylval=numStr;
            ungetc(t,stdin);
            return DIGIT;
        }
        else if (( t >= 'a' && t <= 'z' )||( t >= 'A' && t <= 'Z' )
        ||(t == '_')){
            int ti=0;
            while(( t >= 'a' && t <= 'z' )||( t >= 'A' && t <= 'Z' )
            ||(t == '_')||(t >= '0' &&  t <= '9')){
                idStr[ti]=t;
                ti++;
                t = getchar();
            }
            idStr[ti]='\0';
            yylval=idStr;
            ungetc(t,stdin);
            return DIGIT;
        }
        else{
            return t;
        }
    }
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