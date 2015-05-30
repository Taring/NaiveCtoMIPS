import java.util.*;
import java.io.*;

public class IR {

    public List<Function> fragments;
    public Function __start;
    public Function __global;
    public Function now_frag;

/*
 * Environment : The Infinite Register to solve the "store" and "load"
 */
    public InfiniteRegister register;
    int stack_pointer, retad_pointer;
    int total_space, start_space; /*Need changing the name*/
    public int push_to_register() {
        return register.push(start_space == -1);
    }
    public void self_to_value(InfoNode p, int x) {
        //if (p.width > 4) System.out.println("Error catch");
        if (register.is_address(x)) {
            if (p.width == 4)
                now_frag.Insert(new Quadruple("lw", x, x));
            else
                now_frag.Insert(new Quadruple("lb", x, x));
            register.to_value(x);
        }
    }

/*
 * Environment : The Stack of Loop to solve "continue" & "break"
 */
    public LoopStack loop_stack;

/*
 * Environment : The map of each variable and the address in the register
 */
    public TargetMap VtoR;

/*
 * Environment : SymbolTable is needed because of Union or Struct
 */
    public SymbolTable table;

/*
 * Environment : String Register Choice 
 */
    public StringTable str_reg;

    boolean main_flag;

    Label return_label;
    int return_ret;

/*
 * Optimize : Inline function of inlining main directly
 * Not only these, but also inline_function_definition && postfix() -> branch
 */
    public boolean is_inline_function(String name) {
        for (int i = 0; i < fragments.size() - 1; ++i) {
            if (fragments.get(i).inline_flag && fragments.get(i).name.equals(name))
                return true;
        }
        return false;
    }
    public Node find_inline_function(String name) {
        for (int i = 0; i < fragments.size() - 1; ++i) {
            if (fragments.get(i).name.equals(name))
                return fragments.get(i).start_pos;
        }
        return null;
    }



    public IR() {
        fragments = new ArrayList<Function>();
        __start = new Function();
        __global = new Function();
        return_label = null;
        return_ret = 0;
        now_frag = null;


        start_space = -1;
        total_space = 0;

        register = new InfiniteRegister();
        stack_pointer = push_to_register();
        register.to_address(stack_pointer);
        retad_pointer = push_to_register();

        loop_stack = new LoopStack();
        VtoR = new TargetMap();
        str_reg = new StringTable();

        table = null;
        main_flag = false;
    }

    public IR(Node p, SymbolTable tab) {
        fragments = new ArrayList<Function>();
        __start = new Function();
        __global = new Function();
        return_label = null;
        return_ret = 0;
        now_frag = __start;

        start_space = -1;
        total_space = 0;

        register = new InfiniteRegister();
        register.local_space = 0;
        stack_pointer = push_to_register();
        register.to_address(stack_pointer);
        retad_pointer = push_to_register();

        loop_stack = new LoopStack();
        VtoR = new TargetMap();        
        this.table = tab;
        str_reg = new StringTable();
        main_flag = false;

        Iterator<Node> itr = p.Child.iterator();
        while (itr.hasNext()) {
            Node u = itr.next();
            this.middle(u);
        }
    }

    public void middle(Node p) {
        switch (p.type) {
            case DECLARATION : this.middle_declaration(p); break;
            case FUNCTION_DEFINITION : this.middle_function_definition(p); break;
            case EXPRESSION_STATEMENT : break;
            case COMPOUND_STATEMENT : this.middle_compound_statement(p, true); break;
            case SELECTION_STATEMENT : this.middle_selection_statement(p); break;
            case ITERATION_STATEMENT : this.middle_iteration_statement(p); break;
            case JUMP_STATEMENT : this.middle_jump_statement(p); break;
            case EXPRESSION : this.middle_expression(p, push_to_register() ); break;
            default : System.out.println("middle switch default error");
        }
    }

    public void middle_declaration(Node p) {
        if (p.Child.size() > 1) {
            for (int i = 0; i < p.Child.get(1).Child.size(); ++i) {
                this.middle_init_declarator(p.Child.get(1).Child.get(i));
            }
        }
    }

    public void middle_init_declarator(Node p) {

        int ret = push_to_register();

        if (TargetMap.level == 0) {
            __global.Insert(new Quadruple("global", ret, p.info.type == InfoNodeType.ARRAY ? p.info.info.array.width : p.info.width));
        } else {
            total_space += p.info.type == InfoNodeType.ARRAY ? p.info.info.array.width : p.info.width;
            
            int tmp = push_to_register();
            
            Quadruple quad = new Quadruple("addi", tmp, stack_pointer, -total_space + start_space);
            quad.memory_calc = true;
            now_frag.Insert(quad);
            
            now_frag.Insert(new Quadruple("move", ret, tmp));
        }
        register.to_address(ret);
        VtoR.insert(p.info.identifier, ret);

        if (p.Child.size() > 1) {
            
            if (p.info.type == InfoNodeType.ARRAY) {
                this.middle_array_initializer(p.Child.get(1), p.info, ret);
            } else {
                int tmp = push_to_register();
                this.middle_initializer(p.Child.get(1), tmp);
                this.middle_copy_construct(p.info, ret, tmp);
            }//System.out.println(p.info.type);
        }
    }

    public void middle_initializer(Node p, int ret) {
        if (p.type != NodeType.INITIALIZER) {
            middle_assignment_expression(p, ret);
            return;
        }
    }

    public void middle_array_initializer(Node p, InfoNode info, int ret) {
        if (p.type != NodeType.INITIALIZER) {
            if (p.type == NodeType.STRING_CONSTANT) {
                //System.out.println("repair now!");
                /*
                String str = p.data.substring(1, p.data.length() - 1);
                int tmp = push_to_register(), tmp3 = push_to_register();
                now_frag.Insert(new Quadruple("move", tmp, ret));
                for (int i = 0; i < str.length(); i += 1) {
                    now_frag.Insert(new Quadruple("li", tmp3, str.charAt(i)));
                    now_frag.Insert(new Quadruple("sw", tmp3, tmp));
                    now_frag.Insert(new Quadruple("addi", tmp, tmp, 1));
                }*/
                int tmp = push_to_register();
                this.middle_primary_expression(p, tmp);
                now_frag.Insert(new Quadruple("move", ret, tmp));
            } else {
                int tmp = push_to_register();
                this.middle_assignment_expression(p, tmp);
                this.self_to_value(info, tmp);
                now_frag.Insert(new Quadruple("sw", tmp, ret));
            }
            return;
        }
        if (p.data.equals("initializer {}")) {
            int tmp = push_to_register();
            now_frag.Insert(new Quadruple("move", tmp, ret));
            this.middle_array_initializer(p.Child.get(0), info, tmp);
        } else if (p.data.equals("initializers")) {
            
            //int tmp = 0;
            for (int i = 0; i < p.Child.size(); ++i) {
                Node u = p.Child.get(i);
                InfoNode ptr = info.info.array.ptr;
                this.middle_array_initializer(u, ptr, ret);
                int width = ptr.type == InfoNodeType.ARRAY ? ptr.info.array.width : ptr.width;
                now_frag.Insert(new Quadruple("addi", ret, ret, width));
                //tmp += width;
            }
            //now_frag.Insert(new Quadruple("subi", ret, ret, tmp));
        }
    }

