%{
    #include "common.h"
    #define YYSTYPE TreeNode *
    TreeNode* root;
    extern int lineno;
    int yylex();
    int yyerror( char const * );
%}

%token T_CHAR T_INT T_STRING T_BOOL 

%token IF ELSE WHILE FOR RETURN

%token LOP_ASSIGN
%token OR AND
%token EQ NEQ
%token NE LE LT GE GT

%token ADD SUB
%token MUL DIV MOD
%token NOT

%token LBRACE RBRACE LBRACK RBRACK LPAREN RPAREN

%token SEMICOLON

%token IDENTIFIER INTEGER CHAR BOOL STRING

%left LOP_ASSIGN
%left EQ NEQ
%left NE LE LT GE GT
%left ADD MINUS
%left MUL DIV
%left NOT
%left LBRACE RBRACE LBRACK RBRACK LPAREN RPAREN

%%

program
: statements {root = new TreeNode(0, NODE_PROG); root->addChild($1);};

statements
:  statement {$$=$1;}
|  statements statement {$$=$1;$$->addSibling($2);}
;

statement
: SEMICOLON  {$$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}//分号-STMT_SKIP
| declaration SEMICOLON {$$ = $1;}
| assign SEMICOLON {$$ = $1;}
| if {$$ = $1;}
;

declaration
: T IDENTIFIER LOP_ASSIGN expr{  // declare and init
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    node->addChild($2);
    node->addChild($4);
    $$ = node;   
} 
| T IDENTIFIER {                // declare
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    node->addChild($2);
    $$ = node;   
}
;

assign 
:   IDENTIFIER LOP_ASSIGN expr {
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_ASSIGN;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
;

if
:   IF LPAREN expr RPAREN LBRACE statements RBRACE ELSE LBRACE statements RBRACE{
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_IF;
        node->addChild($3);
        node->addChild($6);
        node->addChild($10);
        $$ = node;
}
|   IF LPAREN expr RPAREN LBRACE statements RBRACE{
        TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
        node->stype = STMT_IF;
        node->addChild($3);
        node->addChild($6);
        $$ = node;
}
;

expr
: IDENTIFIER {
    $$ = $1;
}
| INTEGER {
    $$ = $1;
}
| CHAR {
    $$ = $1;
}
| STRING {
    $$ = $1;
}
|   expr OR expr{
    TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_OR;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr AND expr{
    TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_AND;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr EQ expr{
    TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_EQ;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr NEQ expr{
    TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_NEQ;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr LE expr{
    TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_LE;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr LT expr{
    TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_LT;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr GE expr{
    TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_GE;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr GT expr{
    TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_GT;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr ADD expr{
        TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
        node->optype = OP_ADD;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr MINUS expr{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_MINUS;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr MUL expr{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_MUL;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr DIV expr{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_DIV;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   expr MOD expr{
        TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_MOD;
        node->addChild($1);
        node->addChild($3);
        $$ = node;
}
|   NOT expr{
    TreeNode*node = new TreeNode($1->lineno,NODE_EXPR);
        node->optype = OP_NOT;
        node->addChild($2);
        $$ = node;
}
;

T: T_INT {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_INT;} 
| T_CHAR {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_CHAR;}
| T_BOOL {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_BOOL;}
| T_STRING {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_STRING;}
;

%%

int yyerror(char const* message)
{
  cout << message << " at line " << lineno << endl;
  return -1;
}