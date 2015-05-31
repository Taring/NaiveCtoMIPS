package compiler.ir;

/* 
	 * TODO CONTINUE LABEL;
*/
public class LoopStack {
    
    public Stack<Label> break_count;
    public Stack<Label> continue_count;

    public LoopStack() {
        break_count = new Stack<Label>();
        continue_count = new Stack<Label>();
    }

    public void insert(Label a, Label b) {
    	break_count.push(a);
    	continue_count.push(b);
    }

    public void delete() {
    	break_count.pop();
    	continue_count.pop();
    }

    public Label find_break() {
        return break_count.peek();
    }

    public Label find_continue() {
        return continue_count.peek();
    }

}