    public void inline_function_definition(Node p, Node q, int ret) {
        InfoNodeFunction info_function = q.Child.get(0).info.info.function;
        //Label lab = new Label();
        return_label = new Label();

        if (info_function.ret.width > 0) {
            //System.out.println("#" + p.info.identifier);
            return_ret = push_to_register();
            register.to_address(return_ret);
            total_space += info_function.ret.width;
            Quadruple djj = new Quadruple("addi", return_ret, stack_pointer, -total_space + start_space);
            djj.memory_calc = true;
            now_frag.Insert(djj);
        }

        //System.out.println(q.type + " " + q.Child.get(1).Child.get(0));

        VtoR.next_level();
        if (p.info.info.function.size > 0) {
            Node arguments = q.Child.get(1).Child.get(0);
            for (int i = 0; i < p.info.info.function.size; ++i) {
                InfoNode tmp = p.info.info.function.pars.get(i);
                InfoNode u = info_function.pars.get(i);

                int tmp_p = push_to_register();
                this.middle_assignment_expression(arguments.Child.get(i), tmp_p);

                int u_width = info_function.offset[i + 1] - info_function.offset[i];
                total_space += u_width;

                int tmp_q = push_to_register();
                register.to_address(tmp_q);
                Quadruple djj = new Quadruple("addi", tmp_q, stack_pointer, -total_space + start_space);
                djj.memory_calc = true;
                now_frag.Insert(djj);

                middle_copy_construct(u, tmp_q, tmp_p);

                if (tmp.type == InfoNodeType.ARRAY)
                    register.to_value(tmp_q);
                else
                    register.to_address(tmp_q);

                VtoR.insert(tmp.identifier, tmp_q);
            }
        }
        this.middle_compound_statement(p.Child.get(p.Child.size() - 1), false);
        now_frag.Insert(new Quadruple("label", return_label));
        if (info_function.ret.width > 0) {
            now_frag.Insert(new Quadruple("move", ret, return_ret));
            register.to_address(ret);
        }
        return_label = null;
    }

    public void middle_function_definition(Node p) {
        //System.out.println("#----------FCUNTION BEGINNING-----------");
        Function func = new Function();
        fragments.add(func);
        now_frag = func;
        now_frag.name = p.info.identifier;
        now_frag.start_pos = p;
        now_frag.Insert(new Quadruple("func", now_frag.name));
        if (now_frag.name.equals("main"))
            main_flag = true;

        int old_body_size = now_frag.body.size();
        register.local_space = 0;
        start_space = total_space;

        /*parameters*/

        VtoR.next_level();
        for (int i = 0; i < p.info.info.function.size; ++i) {
            InfoNode tmp = p.info.info.function.pars.get(i);
            int ret = push_to_register();

            Quadruple quad = new Quadruple("addi", ret, stack_pointer, p.info.info.function.offset[i]);
            //quad.memory_calc = true;
            now_frag.Insert(quad);
            
            if (tmp.type == InfoNodeType.ARRAY)
                register.to_value(ret);
            else
                register.to_address(ret);
            
            VtoR.insert(tmp.identifier, ret);
        }
        this.middle_compound_statement(p.Child.get(p.Child.size() - 1), false);
        now_frag.Insert(new Quadruple("return"));

        for (int i = old_body_size; i < now_frag.body.size(); ++i) {
            Quadruple tmp = now_frag.body.get(i);
            if (tmp.memory_calc && tmp.src2 != null)
                tmp.src2.value -= register.local_space;
        }

        now_frag.Optimize();

        total_space = start_space;
        start_space = -1;
        now_frag = __start;
    }

    public void middle_compound_statement(Node p, boolean flag) {
        if (flag)
            VtoR.next_level();

        int old_total_space = total_space;
        Iterator<Node> itr = p.Child.iterator();
        while (itr.hasNext()) {
            Node u = itr.next();
            Iterator<Node> itr2 = u.Child.iterator();
            while (itr2.hasNext()) {
                Node v = itr2.next();
                this.middle(v);
            }
        }
        total_space = old_total_space;

        VtoR.prev_level();
    }

    public void middle_selection_statement(Node p) {
        /*
         * if (a) then b; else c; 
         * (a -> L1) | b | goto L2 | label: L1 | c | label: L2
         */

        //Address t0 = this.middle_expression(p.Child.get(0));
        if (p.Child.size() == 2) {
            Label l1 = new Label();
            this.middle_expression_branch(p.Child.get(0), false, l1);
            //IfFalseGoto ifg = new IfFalseGoto(t0, RelationOp.NE, 0,l1);
            //now_frag.Insert(ifg);
            this.middle(p.Child.get(1));
            now_frag.Insert(new Quadruple("label", l1));
        } else {
            Label l1 = new Label(), l2 = new Label();
            this.middle_expression_branch(p.Child.get(0), false, l1);
            //IfFalseGoto ifg = new IfFalseGoto(t0, RelationOp.NE, 0,l1);
            //now_frag.Insert(ifg);
            this.middle(p.Child.get(1));
            now_frag.Insert(new Quadruple("goto", l2));
            now_frag.Insert(new Quadruple("label", l1));
            this.middle(p.Child.get(2));
            now_frag.Insert(new Quadruple("label", l2));
        }
    }

    public void middle_iteration_statement(Node p) {
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
        Label l1 = new Label(), l2 = new Label(), l3 = null;
        if (c != null) l3 = new Label();
        if (a != null) {
            int tmp = push_to_register();
            this.middle_expression(a, tmp);
        }// a
        now_frag.Insert(new Quadruple("label", l1));// label:l1
        if (b != null)
            //Address t0 = this.middle_expression(b);
            //IfFalseGoto ifg = new IfFalseGoto(t0, RelationOp.NE, 0, l2);
            this.middle_expression_branch(b, false, l2);// (b->l2)
        
        if (c != null)
            loop_stack.insert(l2, l3);
        else
            loop_stack.insert(l2, l1);
        this.middle(p.Child.get(p.Child.size() - 1));// d
        loop_stack.delete();

        if (c != null) {
            now_frag.Insert(new Quadruple("label", l3));// label:l3
            int tmp = push_to_register();
            this.middle_expression(c, tmp);// c
        }
        now_frag.Insert(new Quadruple("goto", l1));// goto l1
        now_frag.Insert(new Quadruple("label", l2));// label:l2

    }

    public void middle_jump_statement(Node p) {
        if (p.Child.get(0).data.equals("return")) {
            if (return_label != null) {
                //int ret = push_to_register();
                if (p.Child.size() > 1) {
                    int ret = push_to_register();
                    this.middle_expression(p.Child.get(1), ret);
                    //int tmp = push_to_register();
                    //now_frag.Insert(new Quadruple("addi", tmp, stack_pointer, -total_space + start_space));
                    //this.middle_copy_construct(p.info.info.function.ret, tmp, ret);
                    //now_frag.Insert(new Quadruple("move", return_ret, ret));
                    this.middle_copy_construct(p.info.info.function.ret, return_ret, ret);
                    //register.to_address(return_ret);
                }
                now_frag.Insert(new Quadruple("goto", return_label));
            } else {
                if (p.Child.size() > 1) {
                    int ret = push_to_register();
                    this.middle_expression(p.Child.get(1), ret);
                    int tmp = push_to_register();
                    now_frag.Insert(new Quadruple("addi", tmp, stack_pointer, p.info.info.function.width + 4));
                    this.middle_copy_construct(p.info.info.function.ret, tmp, ret);
                }
                now_frag.Insert(new Quadruple("return"));
            }
        } else if (p.Child.get(0).data.equals("continue")) {
            now_frag.Insert(new Quadruple("goto", loop_stack.find_continue()));
        } else {
            now_frag.Insert(new Quadruple("goto", loop_stack.find_break()));
        }
    }

