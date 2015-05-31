package compiler.ast;

import java.util.List;

public class FunctionCall extends Expr {
    public Symbol body;
    public List<Expr> args;

    public FunctionCall() {
        body = null;
        args = null;
    }

    public FunctionCall(Symbol body, List<Expr> args) {
        this.body = body;
        this.args = args;
    }
}
