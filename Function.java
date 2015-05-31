import java.io.*;
import java.util.*;

public class Function {
    public String name;
    public List<Quadruple> body;

    public boolean inline_flag;
    public Node start_pos;

    public int succ[];
    public int prev[];
    public int last_pos, first_pos;
    public void LinkBuild() {
        succ = new int[body.size()];
        succ[last_pos = body.size() - 1] = -1;
        for (int i = body.size() - 2; i >= 0; --i) {
            Quadruple quad = body.get(i);
            succ[i] = (quad.mips_flag)?i:succ[i + 1];
        }

        prev = new int[body.size()];
        prev[first_pos = 0] = -1;
        for (int i = 1; i < body.size(); ++i) {
            Quadruple quad = body.get(i);
            prev[i] = (quad.mips_flag)?i:prev[i - 1];
        }

        //for (int i = 0; i < body.size(); ++i)
          //  System.out.println(prev[i] + " " + succ[i]);
    }

    public ArrayList<Set<Integer> > In, Out, Use, Defi;
    //public int label_pos[];

    public boolean SetMerge(Set<Integer> to, Set<Integer> from) {
        int old_size = to.size();
        Iterator itr = from.iterator();
        while (itr.hasNext())
            to.add((Integer)itr.next());
        return to.size() != old_size;
    }

    public boolean SetMerge(Set<Integer> to, Set<Integer> from, Set<Integer> without) {
        int old_size = to.size();
        Iterator itr = from.iterator();
        while (itr.hasNext()) {
            Integer u = (Integer)itr.next();
            if (!without.contains(u))
                to.add(u);
        }
        return to.size() != old_size;
    }

/* Environment: Register from the past!*/
    InfiniteRegister register;

    ArrayList<Integer> list;
    public boolean cmp(int a, int b) {
        if (register.begin.get(a) != register.begin.get(b))
            return register.begin.get(a) < register.begin.get(b);
        return register.end.get(a) < register.end.get(b);
    }
    public void sort(int l, int r) {
        for (int i = l; i <= r; ++i)
            for (int j = i + 1; j <= r; ++j)
                if (!this.cmp(list.get(i), list.get(j))) {
                    int k = list.get(i);
                    list.set(i, list.get(j));
                    list.set(j, k);
                }
    }

    public Function() {
        name = null;
        body = new ArrayList<Quadruple>();
        inline_flag = true;
        start_pos = null;
        succ = null;
        prev = null;
        In = null; Out = null; Use = null; Defi = null; //label_pos = null;
        register = null; list = null;
    }
/*
    public Function(Function o) {
        name = new String(o.name);
        body = new ArrayList<Quadruple>(o.body);
        inline_flag = o.inline_flag;
        start_pos = o.start_pos;
        succ = o.succ;
        prev = o.prev;
        In = o.In; Out = o.Out; Use = o.Use; Defi = o.Defi; label_pos = o.label_pos;
        register = o.register; list = o.list;
    }
*/
    public void Insert(Quadruple q) {
        //System.out.println("#" + q.ToString());
        body.add(q);
    }

    public void print() {
        for (int i = 0; i < body.size(); ++i) {
            if (!body.get(i).mips_flag)
                System.out.print("###");
            System.out.println("#" + body.get(i).ToString());
        }
    }

    public void MovePeepHole() {
        for (int i = 0; i < body.size(); ++i) {
            Quadruple quad = body.get(i);
            if (!quad.mips_flag)
                continue;
            Quadruple quad2 = quad;
            if (quad.op.equals("move")) {
                boolean flag = true;
                boolean use = true;
                //boolean tk = true;
                for (int j = i + 1; j < body.size(); ++j) {
                    //if (j - i > 200) {
                      //  tk = false;
                        //break;
                    //}
                    quad2 = body.get(j);
                    if (!quad2.mips_flag)
                        continue;
                    if (quad2.op.equals("goto") || quad2.op.equals("label")) {
                        flag = false;
                        break;
                    }
                    if (quad2.op.equals("sw") || quad2.op.equals("sb"))
                        if (quad2.src1.type == AddressType.TEMP && quad2.src1.value == quad.dest.value) {
                            flag = false;
                            break;
                        }
                    if (quad2.src1 != null && quad2.src1.type == AddressType.TEMP && quad2.src1.value == quad.dest.value)
                            quad2.src1.value = quad.src1.value;
                    if (quad2.src2 != null && quad2.src2.type == AddressType.TEMP && quad2.src2.value == quad.dest.value)
                            quad2.src2.value = quad.src1.value;
                    if (quad2.dest != null && quad2.dest.type == AddressType.TEMP && quad2.dest.value == quad.dest.value) {
                        use = false;
                        break;
                    }
                }
                //if (!tk)
                    //continue;
                if (flag && (use || !(quad2.op.equals("sw") || quad2.op.equals("sb"))) ) {
                    quad.mips_flag = false;
                }
            }
        }
    }

