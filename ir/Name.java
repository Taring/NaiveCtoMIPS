package compiler.ir;

public class Name extends Address {
    public String name;

    public Name() {
        name = null;
    }

    public Name(String name) {
        this.name = name;
    }
}
