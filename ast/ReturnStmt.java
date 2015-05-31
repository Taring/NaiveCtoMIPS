package compiler.ast;

public class ReturnStmt extends Stmt {
    public Expr expr;

    public ReturnStmt() {
        expr = null;
    }

    public ReturnStmt(Expr expr) {
        this.expr = expr;
    }
}
