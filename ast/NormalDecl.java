package compiler.ast;

import java.util.List;

public class NormalDecl extends Decl {
    public Type type;
    public List<VarDecl> lists;

    public NormalDecl() {
        tag = null;
        fields = null;
    }

    public NormalDecl(Type type, List<VarDecl> lists) {
        this.type = type;
        this.lists = lists;
    }
}
