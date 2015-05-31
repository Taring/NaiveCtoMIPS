package compiler.ir;

public class StringAddressConst extends Const {
    public String value;

    public StringAddressConst() {
        value = null;
    }

    public StringAddressConst(String value) {
        this.value = value;
    }
}
