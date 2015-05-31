package compiler.ir;

public class BasicVariable extends Variable {
    public BasicVariable() {
        name = null;
        size = 0;
    }

    public BasicVariable(String name, int size) {
        this.name = name;
        this.size = size;
    }
}
