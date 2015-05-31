package compiler.ast;

public class IfStmt extends Stmt {
    public Expr condition;
    public Stmt consequent;
    public Stmt alternative;

    public IfStmt() {
        condition = null;
        consequent = null;
        alternative = null;
    }

    public IfStmt(Expr condition, Stmt consequent, Stmt alternative) {
        this.condition = condition;
        this.consequent = consequent;
        this.alternative = alternative;
    }
}
