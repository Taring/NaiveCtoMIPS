package compiler.ir;

public class ArrayWrite extends Quadruple {
    public Name dest;
    public Address src;
    public Address offset;
    public int size;

    public ArrayWrite() {
        dest = null;
        src = null;
        offset = null;
        size = 0;
    }

    public ArrayWrite(Name dest, Address offset, Address src, int size) {
        this.dest = dest;
        this.offset = offset;
        this.src = src;
        this.size = size;
    }
}
