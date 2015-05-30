import java.io.*;
import java.util.*;

public class Function {
    public String name;
    public List<Quadruple> body;

    public boolean inline_flag;
    public Node start_pos;

    public Function() {
        name = null;
        body = new LinkedList<Quadruple>();
        inline_flag = true;
        start_pos = null;
    }

    public Function(String name) {
        this.name = name;
        body = new LinkedList<Quadruple>();
        inline_flag = true;
        start_pos = null;
    }

    public Function(String name, List<Quadruple> body) {
        this.name = name;
        this.body = body;
        inline_flag = true;
        start_pos = null;
    }

    public Function(Function o) {
        name = new String(o.name);
        body = new LinkedList<Quadruple>(o.body);
        inline_flag = o.inline_flag;
        start_pos = o.start_pos;
    }

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

    public void Optimize() {

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
}