    public void middle_expression(Node p, int ret) {
        for (int i = 0; i < p.Child.size() - 1; ++i) {
            int tmp = push_to_register();
            this.middle_assignment_expression(p.Child.get(i), tmp);
        }
        this.middle_assignment_expression(p.Child.get(p.Child.size() - 1), ret);
    }
    public void middle_expression_branch(Node p, boolean flag, Label l0) {
        for (int i = 0; i < p.Child.size() - 1; ++i) {
            int tmp = push_to_register();
            this.middle_assignment_expression(p.Child.get(i), tmp);
        }
        this.middle_assignment_expression_branch(p.Child.get(p.Child.size() - 1), flag, l0);
    }

    public void middle_assignment_expression(Node p, int ret) {
        if (p.type != NodeType.ASSIGN_EXPRESSION) {
            this.middle_logical_or_expression(p, ret);
            return;
        }
        this.middle_unary_expression(p.Child.get(0), ret);
        int tmp = push_to_register();
        this.middle_assignment_expression(p.Child.get(2), tmp);
        if (p.Child.get(1).data.equals("=")) {
            this.middle_copy_construct(p.Child.get(0).info, ret, tmp);
            //now_frag.Insert(new Assign(t0, t1));
        } else {
            String op = null;
            switch (p.Child.get(1).data.charAt(0)) {
                case '*': op = "mul"; break;
                case '/': op = "div"; break;
                case '%': op = "mod"; break;
                case '+': op = "add"; break;
                case '-': op = "sub"; break;
                case '<': op = "shl"; break;
                case '>': op = "shr"; break;
                case '&': op = "and"; break;
                case '^': op = "xor"; break;
                case '|': op = "or"; break;
            }
            int txt = push_to_register();
            now_frag.Insert(new Quadruple("lw", txt, ret));
            self_to_value(p.Child.get(2).info, tmp);
            now_frag.Insert(new Quadruple(op, txt, txt, tmp));
            now_frag.Insert(new Quadruple("sw", txt, ret));
        }
    }
    public void middle_assignment_expression_branch(Node p, boolean flag, Label l0) {
        if (p.type != NodeType.ASSIGN_EXPRESSION) {
            this.middle_logical_or_expression_branch(p, flag, l0);
            return;
        }

        int ret = push_to_register();
        this.middle_unary_expression(p.Child.get(0), ret);
        int tmp = push_to_register();
        this.middle_assignment_expression(p.Child.get(2), tmp);
        if (p.Child.get(1).data.equals("=")) {
            this.middle_copy_construct(p.Child.get(0).info, ret, tmp);
            //now_frag.Insert(new Assign(t0, t1));
            self_to_value(p.Child.get(0).info, ret);
            now_frag.Insert(new Quadruple(flag ? "bnez" : "beqz", ret, l0));
        } else {
            String op = null;
            switch (p.Child.get(1).data.charAt(0)) {
                case '*': op = "mul"; break;
                case '/': op = "div"; break;
                case '%': op = "mod"; break;
                case '+': op = "add"; break;
                case '-': op = "sub"; break;
                case '<': op = "shl"; break;
                case '>': op = "shr"; break;
                case '&': op = "and"; break;
                case '^': op = "xor"; break;
                case '|': op = "or"; break;
            }
            //int txt = push_to_register();
            //now_frag.Insert(new Quadruple("lw", txt, ret));
            self_to_value(p.Child.get(0).info, ret);
            self_to_value(p.Child.get(2).info, tmp);
            now_frag.Insert(new Quadruple(op, ret, ret, tmp));
            //now_frag.Insert(new Quadruple("sw", txt, ret));
            now_frag.Insert(new Quadruple(flag ? "bnez" : "beqz", ret, l0));
        }
    }

    public void middle_logical_or_expression(Node p, int ret) { // ||
        if (p.type != NodeType.LOGICAL_OR_EXPRESSION) {
            this.middle_logical_and_expression(p, ret);
            return;
        } 
        
        if (p.info.isconst) {
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            return;
        }

        //Address t1 = this.middle_logical_or_expression(p.Child.get(0));
        this.middle_logical_or_expression(p.Child.get(0), ret);
        self_to_value(p.Child.get(0).info, ret);
        Label l1 = new Label();
        now_frag.Insert(new Quadruple("bnez", ret, l1));

        //Address t2 = this.middle_logical_and_expression(p.Child.get(1));
        this.middle_logical_and_expression(p.Child.get(1), ret);
        self_to_value(p.Child.get(1).info, ret);

        now_frag.Insert(new Quadruple("label", l1));
        now_frag.Insert(new Quadruple("andi", ret, ret, 1));
    }
    public void middle_logical_or_expression_branch(Node p, boolean flag, Label l0) { // ||
        if (p.type != NodeType.LOGICAL_OR_EXPRESSION) {
            this.middle_logical_and_expression_branch(p, flag, l0);
            return;
        }
        
        if (p.info.isconst) {
            //now_frag.Insert(new Quadruple(flag?"bnez":"beqz", p.info.isconst, l0));
            if ((p.info.value == 1) && flag)
                now_frag.Insert(new Quadruple("goto", l0));
            else if ((p.info.value == 0) && !flag)
                now_frag.Insert(new Quadruple("goto", l0));
            return;
        }

        if (!flag) {
            //Address t1 = this.middle_logical_or_expression(p.Child.get(0));
            Label l1 = new Label();
            this.middle_logical_or_expression_branch(p.Child.get(0), true, l1);
            this.middle_logical_and_expression_branch(p.Child.get(1), false, l0);
            now_frag.Insert(new Quadruple("label", l1));
        } else {
        //Address t2 = this.middle_logical_and_expression(p.Child.get(1));
        //this.middle_logical_and_expression(p.Child.get(0), ret);
        //self_to_value(p.Child.get(1).info, ret);

            this.middle_logical_or_expression_branch(p.Child.get(0), true, l0);
            this.middle_logical_and_expression_branch(p.Child.get(1), true, l0);
        }
    }

    public void middle_logical_and_expression(Node p, int ret) { // ||
        if (p.type != NodeType.LOGICAL_AND_EXPRESSION) {
            this.middle_inclusive_or_expression(p, ret);
            return;
        }

        if (p.info.isconst) {
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            return;
        }

        //Address t1 = this.middle_logical_or_expression(p.Child.get(0));
        this.middle_logical_and_expression(p.Child.get(0), ret);
        self_to_value(p.Child.get(0).info, ret);
        Label l1 = new Label();
        now_frag.Insert(new Quadruple("beqz", ret, l1));

        //Address t2 = this.middle_logical_and_expression(p.Child.get(1));
        this.middle_inclusive_or_expression(p.Child.get(1), ret);
        self_to_value(p.Child.get(1).info, ret);

        now_frag.Insert(new Quadruple("label", l1));
        now_frag.Insert(new Quadruple("andi", ret, ret, 1));
    }
    public void middle_logical_and_expression_branch(Node p, boolean flag, Label l0) { // ||
        if (p.type != NodeType.LOGICAL_AND_EXPRESSION) {
            this.middle_inclusive_or_expression_branch(p, flag, l0);
            return;
        }
        
        if (p.info.isconst) {
            //now_frag.Insert(new Quadruple(flag?"bnez":"beqz", p.info.isconst, l0));
            if ((p.info.value == 1) && flag)
                now_frag.Insert(new Quadruple("goto", l0));
            else if ((p.info.value == 0) && !flag)
                now_frag.Insert(new Quadruple("goto", l0));
            return;
        }

        if (flag) {
            //Address t1 = this.middle_logical_or_expression(p.Child.get(0));
            Label l1 = new Label();
            this.middle_logical_and_expression_branch(p.Child.get(0), false, l1);
            this.middle_inclusive_or_expression_branch(p.Child.get(1), true, l0);
            now_frag.Insert(new Quadruple("label", l1));
        } else {
        //Address t2 = this.middle_logical_and_expression(p.Child.get(1));
        //this.middle_logical_and_expression(p.Child.get(0), ret);
        //self_to_value(p.Child.get(1).info, ret);

            this.middle_logical_and_expression_branch(p.Child.get(0), false, l0);
            this.middle_inclusive_or_expression_branch(p.Child.get(1), false, l0);
        }
    }

