package compiler.ast;

public class Identifier extends Expr {
    public Symbol symbol;

    public Identifier() {
        symbol = null;
    }

    public Identifier(Symbol symbol) {
        this.symbol = symbol;
    }
}