    public void LiPeepHole() {
        
/*
        for (int i = 0; i < body.size(); ++i) {
            Quadruple quad = body.get(i);
            if (!quad.mips_flag)
                continue;
            Quadruple quad2 = quad;
            if (quad.op.equals("li")) {
                for (int j = i + 1; j < body.size(); ++j) {
                    quad2 = body.get(j);
                    if (quad2.mips_flag)
                        break;
                }
                if (quad2.dest != null && quad2.dest.type == AddressType.TEMP && quad2.dest.value == quad.dest.value &&
                    quad2.src2 != null && quad2.src2.type == AddressType.TEMP && quad2.src2.value == quad.dest.value) {
                    quad2.src2.type = AddressType.CONST;
                    quad2.src2.value = quad.src1.value;
                    quad.mips_flag = false;
                }
            }
        }
*/
        
        int last[] = new int[100000];
        for (int i = 0; i < body.size(); ++i) {
            Quadruple quad = body.get(i);
            if (!quad.mips_flag)
                continue;
            if (quad.dest != null && quad.dest.type == AddressType.TEMP)
                last[quad.dest.value] = i;
            if (quad.src1 != null && quad.src1.type == AddressType.TEMP)
                last[quad.src1.value] = i;
            if (quad.src2 != null && quad.src2.type == AddressType.TEMP)
                last[quad.src2.value] = i;
        }
        for (int i = 0; i < body.size(); ++i) {
            Quadruple quad = body.get(i);
            if (!quad.mips_flag)
                continue;
            if (quad.op.equals("li")) {
                Quadruple quad2 = quad;
                int k = i;
                for (int j = i + 1; j < body.size(); ++j) {
                    quad2 = body.get(k = j);
                    if (quad2.mips_flag)
                        break;
                }
                if (quad2.src2 != null && quad2.src2.type == AddressType.TEMP && quad2.src2.value == quad.dest.value) {
                    if (last[quad.dest.value] == k) {
                        quad.mips_flag = false;
                        quad2.src2.type = AddressType.CONST;
                        quad2.src2.value = quad.src1.value;
                    }
                }
            }
        }
    }

    public void AddMovePeepHole() {
        int last[] = new int[100000];
        for (int i = 0; i < body.size(); ++i) {
            Quadruple quad = body.get(i);
            if (!quad.mips_flag)
                continue;
            if (quad.dest != null && quad.dest.type == AddressType.TEMP)
                last[quad.dest.value] = i;
            if (quad.src1 != null && quad.src1.type == AddressType.TEMP)
                last[quad.src1.value] = i;
            if (quad.src2 != null && quad.src2.type == AddressType.TEMP)
                last[quad.src2.value] = i;
        }
        for (int i = 0; i < body.size(); ++i) {
            Quadruple quad = body.get(i);
            if (!quad.mips_flag)
                continue;
            if (quad.op.equals("add") || quad.op.equals("addi")) {
                Quadruple quad2 = quad;
                int k = i;
                for (int j = i + 1; j < body.size(); ++j) {
                    quad2 = body.get(k = j);
                    if (quad2.mips_flag)
                        break;
                }
                if (quad2.op.equals("move") && quad.dest.value != quad2.src1.value &&  last[quad.dest.value] == k) {
                    quad.dest.value = quad2.dest.value;
                    quad2.mips_flag = false;
                }
            }
        }
    }