    public void middle_inclusive_or_expression(Node p, int ret) { // ||
        if (p.type != NodeType.INCLUSIVE_OR_EXPRESSION) {
            this.middle_exclusive_or_expression(p, ret);
            return;
        }

        if (p.info.isconst) {
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            return;
        }

        //Address t1 = this.middle_logical_or_expression(p.Child.get(0));
        this.middle_inclusive_or_expression(p.Child.get(0), ret);
        self_to_value(p.Child.get(0).info, ret);

        int tmp = push_to_register();
        this.middle_exclusive_or_expression(p.Child.get(1), tmp);
        self_to_value(p.Child.get(1).info, tmp);

        now_frag.Insert(new Quadruple("or", ret, ret, tmp));
    }
    public void middle_inclusive_or_expression_branch(Node p, boolean flag, Label l0) { // ||
        if (p.type != NodeType.INCLUSIVE_OR_EXPRESSION) {
            this.middle_exclusive_or_expression_branch(p, flag, l0);
            return;
        }

        if (p.info.isconst) {
            //now_frag.Insert(new Quadruple(flag?"bnez":"beqz", p.info.isconst, l0));
            if ((p.info.value == 1) && flag)
                now_frag.Insert(new Quadruple("goto", l0));
            else if ((p.info.value == 0) && !flag)
                now_frag.Insert(new Quadruple("goto", l0));
            return;
        }

        //Address t1 = this.middle_logical_or_expression(p.Child.get(0));

        int tmp = push_to_register();
        this.middle_inclusive_or_expression(p, tmp);
        self_to_value(p.info, tmp);
        now_frag.Insert(new Quadruple(flag?"bnez":"beqz", tmp, l0));
    }

    public void middle_exclusive_or_expression(Node p, int ret) {
        if (p.type != NodeType.EXCLUSIVE_OR_EXPRESSION) {
            this.middle_and_expression(p, ret);
            return;
        }
        
        if (p.info.isconst) {
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            return;
        }

        //Address t1 = this.middle_logical_or_expression(p.Child.get(0));
        this.middle_exclusive_or_expression(p.Child.get(0), ret);
        self_to_value(p.Child.get(0).info, ret);

        int tmp = push_to_register();
        this.middle_and_expression(p.Child.get(1), tmp);
        self_to_value(p.Child.get(1).info, tmp);

        now_frag.Insert(new Quadruple("xor", ret, ret, tmp));
    }
    public void middle_exclusive_or_expression_branch(Node p, boolean flag, Label l0) { // ||
        if (p.type != NodeType.EXCLUSIVE_OR_EXPRESSION) {
            this.middle_and_expression_branch(p, flag, l0);
            return;
        }
  
        if (p.info.isconst) {
            //now_frag.Insert(new Quadruple(flag?"bnez":"beqz", p.info.isconst, l0));
            if ((p.info.value == 1) && flag)
                now_frag.Insert(new Quadruple("goto", l0));
            else if ((p.info.value == 0) && !flag)
                now_frag.Insert(new Quadruple("goto", l0));
            return;
        }

        //Address t1 = this.middle_logical_or_expression(p.Child.get(0));

        int tmp = push_to_register();
        this.middle_exclusive_or_expression(p, tmp);
        self_to_value(p.info, tmp);
        now_frag.Insert(new Quadruple(flag?"bnez":"beqz", tmp, l0));
    }


    public void middle_and_expression(Node p, int ret) {
        if (p.type != NodeType.AND_EXPRESSION) {
            this.middle_equality_expression(p, ret);
            return;
        }

        if (p.info.isconst) {
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            return;
        }

        //Address t1 = this.middle_logical_or_expression(p.Child.get(0));
        this.middle_and_expression(p.Child.get(0), ret);
        self_to_value(p.Child.get(0).info, ret);

        int tmp = push_to_register();
        this.middle_equality_expression(p.Child.get(1), tmp);
        self_to_value(p.Child.get(1).info, tmp);

        now_frag.Insert(new Quadruple("and", ret, ret, tmp));
    }
    public void middle_and_expression_branch(Node p, boolean flag, Label l0) {
        if (p.type != NodeType.AND_EXPRESSION) {
            this.middle_equality_expression_branch(p, flag, l0);
            return;
        }

        if (p.info.isconst) {
            //now_frag.Insert(new Quadruple(flag?"bnez":"beqz", p.info.isconst, l0));
            if ((p.info.value == 1) && flag)
                now_frag.Insert(new Quadruple("goto", l0));
            else if ((p.info.value == 0) && !flag)
                now_frag.Insert(new Quadruple("goto", l0));
            return;
        }

        //Address t1 = this.middle_logical_or_expression(p.Child.get(0));
        int tmp = push_to_register();
        this.middle_and_expression(p, tmp);
        self_to_value(p.info, tmp);
        now_frag.Insert(new Quadruple(flag?"bnez":"beqz", tmp, l0));
    }

    public void middle_equality_expression(Node p, int ret) {
        if (p.type != NodeType.EQUALITY_EXPRESSION) {
            this.middle_relational_expression(p, ret);
            return;
        }

        if (p.info.isconst) {
            //System.out.println("GXX!  " + p.info.value);
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            return;
        }

        //Address t1 = this.middle_logical_or_expression(p.Child.get(0));
        this.middle_relational_expression(p.Child.get(0), ret);
        self_to_value(p.Child.get(0).info, ret);

        int tmp = push_to_register();
        this.middle_relational_expression(p.Child.get(2), tmp);
        self_to_value(p.Child.get(2).info, tmp);

        Label l0 = new Label();
        now_frag.Insert(new Quadruple("sub", tmp, ret, tmp));
        now_frag.Insert(new Quadruple("li", ret, 1));
        boolean flag = p.Child.get(1).data.equals("==");
        now_frag.Insert(new Quadruple(flag?"beqz":"bnez", tmp, l0));
        now_frag.Insert(new Quadruple("li", ret, 0));
        now_frag.Insert(new Quadruple("label", l0));        
    }
    public void middle_equality_expression_branch(Node p, boolean flag, Label l0) {
        if (p.type != NodeType.EQUALITY_EXPRESSION) {
            this.middle_relational_expression_branch(p, flag, l0);
            return;
        }

        if (p.info.isconst) {
            //System.out.println("SXX!  " + p.info.value + " " + flag);
            //now_frag.Insert(new Quadruple(flag?"bnez":"beqz", p.info.isconst, l0));
            if ((p.info.value == 1) && flag)
                now_frag.Insert(new Quadruple("goto", l0));
            else if ((p.info.value == 0) && !flag)
                now_frag.Insert(new Quadruple("goto", l0));
            return;
        }

        /*
        int tmp = push_to_register();
        this.middle_and_expression(p, tmp);
        self_to_value(p.info, tmp);
        now_frag.Insert(flag?"bnez":"beqz", tmp, label l0);
        */
        int ret = push_to_register();
        this.middle_relational_expression(p.Child.get(0), ret);
        self_to_value(p.Child.get(0).info, ret);

        int tmp = push_to_register();
        this.middle_relational_expression(p.Child.get(2), tmp);
        self_to_value(p.Child.get(2).info, tmp);

        now_frag.Insert(new Quadruple("sub", tmp, ret, tmp));
        if (flag)
            flag = p.Child.get(1).data.equals("==");
        else
            flag = p.Child.get(1).data.equals("==") ^ true;
        now_frag.Insert(new Quadruple(flag?"beqz":"bnez", tmp, l0));        
    }

