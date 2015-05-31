package compiler.ast;

public class WhileLoop extends Stmt {
    public Expr condition;
    public Stmt body;

    public WhileLoop() {
        condition = null;
        body = null;
    }

    public WhileLoop(Expr condition, Stmt body) {
        this.condition = condition;
        this.body = body;
    }
}
