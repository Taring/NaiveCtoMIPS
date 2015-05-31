package compiler.ast;

public class ForLoop extends Stmt {
    public Expr init;
    public Expr condition;
    public Expr step;
    public Stmt body;

    public ForLoop() {
        init = null;
        condition = null;
        step = null;
        body = null;
    }

    public ForLoop(Expr init, Expr condition, Expr step, Stmt body) {
        this.init = init;
        this.condition = condition;
        this.step = step;
        this.body = body;
    }
}