    public void middle_relational_expression(Node p, int ret) {
        if (p.type != NodeType.RELATIONAL_EXPRESSION) {
            this.middle_shift_expression(p, ret);
            return;
        }

        if (p.info.isconst) {
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            return;
        }

        this.middle_relational_expression(p.Child.get(0), ret);
        self_to_value(p.Child.get(0).info, ret);

        int tmp = push_to_register();
        this.middle_shift_expression(p.Child.get(2), tmp);
        self_to_value(p.Child.get(2).info, tmp);

        Label l0 = new Label();
        now_frag.Insert(new Quadruple("sub", tmp, ret, tmp));
        now_frag.Insert(new Quadruple("li", ret, 1));
        String str = p.Child.get(1).data;
        if (str.equals(">="))
            now_frag.Insert(new Quadruple("bgez", tmp, l0));
        else if (str.equals("<="))
            now_frag.Insert(new Quadruple("blez", tmp, l0));
        else if (str.equals(">"))
            now_frag.Insert(new Quadruple("bgtz", tmp, l0));
        else 
            now_frag.Insert(new Quadruple("bltz", tmp, l0));
        now_frag.Insert(new Quadruple("li", ret, 0));
        now_frag.Insert(new Quadruple("label", l0));
    }
    public void middle_relational_expression_branch(Node p, boolean flag, Label l0) {
        if (p.type != NodeType.RELATIONAL_EXPRESSION) {
            int ret = push_to_register();
            this.middle_shift_expression(p, ret);
            self_to_value(p.info, ret);
            now_frag.Insert(new Quadruple(flag?"bnez":"beqz", ret, l0));

            return;
        }

        if (p.info.isconst) {
            //now_frag.Insert(new Quadruple(flag?"bnez":"beqz", p.info.isconst, l0));
            if ((p.info.value == 1) && flag)
                now_frag.Insert(new Quadruple("goto", l0));
            else if ((p.info.value == 0) && !flag)
                now_frag.Insert(new Quadruple("goto", l0));
            return;
        }

        int ret = push_to_register();
        this.middle_relational_expression(p.Child.get(0), ret);
        self_to_value(p.Child.get(0).info, ret);

        int tmp = push_to_register();
        this.middle_shift_expression(p.Child.get(2), tmp);
        self_to_value(p.Child.get(2).info, tmp);

        now_frag.Insert(new Quadruple("sub", tmp, ret, tmp));
        String str = p.Child.get(1).data;
        if (str.equals(">="))
            now_frag.Insert(new Quadruple(flag?"bgez":"bltz", tmp, l0));
        else if (str.equals("<="))
            now_frag.Insert(new Quadruple(flag?"blez":"bgtz", tmp, l0));
        else if (str.equals(">"))
            now_frag.Insert(new Quadruple(flag?"bgtz":"blez", tmp, l0));
        else 
            now_frag.Insert(new Quadruple(flag?"bltz":"bgez", tmp, l0));        
    }

    public void middle_shift_expression(Node p, int ret) {
        if (p.type != NodeType.SHIFT_EXPRESSION) {
            this.middle_additive_expression(p, ret);
            return;
        }

        if (p.info.isconst) {
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            return;
        }

        this.middle_shift_expression(p.Child.get(0), ret);
        self_to_value(p.Child.get(0).info, ret);

        int tmp = push_to_register();
        this.middle_additive_expression(p.Child.get(2), tmp);
        self_to_value(p.Child.get(2).info, tmp);

        if (p.Child.get(1).data.equals(">>"))
            now_frag.Insert(new Quadruple("shr", ret, ret, tmp));
        else
            now_frag.Insert(new Quadruple("shl", ret, ret, tmp));
    }

    public void middle_additive_expression(Node p, int ret) {
        if (p.type != NodeType.ADDITIVE_EXPRESSION) {
            this.middle_multiplicative_expression(p, ret);
            return;
        }

        if (p.info.isconst) {
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            return;
        }

        this.middle_additive_expression(p.Child.get(0), ret);
        self_to_value(p.Child.get(0).info, ret);

        int tmp = push_to_register();
        this.middle_multiplicative_expression(p.Child.get(2), tmp);
        self_to_value(p.Child.get(2).info, tmp);

        if (p.Child.get(1).data.equals("+")) {
            if (p.Child.get(0).info.type == InfoNodeType.ARRAY || p.Child.get(0).info.type == InfoNodeType.POINTER)
                now_frag.Insert(new Quadruple("muli", tmp, tmp, p.Child.get(0).info.width));
            else if (p.Child.get(2).info.type == InfoNodeType.ARRAY || p.Child.get(2).info.type == InfoNodeType.POINTER)
                now_frag.Insert(new Quadruple("muli", ret, ret, p.Child.get(2).info.width));
            now_frag.Insert(new Quadruple("add", ret, ret, tmp));
        } else {
            if (p.Child.get(0).info.type == InfoNodeType.ARRAY || p.Child.get(0).info.type == InfoNodeType.POINTER) {
                if (p.Child.get(2).info.type == InfoNodeType.ARRAY || p.Child.get(2).info.type == InfoNodeType.POINTER) {
                    now_frag.Insert(new Quadruple("sub", ret, ret, tmp));
                    now_frag.Insert(new Quadruple("divi", ret, ret, p.Child.get(0).info.width));
                } else {
                    now_frag.Insert(new Quadruple("muli", tmp, tmp, p.Child.get(0).info.width));
                    now_frag.Insert(new Quadruple("sub", ret, ret, tmp));
                }
            } else
                now_frag.Insert(new Quadruple("sub", ret, ret, tmp));
        }    
    }

    public void middle_multiplicative_expression(Node p, int ret) {
        if (p.type != NodeType.MULTIPLICATIVE_EXPRESSION) {
            this.middle_cast_expression(p, ret);
            return;
        }

        if (p.info.isconst) {
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            return;
        }

        this.middle_multiplicative_expression(p.Child.get(0), ret);
        self_to_value(p.Child.get(0).info, ret);

        int tmp = push_to_register();
        this.middle_cast_expression(p.Child.get(2), tmp);
        self_to_value(p.Child.get(2).info, tmp);

        if (p.Child.get(1).data.equals("*"))
            now_frag.Insert(new Quadruple("mul", ret, ret, tmp));
        else if (p.Child.get(1).data.equals("/"))
            now_frag.Insert(new Quadruple("div", ret, ret, tmp));
        else 
            now_frag.Insert(new Quadruple("mod", ret, ret, tmp));
    }