    public void SetBuild() {
        In = new ArrayList<Set<Integer> >();
        Out = new ArrayList<Set<Integer> >();
        Use = new ArrayList<Set<Integer> >();
        Defi = new ArrayList<Set<Integer> >();
        int label_pos[] = new int[Label.labelCount];
        for (int i = 0; i < body.size(); ++i) {
            In.add(new TreeSet<Integer>()); Out.add(new TreeSet<Integer>());
            Use.add(new TreeSet<Integer>()); Defi.add(new TreeSet<Integer>());
        }
        for (int i = last_pos; i != -1; i = prev[i - 1]) {
            Quadruple quad = body.get(i);
            String str = quad.op;
            if (str.equals("func") || str.equals("return") || str.equals("call")) {
                int useless = 0;
            } else if (str.equals("label")) {
                label_pos[quad.dest.value] = i;
            } else if (str.equals("goto")) {
                int useless = 0;
            } else if (str.equals("beqz") || str.equals("bnez") || str.equals("bgtz") || str.equals("bgez") || str.equals("bltz") || str.equals("blez")) {
                if (quad.dest.value > 1) {
                    In.get(i).add(quad.dest.value);
                    Out.get(i).add(quad.dest.value);
                }
            } else if (str.equals("mul") || str.equals("div") || str.equals("mod") || str.equals("add") || str.equals("sub") ||
                   str.equals("shl") || str.equals("shr") || str.equals("and") || str.equals("xor") || str.equals("or") ){
                if (quad.src1.type == AddressType.TEMP && quad.src1.value > 1) {
                    In.get(i).add(quad.src1.value);
                    Use.get(i).add(quad.src1.value);
                }
                if (quad.src2.type == AddressType.TEMP && quad.src2.value > 1) {
                    In.get(i).add(quad.src2.value);
                    Use.get(i).add(quad.src2.value);
                }
                if (quad.src2.type == AddressType.TEMP && quad.src1.value != quad.dest.value && quad.src2.value != quad.dest.value && quad.dest.value > 1)
                    Defi.get(i).add(quad.dest.value);
            } else if ( str.equals("addi") || str.equals("subi") || str.equals("muli") || str.equals("divi") || str.equals("andi") 
                    || str.equals("neg") || str.equals("not") || str.equals("lnot") || str.equals("pos")
                    || str.equals("lw") || str.equals("lb") || str.equals("move")) {
                if (quad.src1.type == AddressType.TEMP && quad.src1.value > 1) {
                    In.get(i).add(quad.src1.value);
                    Use.get(i).add(quad.src1.value);
                }
                if (quad.dest.type == AddressType.TEMP && quad.src1.value != quad.dest.value && quad.dest.value > 1) {
                    Defi.get(i).add(quad.dest.value);
                }
            } else if (str.equals("sw") || str.equals("sb") ) {
                if (quad.dest.value > 1) {
                    In.get(i).add(quad.dest.value);
                    Use.get(i).add(quad.dest.value);
                }
                if (quad.src1.value > 1) {
                    In.get(i).add(quad.src1.value);
                    Use.get(i).add(quad.src1.value);
                }
            } else if (str.equals("li")) {
                if (quad.dest.value > 1)
                    Defi.get(i).add(quad.dest.value);
            }
        }

        while (true) { // Iteration!
            int has_next_iterator = 0;
            for (int i = last_pos; i != -1; i = prev[i - 1]) {
                Quadruple quad = body.get(i);
                String str = quad.op;
                if (str.equals("func") || str.equals("return") ) {
                    int useless = 0;
                } else if (str.equals("goto")) {
                    if (SetMerge(Out.get(i), In.get(label_pos[quad.dest.value])) )
                        has_next_iterator++;
                }else {
                    if (str.equals("beqz") || str.equals("bnez") || str.equals("bgtz") || str.equals("bgez") || str.equals("bltz") || str.equals("blez")) {
                        if (SetMerge(Out.get(i), In.get(label_pos[quad.src1.value])))
                            has_next_iterator++;
                    }
                    if (succ[i + 1] >= 0 && SetMerge(Out.get(i), In.get(succ[i + 1])))
                        has_next_iterator++;
                }
                if (SetMerge(In.get(i), Out.get(i), Defi.get(i)))
                    has_next_iterator++;
            }
            //System.out.println(has_next_iterator);

            if (has_next_iterator == 0)
                break;
        }
    }

