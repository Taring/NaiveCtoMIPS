package compiler.ast;

import java.util.List;

public class CompoundStmt extends Stmt {
    public List<Decl> decls;
    public List<Stmt> stats;

    public CompoundStmt() {
        decls = null;
        stats = null;
    }

    public CompoundStmt(List<Decl> decls, List<Stmt> stats) {
        this.decls = decls;
        this.stats = stats;
    }
}
