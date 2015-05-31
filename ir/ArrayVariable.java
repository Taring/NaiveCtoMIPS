package compiler.ir;

public class ArrayVariable extends Variable {
    public ArrayVariable() {
        name = null;
        size = 0;
    }

    public ArrayVariable(String name, int size) {
        this.name = name;
        this.size = size;
    }
}
