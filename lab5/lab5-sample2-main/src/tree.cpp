#include "tree.h"
void TreeNode::addChild(TreeNode* child){
    if(this->child==NULL){
        this->child =child;
    }
    else
    {
        this->child->addSibling(child);
    }
}

void TreeNode::addSibling(TreeNode* sibling){
    TreeNode* currentsib=this->sibling;
    if(currentsib == nullptr){
        this->sibling = sibling;
    }
    else{
        while(currentsib!=NULL){
            currentsib =currentsib->sibling;
        }
        currentsib = sibling;
    }
}

TreeNode::TreeNode(int lineno, NodeType type) {
    this->lineno=lineno;
    this->nodeType=type;
}

void TreeNode::genNodeId() {
    if (this == nullptr)
        return;
    this->nodeID=NodeIndex++;
    this->child->genNodeId();
    this->sibling->genNodeId();
}

void TreeNode::printNodeInfo() {
    if (this == nullptr)
        return;
    switch (this->nodeType) {
    case NODE_PROG:
        cout << "lno@" << this->lineno << "\t@" << this->nodeID
            << " program";
        this->printChildrenId();
        cout << endl;
        break;
    case NODE_CONST:
        cout << "lno@" << this->lineno << "\t@" << this->nodeID
            << " const type: ";
        switch(this->type->type){

        case VALUE_STRING:
        cout<<this->str_val<<endl;
            break;

        case VALUE_INT:
        cout<<this->int_val<<endl;
            break;

        case VALUE_CHAR:
        cout<<this->ch_val<<endl;
            break;
        
        case VALUE_BOOL:
        cout<<this->b_val<<endl;
            break;

        default:
            break;
        }
        
        break;

    case NODE_VAR:
        cout << "lno@" << this->lineno << "\t@" << this->nodeID
            << " variable varname: " << this->var_name;
        cout << endl;
        break;

    case NODE_EXPR:
        cout << "lno@" << this->lineno << "\t@" << this->nodeID
            << " expression";
        this->printChildrenId();
        cout << endl;
        break;

    case NODE_STMT:
        cout << "lno@" << this->lineno << "\t@" << this->nodeID
            << " " << "statement";
        this->printChildrenId();
        //print statement type
        cout << " stmt:" << this->sType2String(this->stype);
        cout << endl;
        break;

    case NODE_TYPE:
        cout << "lno@" << this->lineno << "\t@" << this->nodeID
            << " type type:" << this->type->getTypeInfo();
        cout << endl;
        break;

    default:
        break;
    }
}

void TreeNode::printChildrenId() {
    if(this->child==nullptr)
    return;
    //child
    else{
        cout<<" children: [";
        cout<<this->child->nodeID<<" ";
        if(this->child->sibling==nullptr)
        return;
        //sibling
        else{
            cout<<this->child->sibling->nodeID<<" ";
            TreeNode*currentsib=this->child->sibling->sibling;
            while(currentsib!=nullptr){
                cout<<currentsib->nodeID<<" ";
                currentsib=currentsib->sibling;
            }
        }
        cout<<" ]";
    }
}

void TreeNode::printAST() {
    if (this == nullptr)
        return;
    this->printNodeInfo();
    this->child->printAST();
    this->sibling->printAST();
}


// You can output more info...
void TreeNode::printSpecialInfo() {
    switch(this->nodeType){
        case NODE_CONST:
            break;
        case NODE_VAR:
            break;
        case NODE_EXPR:
            break;
        case NODE_STMT:
            break;
        case NODE_TYPE:
            break;
        default:
            break;
    }
}

string TreeNode::sType2String(StmtType type) {
    switch(type){
        case STMT_SKIP:
            return"skip";
            break;
        case STMT_DECL:
            return "decl";
            break;
        default:
            break;
    }
    return "?";
}


string TreeNode::nodeType2String (NodeType type){
    switch(type){
        case NODE_CONST:
            return "const";
            break;
        case NODE_VAR:
            return "variable";
            break;
        case NODE_EXPR:
            return "expression";
            break;
        case NODE_TYPE:
            return "type";
            break;
        case NODE_STMT:
            return "statement";
            break; 
        case NODE_PROG:
            return "program";
            break;                                               
        default:
        return "<>";
            break;
    }
}
