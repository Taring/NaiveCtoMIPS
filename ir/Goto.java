package compiler.ir;

public class Goto extends Quadruple {
    public Label label;

    public Goto() {
        label = null;
    }

    public Goto(Label label) {
        this.label = label;
    }
}