    public void middle_cast_expression(Node p, int ret) {
        if (p.type != NodeType.CAST_EXPRESSION) {
            this.middle_unary_expression(p, ret);
            return;
        }

        this.middle_cast_expression(p.Child.get(1), ret);
        self_to_value(p.Child.get(1).info, ret);

        if (p.Child.get(0).info.type == InfoNodeType.INT || p.Child.get(0).info.type == InfoNodeType.CHAR) {
            register.to_value(ret);
        } else if (p.Child.get(0).info.type == InfoNodeType.POINTER) {
            //register.to_address(ret);
            register.to_value(ret);
        }
    }

    public void middle_unary_expression(Node p, int ret) {
        if (p.type != NodeType.UNARY_EXPRESSION) {
            this.middle_postfix_expression(p, ret);
            return;
        }

        if (p.info.isconst) {
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            return;
        }

        if (p.Child.get(0).type == NodeType.UNARY_OPERATOR) {
            this.middle_cast_expression(p.Child.get(1), ret);
            if (p.Child.get(0).data.charAt(0) == '&') {
                //now_frag.Insert(new AddressOf(t0));
                register.to_value(ret);
            } else if (p.Child.get(0).data.charAt(0) == '*') {
                if (register.is_value(ret))
                    register.to_address(ret);
                else
                    now_frag.Insert(new Quadruple("lw", ret, ret));
            } else if (p.Child.get(0).data.charAt(0) == '+') {
                self_to_value(p.Child.get(1).info, ret);
                //now_frag.Insert(new Quadruple("pos", ret, ret));
            } else if (p.Child.get(0).data.charAt(0) == '-') {
                self_to_value(p.Child.get(1).info, ret);
                now_frag.Insert(new Quadruple("neg", ret, ret));
            } else if (p.Child.get(0).data.charAt(0) == '~') {
                self_to_value(p.Child.get(1).info, ret);
                now_frag.Insert(new Quadruple("not", ret, ret));
            } else if (p.Child.get(0).data.charAt(0) == '!') {
                self_to_value(p.Child.get(1).info, ret);
                now_frag.Insert(new Quadruple("lnot", ret, ret));
            }
        } else if (p.Child.get(0).data.equals("++")) {
            this.middle_unary_expression(p.Child.get(1), ret);
            int tmp = push_to_register();
            now_frag.Insert(new Quadruple("move", tmp, ret));
            register.to_value(ret);
            now_frag.Insert(new Quadruple("lw", ret, ret));
            now_frag.Insert(new Quadruple("addi", ret, ret, 1));
            now_frag.Insert(new Quadruple("sw", ret, tmp));
        } else if (p.Child.get(0).data.equals("--")) {
            this.middle_unary_expression(p.Child.get(1), ret);
            int tmp = push_to_register();
            now_frag.Insert(new Quadruple("move", tmp, ret));
            register.to_value(ret);
            now_frag.Insert(new Quadruple("lw", ret, ret));
            now_frag.Insert(new Quadruple("subi", ret, ret, 1));
            now_frag.Insert(new Quadruple("sw", ret, tmp));
        } else { // size of
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            register.to_value(ret);
        }
    }

    public void middle_postfix_expression(Node p, int ret) {
        if (p.type != NodeType.POSTFIX_EXPRESSION) {
            this.middle_primary_expression(p, ret);
            return;
        }

        if (p.info.isconst) {
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            return;
        }

        this.middle_postfix_expression(p.Child.get(0), ret);
        Node postfix = p.Child.get(1);
        if (postfix.data.equals("postfix []")) {
            self_to_value(p.Child.get(0).info, ret);
            int tmp = push_to_register(), tmp2 = push_to_register();
            this.middle_expression(postfix.Child.get(0), tmp);
            self_to_value(postfix.Child.get(0).info, tmp);

            //int tmp2 = push_to_register();
            if (p.info.type == InfoNodeType.ARRAY) {
                now_frag.Insert(new Quadruple("muli", tmp2, tmp, p.info.info.array.width));
                register.to_value(ret);
            } else {
                now_frag.Insert(new Quadruple("muli", tmp2, tmp, p.info.width));
                register.to_address(ret);
            }

            now_frag.Insert(new Quadruple("add", ret, ret, tmp2));
        } else if (postfix.data.equals("postfix ()")) {
            InfoNodeFunction info_function = p.Child.get(0).info.info.function;
            Quadruple djj;
/*
            String name = p.Child.get(0).info.identifier;
            if (main_flag && this.is_inline_function(name) && info_function.ret.width <= 4) {
                Node q = find_inline_function(name);
                this.inline_function_definition(q, p, ret);
                return;
            }
*/
            total_space += 4;

            if (info_function.ret.width > 0)
                total_space += info_function.ret.width;
            if (!main_flag) {
                djj = new Quadruple("sw", retad_pointer, stack_pointer, -total_space + start_space);
                djj.memory_calc = true;
                now_frag.Insert(djj);
            }

            if (postfix.Child.size() > 0) {
                Node arguments = postfix.Child.get(0);
                for (int i = info_function.pars.size() - 1; i >= 0; --i) {
                    InfoNode u = info_function.pars.get(i);
                    int u_width = info_function.offset[i + 1] - info_function.offset[i];
                    total_space += u_width;

                    int tmp = push_to_register();
                    this.middle_assignment_expression(arguments.Child.get(i), tmp);

                    int tmp2 = push_to_register();
                    register.to_address(tmp2);
                    djj = new Quadruple("addi", tmp2, stack_pointer, -total_space + start_space);
                    djj.memory_calc = true;
                    now_frag.Insert(djj);

                    middle_copy_construct(u, tmp2, tmp);
                }
            }
            
            djj = new Quadruple("addi", stack_pointer, stack_pointer, -total_space + start_space);
            djj.memory_calc = true;
            now_frag.Insert(djj);

            if (p.Child.get(0).info.identifier.equals("printf") && info_function.pars.size() == 1)
                now_frag.Insert(new Quadruple("call", "printf_single"));
            else {
                //if (!p.Child.get(0).info.identifier.equals("printf"))
                    now_frag.inline_flag = false;
                now_frag.Insert(new Quadruple("call", p.Child.get(0).info.identifier));
            }

            djj = new Quadruple("subi", stack_pointer, stack_pointer, -total_space + start_space);
            djj.memory_calc = true;
            now_frag.Insert(djj);

            total_space -= info_function.width;

            if (!main_flag) {
                djj = new Quadruple("lw", retad_pointer, stack_pointer, -total_space + start_space);
                djj.memory_calc = true;
                now_frag.Insert(djj);
            }

            total_space -= 4;

            if (info_function.ret.width > 0) {
                register.to_address(ret);
                int tmp = push_to_register();
                register.to_address(tmp);
                djj = new Quadruple("addi", tmp, stack_pointer, -total_space + start_space);
                djj.memory_calc = true;
                now_frag.Insert(djj);
                now_frag.Insert(new Quadruple("move", ret, tmp));
                register.to_address(ret);
                total_space -= info_function.ret.width;
            }

        } else if (postfix.data.equals("postfix .")) {
            int width = -1;
            InfoNodeRecord info_record = p.Child.get(0).info.info.record;
            for (int i = 0; i < info_record.size; ++i)
                if (postfix.Child.get(1).data.equals(info_record.field.get(i).identifier))
                    width = info_record.offset[i];
            if (width == -1) {
                System.out.println("What's the Ghost!");
            }
            now_frag.Insert(new Quadruple("addi", ret, ret, width));
            if (p.info.type == InfoNodeType.ARRAY) {
                register.to_value(ret);
            } else {
                register.to_address(ret);
            }
        } else if (postfix.data.equals("postfix ->")) {//must be pointer
            InfoNode info = p.Child.get(0).info.info.pointer;
            if (info.type == InfoNodeType.NAME)
                info = table.fetch_type_instance(info);

            int width = -1;
            for (int i = 0; i < info.info.record.size; ++i)
                if (postfix.Child.get(1).data.equals(info.info.record.field.get(i).identifier))
                    width = info.info.record.offset[i];
            if (width == -1) {
                System.out.println("What's the Ghost!");
            }
            now_frag.Insert(new Quadruple("lw", ret, ret));
            now_frag.Insert(new Quadruple("addi", ret, ret, width));
            if (p.info.type == InfoNodeType.ARRAY) {
                register.to_value(ret);
            } else {
                register.to_address(ret);
            }
        } else if (postfix.data.equals("postfix ++")) {
            int tmp = push_to_register();
            now_frag.Insert(new Quadruple("move", tmp, ret));
            now_frag.Insert(new Quadruple("lw", ret, ret));
            register.to_value(ret);
            int tmp2 = push_to_register();
            now_frag.Insert(new Quadruple("addi", tmp2, ret, 1));
            now_frag.Insert(new Quadruple("sw", tmp2, tmp));
        } else if (postfix.data.equals("postfix --")) {
            int tmp = push_to_register();
            now_frag.Insert(new Quadruple("move", tmp, ret));
            now_frag.Insert(new Quadruple("lw", ret, ret));
            register.to_value(ret);
            int tmp2 = push_to_register();
            now_frag.Insert(new Quadruple("subi", tmp2, ret, 1));
            now_frag.Insert(new Quadruple("sw", tmp2, tmp));
        }
    }

