package compiler.ast;

import java.util.List;
import java.util.LinkedList;

public class StructDecl extends Decl {
    public Symbol tag;
    public List<Decl> fields;

    public StructDecl() {
        tag = null;
        fields = null;
    }

    public StructDecl(Symbol tag, List<Decl> fields) {
        this.tag = tag;
        this.fields = fields;
    }
}
