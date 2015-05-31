package compiler.ast;

public class UnaryExpr extends Expr {
    public UnaryOp op;
    public Expr expr;

    public UnaryExpr() {
        op = null;
        expr = null;
    }

    public UnaryExpr(UnaryOp op, Expr expr) {
        this.op = op;
        this.expr = expr;
    }
}
