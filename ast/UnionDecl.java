package compiler.ast;

import java.util.List;

public class UnionDecl extends Decl {
    public Symbol tag;
    public List<Decl> fields;

    public UnionDecl() {
        tag = null;
        fields = null;
    }

    public UnionDecl(Symbol tag, List<Decl> fields) {
        this.tag = tag;
        this.fields = fields;
    }
}
