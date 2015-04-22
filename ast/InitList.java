package compiler.ast;

import java.util.List;
import java.util.LinkedList;

public class InitList extends Initializer {
    public List<Initializer> inits;

    public InitList() {
        inits = null;
    }

    public InitList(List<Initializer> inits) {
        this.inits = inits;
    }
}
