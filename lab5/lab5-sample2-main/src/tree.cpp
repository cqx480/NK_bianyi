#include "tree.h"
void TreeNode::addChild(TreeNode* child) {
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
    while(currentsib!=NULL){
        currentsib =currentsib->sibling;
    }
    currentsib->sibling = sibling;
}

TreeNode::TreeNode(int lineno, NodeType type) {
    this->lineno=lineno;
    this->nodeType=type;
}

void TreeNode::genNodeId() {

}

void TreeNode::printNodeInfo() {
    if(this->nodeType==NODE_STMT){
        std::cout<<"lno@"<<this->lineno<<'\t'<<this->nodeID<<'\t'<<this->nodeType<<'\t';
        this->printChildrenId();
        std::cout<<this->type->type;
    }
    else{
        std::cout<<"lno@"<<this->lineno<<'\t'<<this->nodeID<<'\t'<<this->nodeType<<'\t';
    }
}

void TreeNode::printChildrenId() {
    
}

void TreeNode::printAST() {

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
    return "?";
}


string TreeNode::nodeType2String (NodeType type){
    return "<>";
}
