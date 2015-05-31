package compiler.ir;

public class IfTrueGoto extends Quadruple {
    public Address src1;
    public RelationalOp op;
    public Address src2;
    public Label label;

    public IfTrueGoto() {
        src1 = null;
        op = null;
        src2 = null;
        label = null;
    }

    public IfTrueGoto(Address src1, RelationalOp op, Address src2, Label label) {
        this.src1 = src1;
        this.op = op;
        this.src2 = src2;
        this.label = label;
    }
}
