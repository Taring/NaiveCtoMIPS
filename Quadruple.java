import java.io.*;
import java.util.*;

public class Quadruple {

	public String op;
	public Address dest, src1, src2;

	public boolean memory_calc;
	public boolean mips_flag;

	public Quadruple() {
		op = null;
		dest = new Address();
		src1 = new Address();
		src2 = new Address();
		memory_calc = false;
		mips_flag = true;
	}

	public Quadruple(Quadruple a) {
		this.op = new String(a.op);
		this.dest = new Address(a.dest);
		this.src1 = new Address(a.src1);
		this.src2 = new Address(a.src2);
		this.memory_calc = false;
		mips_flag = true;
	}

	public Quadruple(String txt) {
		this.op = new String(txt);
		this.dest = null;
		this.src1 = null;
		this.src2 = null;
		memory_calc = false;
		mips_flag = true;
	}

	public Quadruple(String txt, Address t0) {
		this.op = new String(txt);
		this.dest = new Address(t0);
		this.src1 = null;
		this.src2 = null;
		memory_calc = false;
		mips_flag = true;
	}

	public Quadruple(String txt, Address t0, Address t1) {
		this.op = new String(txt);
		this.dest = new Address(t0);
		this.src1 = new Address(t1);
		this.src2 = null;
		memory_calc = false;
		mips_flag = true;
	}

	public Quadruple(String txt, Address t0, Address t1, Address t2) {
		this.op = new String(txt);
		this.dest = new Address(t0);
		this.src1 = new Address(t1);
		this.src2 = new Address(t2);
		memory_calc = false;
		mips_flag = true;
	}

	public Quadruple(String txt, int t0, int t1) {
		this.op = new String(txt);
		if (txt.equals("lw") || txt.equals("lb") || txt.equals("sw") || txt.equals("sb")) {
			this.dest = new Address(AddressType.TEMP, t0);
			this.src1 = new Address(AddressType.TEMP, t1);
			this.src2 = new Address(AddressType.CONST, 0);
		} else if (txt.equals("global") || txt.equals("li")) {
			this.dest = new Address(AddressType.TEMP, t0);
			this.src1 = new Address(AddressType.CONST, t1);
		} else if (txt.equals("move") || txt.equals("pos") || txt.equals("neg") || txt.equals("not") || txt.equals("lnot")) {
			this.dest = new Address(AddressType.TEMP, t0);
			this.src1 = new Address(AddressType.TEMP, t1);
		}
		memory_calc = false;
		mips_flag = true;
	}

	public Quadruple(String txt, int t0, int t1, int t2) {
		this.op = new String(txt);
		if (txt.equals("lw") || txt.equals("lb") || txt.equals("sw") || txt.equals("sb")) {
			this.dest = new Address(AddressType.TEMP, t0);
			this.src1 = new Address(AddressType.TEMP, t1);
			this.src2 = new Address(AddressType.CONST, t2);
		} else if (txt.equals("addi") || txt.equals("subi") || txt.equals("muli") || txt.equals("divi") || txt.equals("andi")) {
			this.dest = new Address(AddressType.TEMP, t0);
			this.src1 = new Address(AddressType.TEMP, t1);
			this.src2 = new Address(AddressType.CONST, t2);
		}else if (txt.equals("mul") || txt.equals("div") || txt.equals("mod") || txt.equals("add") || txt.equals("sub") ||
				   txt.equals("shl") || txt.equals("shr") || txt.equals("and") || txt.equals("xor") || txt.equals("or")) {
			this.dest = new Address(AddressType.TEMP, t0);
			this.src1 = new Address(AddressType.TEMP, t1);
			this.src2 = new Address(AddressType.TEMP, t2);
		}
		memory_calc = false;
		mips_flag = true;
	}	

	public Quadruple(String txt, Label l0) {
		this.op = new String(txt);
		this.dest = new Address(AddressType.LABEL, l0.num);
		this.src1 = null;
		this.src2 = null;
		memory_calc = false;
		mips_flag = true;
	}

	public Quadruple(String txt, int t0, Label l0) {
		this.op = new String(txt);
		this.dest = new Address(AddressType.TEMP, t0);
		this.src1 = new Address(AddressType.LABEL, l0.num);
		this.src2 = null;
		memory_calc = false;
		mips_flag = true;
	}

	public Quadruple(String txt, String yxy) {
		this.op = new String(txt);
		this.dest = new Address(AddressType.NAME, yxy);
		this.src1 = null;
		this.src2 = null;
		memory_calc = false;
		mips_flag = true;
	}

	public Quadruple(String txt, int t0, String yxy) {
		this.op = new String(txt);
		this.dest = new Address(AddressType.TEMP, t0);
		this.src1 = new Address(AddressType.NAME, yxy);
		this.src2 = null;
		memory_calc = false;
		mips_flag = true;		
	}


	public String ToString() {
		String ans = new String(op);
		if (dest != null)
			ans += " " + dest.ToString();
		if (src1 != null)
			ans += " " + src1.ToString();
		if (src2 != null)
			ans += " " + src2.ToString();
		return ans;
	}

}
