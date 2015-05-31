package compiler.ir;

public class Assign extends Quadruple {
    public Address dest;
    public Address src;

    public Assign() {
        dest = null;
        src = null;
    }

    public Assign(Address dest, Address src) {
        this.dest = dest;
        this.src = src;
    }
}
