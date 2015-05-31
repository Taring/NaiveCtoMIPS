package compiler.ast;

public class ArrayAccess extends Expr {
    public Expr body;
    public Expr subscript;

    public ArrayAccess() {
        body = null;
        subscript = null;
    }

    public ArrayAccess(Expr body, Expr subscript) {
        this.body = body;
        this.subscript = subscript;
    }
}
