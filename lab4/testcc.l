%option noyywrap
%top{
#include <map>
#include <iomanip>
#include <iostream>
#include <fstream>
#include <string>
#include <string.h>
using namespace std;
#define MMAX 200

struct Table{
    int index;
    char* name;
};

Table hashTable[MMAX];

void init_hashTable(Table* hT){
    for(int i = 0;i<MMAX;i++){
        hT[i].name = new char[20];
        strcpy(hT[i].name,"0");
        hT[i].index = 0;
    }
};

int get_index(char* text){
	int length=strlen(text);
    int hash = 0;
    for(int i = 0;i<length;i++){
        hash += (text[i] - 'A' + 1) * (i + 1);
    }
    hash %= MMAX;
    while(1){
        if(strcmp(hashTable[hash].name,"0")==0){
            strcpy(hashTable[hash].name,text);
            return hash;
        }
        else{
            if(strcmp(hashTable[hash].name,text)==0){
                return hash;
            }
            else{
                hash=(hash+1)%200;
            }
        }
    }
};
}

if if
then then
else else
while while
do do
call call
const const
type type
return return
for for
main main
int int
break break
id [_a-zA-Z][_a-zA-Z0-9]*
num [0-9]+
add \+
sub \-
mul \* 
div \/
mod \%
become :=
eql \=
neq <>
leq <=
lss \<
geq >=
gtr \>
equal ==
n_equal \!\=
lbrace \{
rbrace \}
lbrack \[
rbrack \]
lparen \(
rparen \)
semi ;
bitor \|
bitand &
or \|\|
and &&
line_anno \/\/[^\n]*
block_anno \/\*(.|\n)*?\*\/
blank [\f\n\r\t\v ]
colo \,

%%

{if}			  	{cout<<setw(15)<<"if"<<setw(15)<<yytext<<endl;}
{then}				{cout<<setw(15)<<"then"<<setw(15)<<yytext<<endl;}
{else}				{cout<<setw(15)<<"else"<<setw(15)<<yytext<<endl;}
{while}				{cout<<setw(15)<<"while"<<setw(15)<<yytext<<endl;}
{do}				{cout<<setw(15)<<"do"<<setw(15)<<yytext<<endl;}
{call}				{cout<<setw(15)<<"call"<<setw(15)<<yytext<<endl;}
{const}				{cout<<setw(15)<<"const"<<setw(15)<<yytext<<endl;}
{type}				{cout<<setw(15)<<"type"<<setw(15)<<yytext<<endl;}
{return}			{cout<<setw(15)<<"return"<<setw(15)<<yytext<<endl;}
{for}				{cout<<setw(15)<<"for"<<setw(15)<<yytext<<endl;}
{main}				{cout<<setw(15)<<"main"<<setw(15)<<yytext<<endl;}
{int}				{cout<<setw(15)<<"int"<<setw(15)<<yytext<<endl;}
{break}				{cout<<setw(15)<<"break"<<setw(15)<<yytext<<endl;}
{id}         		{cout<<setw(15)<<"id"<<setw(15)<<yytext<<setw(15)<<get_index(yytext)<<endl;}
{num}				{cout<<setw(15)<<"num"<<setw(15)<<yytext<<endl;}
{add}        		{cout<<setw(15)<<"add"<<setw(15)<<yytext<<endl;}
{sub}        		{cout<<setw(15)<<"sub"<<setw(15)<<yytext<<endl;}
{mul}        		{cout<<setw(15)<<"mul"<<setw(15)<<yytext<<endl;}
{div}        		{cout<<setw(15)<<"div"<<setw(15)<<yytext<<endl;}
{mod}		 		{cout<<setw(15)<<"mod"<<setw(15)<<yytext<<endl;}
{become}			{cout<<setw(15)<<"become"<<setw(15)<<yytext<<endl;}
{eql}				{cout<<setw(15)<<"eql"<<setw(15)<<yytext<<endl;}
{neq}				{cout<<setw(15)<<"neq"<<setw(15)<<yytext<<endl;}
{leq}				{cout<<setw(15)<<"leq"<<setw(15)<<yytext<<endl;}
{lss}				{cout<<setw(15)<<"lss"<<setw(15)<<yytext<<endl;}
{geq}				{cout<<setw(15)<<"geq"<<setw(15)<<yytext<<endl;}
{gtr}				{cout<<setw(15)<<"gtr"<<setw(15)<<yytext<<endl;}
{equal}				{cout<<setw(15)<<"equal"<<setw(15)<<yytext<<endl;}
{n_equal}			{cout<<setw(15)<<"n_equal"<<setw(15)<<yytext<<endl;}
{lbrace} 			{cout<<setw(15)<<"lbrace"<<setw(15)<<yytext<<endl;}
{rbrace}			{cout<<setw(15)<<"rbrace"<<setw(15)<<yytext<<endl;}
{lbrack}			{cout<<setw(15)<<"lbrack"<<setw(15)<<yytext<<endl;}
{rbrack}			{cout<<setw(15)<<"rbrack"<<setw(15)<<yytext<<endl;}
{lparen}			{cout<<setw(15)<<"lparen"<<setw(15)<<yytext<<endl;}
{rparen} 			{cout<<setw(15)<<"rparen"<<setw(15)<<yytext<<endl;}
{semi}      		{cout<<setw(15)<<"semi"<<setw(15)<<yytext<<endl;}
{or}				{cout<<setw(15)<<"or"<<setw(15)<<yytext<<endl;}
{and}				{cout<<setw(15)<<"and"<<setw(15)<<yytext<<endl;}
{bitor}				{cout<<setw(15)<<"bitor"<<setw(15)<<yytext<<endl;}
{bitand}			{cout<<setw(15)<<"bitand"<<setw(15)<<yytext<<endl;}
{colo}				{cout<<setw(15)<<"colo"<<setw(15)<<yytext<<endl;}

{line_anno} {}
{block_anno} {}
{blank} {}

%%

int main(){
	init_hashTable(hashTable);
    yyFlexLexer lexer;
	cout<<setw(15)<<"token"<<setw(15)<<"lexeme"<<setw(15)<<"value"<<endl;
	cout<<endl;
    lexer.yylex();
    return 0;
}