    public void middle_primary_expression(Node p, int ret) {
        if (p.type == NodeType.PRIMARY_EXPRESSION) {
            this.middle_expression(p.Child.get(0), ret);
            return;
        }

        if (p.type == NodeType.INTEGER_CONSTANT || p.type == NodeType.CHARACTER_CONSTANT) {
            now_frag.Insert(new Quadruple("li", ret, p.info.value));
            register.to_value(ret);
        } else if (p.type == NodeType.IDENTIFIER) {
            if (p.info.type == InfoNodeType.FUNCTION) {
                int useless = 0;
            } else {
                int tmp = VtoR.fetch_identifier(p.info.identifier);
                if (register.is_address(tmp)) {
                    if (p.info.type == InfoNodeType.ARRAY)
                        register.to_value(ret);
                    else
                        register.to_address(ret);
                    now_frag.Insert(new Quadruple("move", ret, tmp));//address
                } else {
                    register.to_value(ret);
                    now_frag.Insert(new Quadruple("lw", ret, tmp));//value
                }
            }
        } else if (p.type == NodeType.STRING_CONSTANT) {
            String str = p.data.substring(1, p.data.length() - 1);
            int tmp = str_reg.fetch_identifier(str);
            if ( tmp == -1 ) {
                int old_start_space = start_space;
                start_space = -1;
                tmp = push_to_register();
                str_reg.Insert(str, tmp);
                __global.Insert(new Quadruple("string", tmp, str));
                start_space = old_start_space;
            }
            now_frag.Insert(new Quadruple("move", ret, tmp));
            register.to_value(ret);
        } else {
            System.out.println(p.type + p.data);
            //System.out.println(p.Child.get(0).Child.get(0).type);
            //System.out.println(p.Child.get(0).Child.get(2).type);            
        }
    }

    public void middle_copy_construct(InfoNode p, int ret1, int ret2) {
        if (p.width == 4) {
            self_to_value(p, ret2);
            now_frag.Insert(new Quadruple("sw", ret2, ret1));
        } else if (p.width == 1) {
            self_to_value(p, ret2);
            now_frag.Insert(new Quadruple("sb", ret2, ret1));
        } else {
            int tmp1 = push_to_register(), tmp2 = push_to_register(), tmp3 = push_to_register();
            now_frag.Insert(new Quadruple("move", tmp1, ret1));
            now_frag.Insert(new Quadruple("move", tmp2, ret2));
            for (int i = 0; i < p.width; i += 4) {
                now_frag.Insert(new Quadruple("lw", tmp3, tmp2));
                now_frag.Insert(new Quadruple("sw", tmp3, tmp1));
                now_frag.Insert(new Quadruple("addi", tmp1, tmp1, 4));
                now_frag.Insert(new Quadruple("addi", tmp2, tmp2, 4));
            }
        }
    }

    public void IR_print() {
        __global.print();
        __start.print();
        for (int i = 0; i < fragments.size(); ++i) {
            System.out.println("#----------------------------");
            fragments.get(i).print();
        }
    }


    public int get_register(Address a, int normal_ans) {
        if (a.value == stack_pointer)
            return 29;
        if (a.value == retad_pointer)
            return 31;
        return normal_ans;
    }

    public int get_register_load(Address a, int normal_ans) {
        if (a.value == stack_pointer)
            return 29;
        if (a.value == retad_pointer)
            return 31;

        if (register.global(a.value)) {
            System.out.println("lw $" + String.valueOf(normal_ans)  + ", " + String.valueOf(4 * a.value) + "($a3)");
        } else
            System.out.println("lw $" + String.valueOf(normal_ans) + ", " + String.valueOf(-register.offset.get(a.value)) + "($sp)");
        return normal_ans;
    }

    public void store_register(int first, int ret) {
        if (ret == stack_pointer)
            System.out.println("move $sp, " + "$"+String.valueOf(first));
        else if (ret == retad_pointer)
            System.out.println("move $ra, " + "$"+String.valueOf(first));
        else if (register.global(ret)) {
            System.out.println("sw " + "$"+String.valueOf(first) + ", " + String.valueOf(4 * ret) + "($a3)");
        } else
            System.out.println("sw " + "$"+String.valueOf(first) + ", " + String.valueOf(-register.offset.get(ret)) + "($sp)");
    }

    final public String TEMP_NAME = "temp";
    final public String VAR_NAME = "var";
    final public String LABEL_NAME = "label";
    static public int lnot_cnt = 0;

