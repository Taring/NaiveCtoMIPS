package compiler.ir;

import java.util.*;
import java.io.*;

public class IR {
    public List<Function> fragments;
    public Function __start;
    public Function now_frag;

/*
 * Environment Declaration
 */
    public LoopStack loop_stack;

    int level;

    public IR() {
        fragments = new ArrayList<Function>();
        __start = new Function();;
        loop_stack = null;
        now_frag = null;
    }

    public IR(Node p) {
    	fragments = new ArrayList<Function>();
        __start = Function();
        now_frag = null;
        loop_stack = new LoopStack();
        level = 0;

        Iterator<Node> itr = p.Child.iterator();
        while (itr.hasNext()) {
            Node u = itr.next();
            if (u.type == NodeType.DECLARATION) {
                this.middle_declaration();
            } else {
                Function func = this.middle_function_definition(u);
            }
        }
    }

    public void middle(Node p) {
        switch (p.type) {
            case DECLARATION : this.middle_declaration(p); break;
            case EXPRESSION_STATEMENT : break;
            case COMPOUND_STATEMENT : this.middle_compound_statement(p); break;
            case SELECTION_STATEMENT : this.middle_selection_statement(p); break;
            case ITERATOR_STATEMENT : this.middle_iterator_statement(p); break;
            case JUMP_STATEMENT : this.middle_jump_statement(p); break;
            case EXPRESSION : this.middle_expression(p); break;
            default : System.out.println("middle switch default error");
        }
    }

    public void middle_declaration() {
        if (p.Child.size() > 1) {
            for (int i = 0; i < p.Child.get(1).Child.size(); ++i) {
                this.middle_init_declarator(p.Child.get(1).Child.get(i));
            }
        }
    }

    public void middle_init_declarator(Node p) {
        if (level == 0) {
            if (p.info.type != InfoNodeType.ARRAY) {
                if (p.info.type == InfoNodeType.STRUCT || p.info.type == InfoNodeType.UNION)
                    __start.vars.add(new ArrayVariable(p.info.identifier, p.info.width));
                else
                    __start.vars.add(new BasicVariable(p.info.identifier, p.info.width));
            } else
                __start.vars.add(new ArrayVariable(p.info.identifier, p.info.array.width));
        } else {
            if (p.info.type != InfoNodeType.ARRAY) {
                if (p.info.type == InfoNodeType.STRUCT || p.info.type == InfoNodeType.UNION)
                    now_frag.vars.add(new ArrayVariable(p.info.identifier, p.info.width));
                else
                    now_frag.vars.add(new BasicVariable(p.info.identifier, p.info.width));
            } else
                now_frag.vars.add(new ArrayVariable(p.info.identifier, p.info.array.width));
        }

        if (p.Child.size() > 1) {//Initializer need more ideas;
            middle_initializer(p.Child.get(1), p.info);
            //middle_assignment(p.Info, spa);
        }
    }

    public void Initializer(Node p, Infonode ptr){};

    public Function middle_function_definition(Node p) {
        Function ret = new Function();
        now_frag = ret;
        InfoNodeFunction infoFunc = p.info.info.function;
        ret.name = p.info.identifier;
        ret.size = width;
        
        /*parameters*/
        for (int i = 0; i < c.info.function.size; ++i) {
            InfoNode tmp = c.info.function.pars.get(i);
            if (tmp.type != InfoNodeType.ARRAY) {
                if (tmp.type == InfoNodeType.STRUCT || tmp.type == InfoNodeType.UNION)
                    now_frag.args.add(new ArrayVariable(tmp.identifier, tmp.width));
                else
                    now_frag.args.add(new BasicVariable(tmp.identifier, tmp.width));
            } else
                now_frag.args.add(new ArrayVariable(tmp.identifier, tmp.array.width));
        }

        this.middle_compound_statement(p.Child.get(p.Child.size() - 1));
    }

    public void middle_compound_statement(Node p) {
        ++level;

        Iterator<Node> itr = p.Child.iterator();
        while (itr.hasNext()) {
            Node u = itr.next();
            Iterator<Node> itr2 = u.Child.iterator();
            while (itr2.hasNext()) {
                Node v = itr2.next();
                this.middle(v);
            }
        }

        --level;
    }

