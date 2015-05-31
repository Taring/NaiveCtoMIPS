package compiler.ast;

import java.util.List;
import java.util.LinkedList;

public class AST {
    public List<Decl> decls;

    public AST() {
        decls = new LinkedList<Decl>();
    }

    public AST(List<Decl> decls) {
        this.decls = decls;
    }
}