    public void single_mips(Quadruple quad) {
        if (quad.op.equals("li")) {
            int dest = this.get_register(quad.dest, 8);
            System.out.println("li $" + String.valueOf(dest) + ", " + String.valueOf(quad.src1.value));
            if (dest == 8)
                this.store_register(8, quad.dest.value);
        } else if (quad.op.equals("lw") || quad.op.equals("lb")) {
            int dest = this.get_register(quad.dest, 8);
            int src = this.get_register_load(quad.src1, 9);
            System.out.println(quad.op + " " + "$"+String.valueOf(dest) + ", " + String.valueOf(quad.src2.value) + "(" + "$"+String.valueOf(src) + ")");
            if (dest == 8)
                this.store_register(8, quad.dest.value);
        } else if (quad.op.equals("sw") || quad.op.equals("sb")) {
            int dest = this.get_register_load(quad.dest, 8);
            int src = this.get_register_load(quad.src1, 9);
            System.out.println(quad.op + " " + "$"+String.valueOf(dest) + ", " + String.valueOf(quad.src2.value) + "(" + "$"+String.valueOf(src) + ")");
        } else if (quad.op.equals("move")) {
            int dest = this.get_register(quad.dest, 8);
            int src = this.get_register_load(quad.src1, 9);
            System.out.println(quad.op + " " + "$"+String.valueOf(dest) + ", " + "$"+String.valueOf(src) );
            if (dest == 8) {
                this.store_register(8, quad.dest.value);
            }
        } else if (quad.op.equals("return")) {
            if (main_flag)
                System.out.println("j __main_end");
            else
                System.out.println("jr $ra");
        } else if (quad.op.equals("label")) {
            int label = quad.dest.value;
            System.out.println(LABEL_NAME+String.valueOf(label) + ":");
        } else if (quad.op.equals("goto")) {
            int label = quad.dest.value;
            System.out.println("j " + LABEL_NAME+String.valueOf(label));
        } else if (quad.op.equals("bnez") || quad.op.equals("beqz")
                || quad.op.equals("bltz") || quad.op.equals("bgez")
                || quad.op.equals("blez") || quad.op.equals("bgtz")) {
            int dest = get_register_load(quad.dest, 8);
            int label = quad.src1.value;
            System.out.println(quad.op + " " + "$"+String.valueOf(dest) + ", " + LABEL_NAME+String.valueOf(label));
        } else if (quad.op.equals("add") || quad.op.equals("sub")
                || quad.op.equals("mul") || quad.op.equals("div") || quad.op.equals("mod")
                || quad.op.equals("and") || quad.op.equals("or") || quad.op.equals("xor")
                || quad.op.equals("shl") || quad.op.equals("shr")) {
            String op = quad.op;
            if (op.equals("mod")) op = "rem";
            if (op.equals("shl")) op = "sll";
            if (op.equals("shr")) op = "srl";
            int dest = this.get_register(quad.dest, 8);
            int src1 = this.get_register_load(quad.src1, 9);
            if (quad.src2.type == AddressType.CONST)
                System.out.println(op + " " + "$"+String.valueOf(dest) + ", " + "$"+String.valueOf(src1) + ", " + quad.src2.value);
            else {
                int src2 = this.get_register_load(quad.src2, 10);
                System.out.println(op + " " + "$"+String.valueOf(dest) + ", " + "$"+String.valueOf(src1) + ", " + "$"+String.valueOf(src2));
            }
            if (dest == 8)
                this.store_register(8, quad.dest.value);
        } else if (quad.op.equals("addi") || quad.op.equals("subi")
                || quad.op.equals("muli") || quad.op.equals("divi")
                || quad.op.equals("andi")) {
            int dest = this.get_register(quad.dest, 8);
            int src = this.get_register_load(quad.src1, 9);
            String op = quad.op;
            if (op.equals("addi")) op = "add";
            if (op.equals("subi")) op = "sub";
            if (op.equals("muli")) op = "mul";
            if (op.equals("divi")) op = "div";
            //if (op.equals("andi")) op = "and";
            //System.out.println("# Ghost");
            System.out.println(op + " " + "$"+String.valueOf(dest) + ", " + "$"+String.valueOf(src) + ", " + quad.src2.value);
            if (dest == 8)
                this.store_register(8, quad.dest.value);
        } else if (quad.op.equals("neg") || quad.op.equals("not")) {
            int dest = this.get_register(quad.dest, 8);
            int src = this.get_register_load(quad.src1, 9);
            System.out.println(quad.op + " " + "$"+String.valueOf(dest) + ", " + "$"+String.valueOf(src));
            if (dest == 8)
                this.store_register(8, quad.dest.value);
        } else if (quad.op.equals("lnot")) {
            int dest = this.get_register(quad.dest, 8);
            int src = this.get_register_load(quad.src1, 9);
            if (dest == src)
                System.out.println("move $a1, " + "$"+String.valueOf(dest));
            System.out.println("li $"+String.valueOf(dest)+", 1");
            if (dest == src)
                System.out.println("beqz $a1, lnot"+String.valueOf(lnot_cnt));
            else
                System.out.println("beqz $"+String.valueOf(src)+", lnot"+String.valueOf(lnot_cnt));
            System.out.println("li $"+String.valueOf(dest)+", 0");
            System.out.println("lnot"+String.valueOf(lnot_cnt)+":");
            if (dest == 8)
                this.store_register(8, quad.dest.value);
            ++lnot_cnt;
        } else if (quad.op.equals("func")) {
            if (quad.dest.str.equals("main"))
                System.out.println(quad.dest.str + ":");
            else
                System.out.println("__" + quad.dest.str + ":");
        } else if (quad.op.equals("call")) {
            System.out.println("jal __" + quad.dest.str);
        } else
            System.out.println("WTF~~~~!");
        //System.out.println("# " + quad.ToString());
    }

    public void MIPS_print() {
        System.out.println(".data");
        System.out.println(TEMP_NAME + ": .space " + String.valueOf(register.state.size() * 4));
        main_flag = false;

        now_frag = __global;
        int cnt = 0;
        for (int i = 0; i < now_frag.body.size(); ++i) {
            Quadruple quad = now_frag.body.get(i);
            if (quad.op.equals("string")) {
                System.out.println(VAR_NAME + String.valueOf(cnt++) + ": .asciiz " + '\"' + quad.src1.str + '\"');
                System.out.println(".align 2");
            } else if (quad.op.equals("global")) {
                System.out.println(VAR_NAME + String.valueOf(cnt++) + ": .space " + String.valueOf(quad.src1.value));
            } else {
                System.out.println("Error in global");
            }
        }
        System.out.println("");

        System.out.println(".text");
        try {
            FileReader file = new FileReader("../MIPSNormal.s");
            BufferedReader buffer = new BufferedReader(file);
            String str = null;
        
            while ( (str = buffer.readLine()) != null) {
                //String s= buffer.readLine();
                System.out.println(str);
            }

            buffer.close();
        } catch (Exception e) {
            System.out.println("mhj Error!");
        }


        for (int xxx = 0; xxx < fragments.size(); ++xxx) {
            now_frag = fragments.get(xxx);

            for (int yyy = 0; yyy < now_frag.body.size(); ++yyy) {
                Quadruple quad = now_frag.body.get(yyy);

                if (!quad.mips_flag)
                    continue;

                this.single_mips(quad);
                
                if (quad.op.equals("func") && quad.dest.str.equals("main")) {
                    main_flag = true;

                    System.out.println("la $a3, " + TEMP_NAME);
                    cnt = 0;
                    for (int i = 0; i < __global.body.size(); ++i) {
                        Quadruple quad2 = __global.body.get(i);
                        System.out.println("la $t0, " + VAR_NAME + String.valueOf(cnt++));
                        System.out.println("sw $t0, " + String.valueOf(quad2.dest.value * 4) + "($a3)");
                    }
                    for (int i = 0; i < __start.body.size(); ++i) {
                        Quadruple quad2 = __start.body.get(i);
                        this.single_mips(quad2);
                    }
                }
            }
        }

        System.out.println("__main_end:");
        System.out.println("li $v0, 10");
        System.out.println("syscall");
    }

    public void Local_Register_Allocate() {
        //DNF
    }
}