    public void middle_selection_statement(Node p) {
        /*
         * if (a) then b; else c; 
         * (a -> L1) | b | goto L2 | label: L1 | c | label: L2
         */

        Address t0 = this.middle_expression(p.Child.get(0));

        if (p.Child.size() == 2) {
            Label l1 = new Label();
            IfFalseGoto ifg = new IfFalseGoto(t0, RelationOp.NE, 0,l1);
            now_frag.body.add(ifg);
            this.middle(p.Child.get(1));
            now_frag.bodg.add(l1);
        } else {
            Label l1 = new Label(), l2 = new Label();
            IfFalseGoto ifg = new IfFalseGoto(t0, RelationOp.NE, 0,l1);
            now_frag.body.add(ifg);
            this.middle(p.Child.get(1));
            now_frag.body.add(new Goto(l2));
            now_frag.body.add(l1);
            this.middle(p.Child.get(2));
            now_frag.body.add(l2);
        }
    }

    public void middle_iterator_statement(Node p) {
        /*
         * for ( a : b : c ) d;
         * a | label:l1 | (b -> l2) | d | lable:l3 | c | goto l1 | label:l2
         */
        Node a = null, b = null, c = null;
        Address t0 = null;
        if (p.data.equals("while()")) {
            b = p.Child.get(0);
        } else {
            if (p.data.equals("for(;;)")) {
                int useless = 0;
            } else if (p.data.equals("for(*;;)")) {
                a = p.Child.get(0);
            } else if (p.data.equals("for(;*;)")) {
                b = p.Child.get(0);
            } else if (p.data.equals("for(;;*)")) {
                c = p.Child.get(0);
            } else if (p.data.equals("for(*;*;)")) {
                a = p.Child.get(0);
                b = p.Child.get(1);
            } else if (p.data.equals("for(*;;*)")) {
                a = p.Child.get(0);
                c = p.Child.get(1);
            } else if (p.data.equals("for(;*;*)")) {
                b = p.Child.get(0);
                c = p.Child.get(1);
            } else if (p.data.equals("for(*;*;*)")) {
                a = p.Child.get(0);
                b = p.Child.get(1);
                c = p.Child.get(2);
            }
        }
        Label l1 = new label(), l2 = new label(), l3 = null;
        if (c != null) l3 = new label();
        if (a != null)
            this.middle_expression(a);// a
        now_frag.body.add(l1);// label:l1
        if (b != null) {
            Address t0 = this.middle_expression(b);
            IfFalseGoto ifg = new IfFalseGoto(t0, RelationOp.NE, 0, l2);
        }// (b->l2)
        
        if (c != null)
            loop_stack.insert(l2, l3);
        else
            loop_stack.insert(l2, l1);
        this.middle(p.Child.get(p.Child.size() - 1));// d
        loop_stack.delete();

        if (c != null) {
            now_frag.body.add(l3);// label:l3
            this.middle_expression(c);// c
        }
        now_frag.body.add(new Goto(l1));// goto l1
        now_frag.body.add(l2);// label:l2

    }

    public void middle_jump_statement(Node p) {
        if (p.Child.get(0).data.equals("return")) {
            if (p.Child.size() > 1) {
                //return ?;
            } else {
                //return;
            }
        } else if (p.Child.get(0).data.equals("continue")) {
            now_frag.body.add(new Goto(loop_stack.find_continue()));
        } else {
            now_frag.body.add(new Goto(loop_stack.find_break()));
        }
    }

    public Address middle_expression(Node p) {
        Address t0;
        for (int i = 0; i < p.Child.size(); ++i)
            t0 = this.middle_assignment_expression(p.Child.get(i));
        return t0;
    }

    public Address middle_assignment_expression(Node p) {
        if (p.type != NodeType.ASSIGN_EXPRESSION)
            return this.middle_logical_or_expression(p);
        Address t0 = this.middle_unary_expression(p.Child.get(0));
        Address t1 = this.middle_assignment_expression(p.Child.get(2));
        if (p.Child.get(1).data.equals("=")) {
            //this.middle_copy_construct(t0, t1);
            now_frag.body.add(new Assign(t0, t1));
        } else {

            ArithmeticOp op = null;
            switch (p.Child.get(1).data.charAt(0)) {
                case '*': op = MUL; break;
                case '/': op = DIV; break;
                case '%': op = MOD; break;
                case '+': op = ADD; break;
                case '-': op = SUB; break;
                case '<': op = SHL; break;
                case '>': op = SHR; break;
                case '&': op = AND; break;
                case '^': op = XOR; break;
                case '|': op = OR; break;
            }

            now_frag.body.add(new ArithmeticExpr(t0, op, t1));
        }
        return t0;
    }

