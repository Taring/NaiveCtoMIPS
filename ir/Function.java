package compiler.ir;

import java.util.List;
import java.util.LinkedList;

public class Function {
    public String name;
    public int size;
    public List<Variable> args;
    public List<Variable> vars;
    public List<Quadruple> body;

    public Function() {
        name = null; 
        size = 0;
        args = new LinkedList<Variable>();
        vars = new LinkedList<Variable>();
        body = new LinkedList<Quadruple>();
    }

    public Function(String name, int size, List<Variable> args, 
                    List<Variable> vars, List<Quadruple> body) {
        this.name = name;
        this.size = size;
        this.args = args;
        this.vars = vars;
        this.body = body;
    }
}
