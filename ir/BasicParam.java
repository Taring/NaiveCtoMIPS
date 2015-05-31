package compiler.ir;

public class BasicParam extends Param {
    public Address src;

    public BasicParam() {
        src = null;
    }

    public BasicParam(Address src) {
        this.src = src;
    }
}
