package compiler.ir;

public class ArrayRead extends Quadruple {
    public Address dest;
    public Name src;
    public Address offset;
    public int size;

    public ArrayRead() {
        dest = null;
        src = null;
        offset = null;
        size = 0;
    }

    public ArrayRead(Address dest, Name src, Address offset, int size) {
        this.dest = dest;
        this.offset = offset;
        this.src = src;
        this.size = size;
    }
}
