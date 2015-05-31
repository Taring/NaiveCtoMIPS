package compiler.ir;

public class Return extends Quadruple {
    public Param value;

    public Return() {
        value = null;
    }

    public Return(Param value) {
        this.value = value;
    }
}
