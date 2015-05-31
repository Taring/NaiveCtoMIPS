package compiler.ast;

public class IntConst extends Expr {
    public int value;

    public IntConst() {
        value = 0;
    }

    public IntConst(int value) {
        this.value = value;
    }
}
