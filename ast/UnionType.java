package compiler.ast;

public class UnionType extends BasicType {
    public Symbol tag;

    public UnionType() {
        tag = null;
    }

    public UnionType(Symbol tag) {
        this.tag = tag;
    }
}
