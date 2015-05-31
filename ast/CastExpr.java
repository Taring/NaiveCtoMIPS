package compiler.ast;

public class CastExpr extends Expr {
    public Type cast;
    public Expr expr;

    public CastExpr() {
        cast = null;
        expr = null;
    }

    public CastExpr(Type cast, Expr expr) {
        this.cast = cast;
        this.expr = expr;
    }
}