    public void Register_Allocate() {
        list = new ArrayList<Integer>();
        Set<Integer> used = new TreeSet<Integer>();
        for (int i = first_pos; i != -1; i = succ[i + 1]) {
            Quadruple quad = body.get(i);
            if (quad.dest != null && quad.dest.type == AddressType.TEMP) {
                int u = quad.dest.value;
                if (u > 1 && !used.contains(u)) {
                    used.add(u);
                    list.add(u);
                    register.real.set(u, -1);
                    register.begin.set(u, i);
                    register.end.set(u, i);
                }
            }
            if (quad.src1 != null && quad.src1.type == AddressType.TEMP) {
                int u = quad.src1.value;
                if (u > 1 && !used.contains(u)) {
                    used.add(u);
                    list.add(u);
                    register.real.set(u, -1);
                    register.begin.set(u, i);
                    register.end.set(u, i);
                }
            }
            if (quad.src2 != null && quad.src2.type == AddressType.TEMP) {
                int u = quad.src2.value;
                if (u > 1 && !used.contains(u)) {
                    used.add(u);
                    list.add(u);
                    register.real.set(u, -1);
                    register.begin.set(u, i);
                    register.end.set(u, i);                
                }
            }            
        }

        for (int i = first_pos; i != -1; i = succ[i + 1]) {
            Quadruple quad = body.get(i);
            Iterator itr = In.get(i).iterator();
            while (itr.hasNext()) {
                int u = (Integer)itr.next();
                    //u = tmp.intValue();
                if (register.begin.get(u) > i)
                    register.begin.set(u, i);
                if (register.end.get(u) < i)
                    register.end.set(u, i);
            }
            itr = Out.get(i).iterator();
            while (itr.hasNext()) {
                int u = (Integer)itr.next();
                    //u = tmp.intValue();
                if (register.begin.get(u) > i)
                    register.begin.set(u, i);
                if (register.end.get(u) < i)
                    register.end.set(u, i);
            }
        }

        this.sort(0, list.size() - 1);
        RealRegister rr = new RealRegister();
        for (int i = 0; i < list.size(); ++i) {
            int u = list.get(i);
            int pos = -1;
            for (int l = RealRegister.begin; l < RealRegister.end; ++l)
                if (rr.get(l) == -1 || register.end.get(rr.get(l)) < register.begin.get(u)) {
                    pos = l;
                    break;
                }
            if (pos == -1) {
                pos = RealRegister.begin;
                for (int l = pos + 1; l < RealRegister.end; ++l)
                    if (register.end.get(rr.get(l)) > register.end.get(rr.get(pos)))
                        pos = l;
                register.real.set(rr.get(pos), -1);
            }

            rr.set(pos, u);
            register.real.set(u, pos);
            register.load.set(u, 0);
            //System.out.println(u + "   " + pos);
        }
/*
        for (int i = 0; i < list.size(); ++i) {
            System.out.println(list.get(i) + " " + register.real.get(list.get(i)) + " " + register.begin.get(list.get(i)) + " " + register.end.get(list.get(i)));
        }
        System.out.println("~");
*/
        for (int i = first_pos; i != -1; i = succ[i + 1]) {
            Quadruple quad = body.get(i);
            if (quad.dest != null && quad.dest.type == AddressType.TEMP) {
                int u = quad.dest.value;
                if (register.real.get(u) != -1) {
                    quad.dest.real = register.real.get(u);
                    if (register.global(u) && register.load.get(u) == 0) {
                        register.load.set(u, 1);
                        quad.dest.need_load = (register.begin.get(u) == first_pos + 1);
                    }
                    if (register.end.get(u) == i)
                        quad.dest.need_clear = true;
                }
            }
            if (quad.src1 != null && quad.src1.type == AddressType.TEMP) {
                int u = quad.src1.value;
                if (register.real.get(u) != -1) {
                    quad.src1.real = register.real.get(u);
                    if (register.global(u) && register.load.get(u) == 0) {
                        register.load.set(u, 1);
                        quad.src1.need_load = (register.begin.get(u) == first_pos + 1);
                    }
                    if (register.end.get(u) == i)
                        quad.src1.need_clear = true;
                }
            }
            if (quad.src2 != null && quad.src2.type == AddressType.TEMP) {
                int u = quad.src2.value;
                if (register.real.get(u) != -1) {
                    quad.src2.real = register.real.get(u);
                    if (register.global(u) && register.load.get(u) == 0) {
                        register.load.set(u, 1);
                        quad.src2.need_load = (register.begin.get(u) == first_pos + 1);
                    }
                    if (register.end.get(u) == i)
                        quad.src2.need_clear = true;
                }
            }
        }
    }

    public void Optimize(InfiniteRegister dregister, boolean flag) {

        register = dregister;

        AddMovePeepHole();
        MovePeepHole();
        LiPeepHole();

        if (flag) {
            LinkBuild();
            SetBuild();
            Register_Allocate();
        }

    }
}