package compiler.ast;

public class PointerAccess extends Expr {
    public Expr body;
    public Symbol attribute;

    public PointerAccess() {
        body = null;
        attribute = null;
    }

    public PointerAccess(Expr body, Symbol attribute) {
        this.body = body;
        this.attribute = attribute;
    }
}