    public Address middle_logical_or_expression(Node p) { // ||
        if (p.info.isconst) {
            return new IntegerConst(p.info.value);
        }
        if (p.type != NodeType.LOGICAL_OR_EXPRESSION) {
            return this.middle_logical_and_expression(p);
        }
        
        Address t1 = this.middle_logical_or_expression(p.Child.get(0));
        Address t2 = this.middle_logical_and_expression(p.Child.get(1));

        ArithmeticOp op = ArithmeticOp.OR;
        Address t0 = new Temp();
        now_frag.body.add(new ArithmeticExpr(t0 ,op, t1, t2));
        //questions exist.
        return t0;
    }

    public Address middle_logical_and_expression(Node p) {// &&
        if (p.info.isconst) {
            return new IntegerConst(p.info.value);
        }
        if (p.type != NodeType.LOGICAL_AND_EXPRESSION) {
            return this.middle_inclusive_or_expression(p);
        }

        Address t1 = this.middle_logical_and_expression(p.Child.get(0));
        Address t2 = this.middle_inclusive_or_expression(p.Child.get(1));
        ArithmeticOp op = ArithmeticOp.AND;
        Address t0 = new Temp();
        now_frag.body.add(new ArithmeticExpr(t0, op, t1, t2));

        return t0;
    }

    public Address middle_inclusive_or_expression(Node p) {
        if (p.info.isconst) {
            return new IntegerConst(p.info.value);
        }
        if (p.type != NodeType.INCLUSIVE_OR_EXPRESSION) {
            return this.middle_exclusive_or_expression(p);
        }

        Address t1 = this.middle_inclusive_or_expression(p.Child.get(0));
        Address t2 = this.middle_exclusive_or_expression(p.Child.get(1));
        ArithmeticOp op = ArithmeticOp.OR;
        Address t0 = new Temp();
        now_frag.body.add(new ArithmeticExpr(t0, op, t1, t2));

        return t0;
    }

    public Address middle_exclusive_or_expression(Node p) {
        if (p.info.isconst) {
            return new IntegerConst(p.info.value);
        }
        if (p.type != NodeType.EXCLUSIVE_OR_EXPRESSION) {
            return this.middle_and_expression(p);
        }

        Address t1 = this.middle_exclusive_or_expression(p.Child.get(0));
        Address t2 = this.middle_and_expression(p.Child.get(1));
        ArithmeticOp op = ArithmeticOp.XOR;
        Address t0 = new Temp();
        now_frag.body.add(new ArithmeticExpr(t0, op, t1, t2));

        return t0;
    }

    public Address middle_and_expression(Node p) {
        if (p.info.isconst) {
            return new IntegerConst(p.info.value);
        }
        if (p.type != NodeType.AND_EXPRESSION) {
            return this.middle_equality_expression(p);
        }

        Address t1 = this.middle_and_expression(p.Child.get(0));
        Address t2 = this.middle_equality_expression(p.Child.get(1));
        ArithmeticOp op = ArithmeticOp.AND;
        Address t0 = new Temp;
        now_frag.body.add(new ArithmeticExpr(t0, op, t1, t2));

        return t0;
    }

    public Address middle_eqality_expression(Node p) {
        if (p.info.isconst) {
            return new IntegerConst(p.info.value);
        }
        if (p.type != NodeType.EQUALITY_EXPRESSION) {
            return this.middle_relational_expression(p);
        }

        Address t1 = this.middle_relational_expression(p.Child.get(0));
        Address t2 = this.middle_relational_expression(p.Child.get(2));
        Address t0 = new Temp;
        Address t3 = new Temp;
        now_frag.body.add(new ArithmeticExpr(t3, ArithmeticOp.XOR, t1, t2));
        if (p.Child.get(1).data.equals("==")) {
            now_frag.body.add(new ArithmeticOp(t3, ArithmeticExpr));
        }
        //need details
    }

    public Address middle_relational_expression(Node p) {
        if (p.info.isconst) {
            return new IntegerConst(p.info.value);
        }
        if (p.type != NodeType.RELATIONAL_EXPRESSION) {
            return this.middle_shift_expression(p);
        }

        Address t1 = this.middle_relational_expression(p.Child.get(0));
        Address t2 = this.middle_shift_expression(p.Child.get(2));
        Address t0 = new Temp;
        //details thinking!
    }

    public Address middle_shift_expression(Node p) {
        if (p.info.isconst) {
            return new IntegerConst(p.info.value);
        }
        if (p.type != NodeType.SHIFT_EXPRESSION) {
            return this.middle_additive_expression(p);
        }

        Address t1 = this.middle_shift_expression(p.Child.get(0));
        Address t2 = this.middle_additive_expression(p.Child.get(2));
        Address t0 = new Temp;

        ArithmeticOp op = null;
        if (p.Child.get(1).data.equals(">>"))
            op = ArithmeticOp.SHR;
        else
            op = ArithmeticOp.SHL;

        now_frag.body.add(new ArithmeticExpr(t0, op, t1, t2));

        return t0;
    }

