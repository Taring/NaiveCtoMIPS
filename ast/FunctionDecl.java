package compiler.ast;

import java.util.List;

public class FunctionDecl extends Decl {
    public Type returnType;
    public Symbol name;
    public List<VarDecl> params;
    public CompoundStmt body;

    public FunctionDecl() {
        returnType = null;
        name = null;
        params = null;
        body = null;
    }

    public FunctionDecl(Type returnType, Symbol name, List<VarDecl> params, CompoundStmt body) {
        this.returnType = returnType;
        this.name = name;
        this.params = params;
        this.body = body;
    }
    
    public FunctionDecl(Type returnType, Symbol name, CompoundStmt body) {
        this.returnType = returnType;
        this.name = name;
        params = null;
        this.body = body;
    }
}
