package compiler.ast;

public class RecordAccess extends Expr {
    public Expr body;
    public Symbol attribute;

    public RecordAccess() {
        body = null;
        attribute = null;
    }

    public RecordAccess(Expr body, Symbol attribute) {
        this.body = body;
        this.attribute = attribute;
    }
}
