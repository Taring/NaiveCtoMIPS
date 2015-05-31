package compiler.ast;

public class BinaryExpr extends Expr {
    public Expr left;
    public BinaryOp op;
    public Expr right;

    public BinaryExpr() {
        left = null;
        op = null;
        right = null;
    }

    public BinaryExpr(Expr left, BinaryOp op, Expr right) {
        this.left = left;
        this.op = op;
        this.right = right;
    }
}