    public Address middle_additive_expression(Node p) {
        if (p.info.isconst) {
            return new IntegerConst(p.info.value);
        }
        if (p.type != NodeType.ADDITIVE_EXPRESSION) {
            return this.middle_multiplicative_expression(p);
        }

        Address t1 = this.middle_additive_expression(p.Child.get(0));
        Address t2 = this.middle_multiplicative_expression(p.Child.get(2));
        Address t0 = new Temp;

        ArithmeticOp op = null;
        if (p.Child.get(1).data.equals("+"))
            op = ArithmeticOp.ADD;
        else
            op = ArithmeticOp.SUB;

        now_frag.body.add(new ArithmeticExpr(t0, op, t1, t2));

        return t0;        
    }

    public Address middle_multiplicative_expression(Node p) {
        if (p.info.isconst) {
            return new IntegerConst(p.info.value);
        }
        if (p.type != NodeType.MULTIPLICATIVE_EXPRESSION) {
            return this.middle_cast_expression(p);
        }

        Address t1 = this.middle_multiplicative_expression(p.Child.get(0));
        Address t2 = this.middle_cast_expression(p.Child.get(2));
        Address t0 = new Temp;

        ArithmeticOp op = null;
        if (p.Child.get(1).data.equals("*"))
            op = ArithmeticOp.MUL;
        else if (p.Child.get(1).data.equals("/"))
            op = ArithmeticOp.DIV;
        else 
            op = ArithmeticOp.MOD;

        now_frag.body.add(new ArithmeticExpr(t0, op, t1, t2));

        return t0;        
    }

    public Address middle_cast_expression(Node p) { //中间转换怎么去表示这个？、考虑字节么
        if (p.type != NodeType.CASE_EXPRESSION) {
            return this.middle_unary_expression(p);
        }

        Address t1 = this.middle_cast_expression(p.Child.get(1));
        if (p.Child.get(0).info.type == InfoNodeType.INT || p.Child.get(0).info.type == InfoNodeType.CHAR) {
            //字节转换？！
        } else if (p.Child.get(0).info.type == InfoNodeType.POINTER) {
            //字节转换？！
        }

        return t1;
    }

    public Address middle_unary_expression(Node p) {
        if (p.type != NodeType.UNARY_EXPRESSION) {
            return this.middle_postfix_expression(p);
        }

        Address t0;
        if (p.Child.get(0).type == NodeType.UNARY_OPERATOR) {
            t0 = this.middle_cast_expression(p.Child.get(1));
            if (p.Child.get(0).data.charAt(0) == '&') {
                now_frag.body.add(new AddressOf(t0));
            } else if (p.Child.get(1).data.charAt(0) == '*') {
                //How to use memory
            } else if (p.Child.get(1).data.charAt(0) == '+') {
                int useless = 0;
            } else if (p.Child.get(1).data.charAt(0) == '-') {
                now_frag.body.add(new ArithmeticExpr(t0, ArithmeticOp.SUB, 0, t0));
            } else if (p.Child.get(1).data.charAt(0) == '~') {
                now_frag.body.add(new ArithmeticExpr(t0, ArithmeticOp.TILDE, t0));
            } else if (p.Child.get(1).data.charAt(0) == '!') {
                now_frag.body.add(new ArithmeticExpr(t0, ArithmeticOp.XOR, t0, 0));
            }
        } else if (p.Child.get(0).data.equals("++")) {
            t0 = this.middle_unary_expression(p.Child.get(1));
            now_frag.body.add(new ArithmeticExpr(t0, ArithmeticOp.ADD, t0, 1));
        } else if (p.Child.get(0).data.equals("--")) {
            t0 = this.middle_unary_expression(p.Child.get(1));
            now_frag.body.add(new ArithmeticExpr(t0, ArithmeticOp.SUB, t0, 1));
        } else { // size of
            t0 = new IntegerConst(p.info.value);
        }
        return t0;
    }

    public Address middle_postfix_expression(Node p) {}

    public Address middle_primary_expression(Node p) {
        if (p.type == NodeType.PRIMARY_EXPRESSION) {
            return this.middle_expression(p);
        }

        Address ad = null;
        if (p.type == NodeType.INTEGER_CONSTANT || p.type == NodeType.CHARACTER_CONSTANT) {
            ad = new IntegerConst(p.info.value);
        } else if (p.type == NodeType.IDENTIFIER) {
            ad = new Name(p.data);
        } else { // (p.type == NodeType.STRING_CONSTANT) 
            
        }

        return ad;
    }


}
