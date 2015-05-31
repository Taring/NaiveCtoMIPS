package compiler.ir;

public class IntegerConst extends Const {
    public int value;

    public IntegerConst() {
    }

    public IntegerConst(int value) {
        this.value = value;
    }
}
