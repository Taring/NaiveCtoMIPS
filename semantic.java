import java.io.*;
import java.util.*;

public class semantic {

	public static final int WIDTH_VOID = 0;
	public static final int WIDTH_CHAR = 1;
	public static final int MAX_PARS_PRINTF = 6;

	public boolean isint(InfoNodeType a) {
		if (a == InfoNodeType.INT)
			return true;
		if (a == InfoNodeType.CHAR)
			return true;
		return false;
	}

	public boolean ispointer(InfoNodeType a) {
		if (a == InfoNodeType.POINTER)
			return true;
		if (a == InfoNodeType.ARRAY)
			return true;
		return false;
	}

	public boolean isscalar(InfoNodeType a) {
		return isint(a) || ispointer(a);
	}

	public int string_to_int(String s) {
		if (s.charAt(0) == '0') {
			if (s.length() == 1)
				return 0;
			if (s.charAt(1) == 'x' || s.charAt(1) == 'X') { //16
				String s2 = s.substring(2);
				return Integer.valueOf(s2, 16);
			}
			String s2 = s.substring(1);
			return Integer.valueOf(s2, 8);
		}
		return Integer.valueOf(s);
	}

	public String int_to_name(int a) {
		if (a <= 0)
			this.CompilerError("int to name Error");
		String out = "+" + Integer.toString(a) + "\0";
		return out;
	}

	public SymbolTable table;
	public int loop_count, empty_count;
	public boolean legal;
	public InfoNode signFunc;
	
	public void CompilerError(String str) {
		legal = false;
		System.exit(1);
		//System.out.println(str);
	}
	
	public semantic() {
		table = null;
		loop_count = empty_count = 0;
		legal = true;
		signFunc = null;
	}

	public semantic(Node Root) {
		loop_count = empty_count = 0;
		signFunc = null;

		table = new SymbolTable();
		legal = true;
	
		//create TYPE_FRONT
		InfoNode type_int = new InfoNode();
		type_int.type = InfoNodeType.INT;
		InfoNode type_void = new InfoNode();
		type_void.type = InfoNodeType.VOID;
		type_void.width = WIDTH_VOID;
		InfoNode type_char = new InfoNode();
		type_char.type = InfoNodeType.CHAR;
		type_char.width = WIDTH_CHAR;

		//printf, malloc, getchar
		InfoNode ptr = new InfoNode();
		ptr.type = InfoNodeType.FUNCTION;
		ptr.identifier = new String("printf");
		ptr.info.function = new InfoNodeFunction();
		ptr.info.function.size = -1;
		ptr.info.function.offset = new int[]{0};
		ptr.info.function.width = 0;
		ptr.info.function.ret = type_void;
		table.insert(ptr);

		ptr = new InfoNode();
		ptr.type = InfoNodeType.FUNCTION;
		ptr.identifier = new String("malloc");
		ptr.info.function = new InfoNodeFunction();
		ptr.info.function.size = 1;
		ptr.info.function.pars = new ArrayList<InfoNode>();
		ptr.info.function.pars.add(type_int);
		ptr.info.function.offset = new int[]{0, 4};
		ptr.info.function.width = 4;
		ptr.info.function.ret = type_int;
		table.insert(ptr);

		ptr = new InfoNode();
		ptr.type = InfoNodeType.FUNCTION;
		ptr.identifier = new String("getchar");
		ptr.info.function = new InfoNodeFunction();
		ptr.info.function.size = 0;
		ptr.info.function.offset = new int[]{0};
		ptr.info.function.width = 0;
		ptr.info.function.ret = type_char;
		table.insert(ptr);

		this.semantics_check(Root); 
	}
	
	/*
	*	 TODO : Declaration Check
	*/

	public void semantics_check(Node p) {
		switch (p.type) {
			case ROOT: this.semantics_check_root(p); break;
			case DECLARATION: this.semantics_check_declaration(p); break;
			case FUNCTION_DEFINITION: this.semantics_check_function_definition(p); break;
			case EXPRESSION_STATEMENT: break;
			case COMPOUND_STATEMENT: this.semantics_check_compound_statement(p); break;
			case SELECTION_STATEMENT: this.semantics_check_selection_statement(p); break;
			case ITERATION_STATEMENT: this.semantics_check_iteration_statement(p); break;
			case JUMP_STATEMENT: this.semantics_check_jump_statement(p); break;
			case EXPRESSION: p.info = this.semantics_check_expression(p); break;
			default: this.CompilerError("Semantics_check_ERROR");
		}
	}

	public void semantics_check_root(Node p) {
		Iterator<Node> itr = p.Child.iterator();
		while (itr.hasNext()) {
			//System.out.println("----");
			Node u = itr.next();
			this.semantics_check(u);
		}
	}
	
	public void semantics_check_declaration(Node p) {
		if (!legal) return;
		InfoNode base = this.semantics_check_type_specifier(p.Child.get(0));
		if (base.type == InfoNodeType.STRUCT || base.type == InfoNodeType.UNION) {
			if (base.info.record.size > 0) {
				base.isleftvalue = false;
				table.insert_record(base);
			} else this.CompilerError("Impolite Record size");
		} else if (base.type == InfoNodeType.NAME) {
			if (table.query_type(base)) {
				base = table.fetch_type_instance(base);
			}
		} else if (!table.query_type(base)) {
			this.CompilerError("Type Undefined");
		}
		if (p.Child.size() != 1) {
			if (base.type == InfoNodeType.VOID) {
				this.CompilerError("Only VOID Error");
			}
			//Node[] da = p.Child.get(1).Child.toArray();
			for (int i = 0; i < p.Child.get(1).Child.size(); ++i) {
				this.semantics_check_init_declarator(p.Child.get(1).Child.get(i), base);
			}
		}
	}

	public InfoNode semantics_check_type_specifier(Node p) {
		InfoNode ret = new InfoNode();
		if (p.type == NodeType.KEYWORDS) {
			if (p.data.equals("voidtype")) {
				ret.type = InfoNodeType.VOID;
				ret.width = WIDTH_VOID;
			} else if (p.data.equals("chartype")) {
				ret.type = InfoNodeType.CHAR;
				ret.width = WIDTH_CHAR;
			} else {
				ret.type = InfoNodeType.INT;
			}
		} else {
			if (p.Child.get(0).data.equals("struct"))
				ret.type = InfoNodeType.STRUCT;
			else
				ret.type = InfoNodeType.UNION;
			if (p.Child.size() == 2) {
				if(p.Child.get(1).type == NodeType.IDENTIFIER) {
					ret.type = InfoNodeType.NAME;
					ret.info.record = new InfoNodeRecord();
					if (p.Child.get(0).data.equals("struct"))
						ret.info.record.name = new String("s#" + p.Child.get(1).data);
					else
						ret.info.record.name = new String("u#" + p.Child.get(1).data);
				} else {
					table.next_level();
					ret.info.record = this.semantics_check_l_declarations(p.Child.get(1), ret.type == InfoNodeType.STRUCT);
					table.prev_level();
					empty_count++;
					ret.info.record.name = this.int_to_name(empty_count);
					ret.width = ret.info.record.width;
				}
			} else {
				if (p.Child.size() != 3) {
					this.CompilerError("type specifier CE");
				}
				table.next_level();
				ret.info.record = this.semantics_check_l_declarations(p.Child.get(2), ret.type == InfoNodeType.STRUCT);
				table.prev_level();
				ret.info.record.name = p.Child.get(1).data;
				ret.width = ret.info.record.width;
			}
		}
		return ret;
	}

	public InfoNodeRecord semantics_check_l_declarations(Node p, boolean isstruct) {
		if (p.type != NodeType.L_DECLARATIONS) {
			this.CompilerError("L_DECLARATIONS CE");
		}
		InfoNodeRecord ret = new InfoNodeRecord();
		ret.size = 0;
		for (int i = 0; i < p.Child.size(); ++i)
			ret.size += p.Child.get(i).Child.get(1).Child.size();
		//System.out.println(ret.size);
		ret.field = new ArrayList<InfoNode>();
		ret.offset = new int[ret.size + 1];
		ret.offset[0] = 0;
		int current = 0;
		for (int i = 0; i < p.Child.size(); ++i) {
			InfoNode ptr = this.semantics_check_type_specifier(p.Child.get(i).Child.get(0));
			if ( (ptr.type == InfoNodeType.STRUCT || ptr.type == InfoNodeType.UNION) && ptr.info.record.size > 0) {
				table.insert_record(ptr);
			}
			//Node[] ta = p.Child.get(i).Child.get(1).Child.toArray();
			for (int j = 0; j < p.Child.get(i).Child.get(1).Child.size(); ++j) {
				InfoNode tmp = this.semantics_check_declarator(p.Child.get(i).Child.get(1).Child.get(j), ptr);
				if (table.query_top(tmp.identifier)) {
					this.CompilerError("same name in SorU");
				}
				table.insert(tmp);
				ret.field.add(tmp);
				if (isstruct) {
					if (tmp.type == InfoNodeType.ARRAY) {
						current += tmp.info.array.width;
					} else {
						current += tmp.width;
					}
					current += (4 - (current & 3)) & 3;
					ret.offset[ret.field.size()] = current;
				} else {
					int t;
					if (tmp.type == InfoNodeType.ARRAY) {
						t = tmp.info.array.width;
					} else {
						t = tmp.width;
					}
					t += (4 - (t & 3)) & 3;
					if (t > current) current = t;
					ret.offset[ret.field.size()] = 0;
				}
			}
		}
		if (isstruct) {
			//System.out.println(ret.size);
			ret.width = ret.offset[ret.size];
		} else {
			ret.width = current;
		}
		return ret;
	}

	public InfoNode semantics_check_declarator(Node p, InfoNode ptr) {
		if (p.type != NodeType.DECLARATOR) {
			this.CompilerError("DECLARATOR Error");
		}
		ptr = this.semantics_check_plain_declarator(p.Child.get(0), ptr);
		if (ptr.type == InfoNodeType.NAME) {
			this.CompilerError("Difficult name type" + ptr.identifier);
		}
		if (p.Child.size() > 1) {
			ptr = this.semantics_check_plain_array(p.Child.get(1), ptr);
		}
		return ptr;
	}

	public InfoNode semantics_check_plain_declarator(Node p, InfoNode ptr) {
		if (p.type == NodeType.IDENTIFIER) {
			if (table.query_type(ptr)) {
				ptr = table.fetch_type_instance(ptr);
			} else {
				ptr = new InfoNode(ptr);
			}
			ptr.identifier = new String(p.data);
			ptr.isinstance = true;
			ptr.isleftvalue = true;
			return ptr;
		}
		InfoNode ret = new InfoNode();
		ret.isinstance = true;
		ret.isleftvalue = true;
		ret.type = InfoNodeType.POINTER;
		ret.info.pointer = this.semantics_check_plain_declarator(p.Child.get(0), ptr);
		ret.identifier = ret.info.pointer.identifier;
		ret.width = 4;
		return ret;
	}

	public InfoNode semantics_check_plain_array(Node p, InfoNode ptr) {
		int width = ptr.width;
		//Node[] da = p.Child.toArray();
		for (int i = p.Child.size() - 1; i >= 0; --i) {
			InfoNode ret = new InfoNode();
			ret.isinstance = true;
			ret.type = InfoNodeType.ARRAY;
			ret.isleftvalue = false;
			ret.identifier = ptr.identifier;
			ret.info.array = new InfoNodeArray();
			InfoNode tmp = this.semantics_check_constant_expression(p.Child.get(i));
			if (!tmp.isconst) {
				this.CompilerError("Array "+ret.identifier+" should be constant");
			}
			ret.info.array.size = tmp.value;
			if (ret.info.array.size < 0) {
				this.CompilerError("Array "+ ret.identifier + " size should not be negative");
			}
			ret.info.array.ptr = ptr;
			ret.info.array.width = width * ret.info.array.size;
			ret.width = 4;
			width = ret.info.array.width;
			ptr = ret;
		}
		ptr.info.array.width += (4 - (ptr.info.array.width & 3)) & 3;
		return ptr;
	}

	public void semantics_check_init_declarator(Node p, InfoNode ptr) {
		ptr = semantics_check_declarator(p.Child.get(0), ptr);
		if (ptr.width != 4) {
			ptr.width += (4 - (ptr.width & 3)) & 3;
		}
		if (table.query_top(ptr.identifier)) {
			this.CompilerError(ptr.identifier + "   defined again");
		}
		table.insert(ptr);
		p.info = new InfoNode(ptr);
		if (p.Child.size() > 1)
			this.semantics_check_initializer(p.Child.get(1), ptr);
	}

	public void semantics_check_initializer(Node p, InfoNode ptr) {
		if (p.type != NodeType.INITIALIZER) {
			this.semantics_check_assignment_expression(p);
			return;
		} 
		//wtf= =
	}

	public void semantics_check_function_definition(Node p) {
		InfoNode a = this.semantics_check_type_specifier(p.Child.get(0));
		a = this.semantics_check_plain_declarator(p.Child.get(1), a);
		InfoNodeFunction b = new InfoNodeFunction();
		if (p.Child.get(2).type == NodeType.PARAMETERS) {
			b = this.semantics_check_parameters(p.Child.get(2));
		} else {
			b.size = 0;
			b.offset = new int[]{0};
			b.width = 0;
		}
		InfoNode c = new InfoNode();
		c.type = InfoNodeType.FUNCTION;
		c.isleftvalue = false;
		c.identifier = a.identifier;
		c.info.function = b;
		c.info.function.ret = a;

		signFunc = c;
		if (table.level != 0) {
			this.CompilerError("function in function error");
		}
		if (table.query_function(c.identifier)) {
			this.CompilerError("function rename:"+c.identifier);
		}
		if (!table.query_type(c.info.function.ret)) {
			this.CompilerError("return type Error");
		}
		table.insert(c);

		//System.out.println("function----");

		table.next_level();
		//System.out.println(c.info.function.size);

		for (int i = 0; i < c.info.function.size; ++i) {
			InfoNode tmp = c.info.function.pars.get(i);
			if (table.query_top(tmp.identifier)) {
				this.CompilerError("variable rename:" + tmp.identifier);
			}
			table.insert(tmp);
			//System.out.println(tmp.identifier);
		}
		table.level--;
		this.semantics_check(p.Child.get(p.Child.size() - 1));

		p.info = new InfoNode(signFunc);
		signFunc = null;
	}

	public InfoNodeFunction semantics_check_parameters(Node p) {
		//System.out.println("parameters visited!");
		InfoNodeFunction ret = new InfoNodeFunction();
		ret.offset = new int[p.Child.size() + 1];
		ret.offset[0] = 0;
		ret.pars = new ArrayList<InfoNode>();
		ret.size = p.Child.size();

		int current = 0;
		//Node[] da = p.Child.toArray();
		for (int i = 0; i < p.Child.size(); ++i) {
			InfoNode tmp = this.semantics_check_plain_declaration(p.Child.get(i));
			ret.pars.add(tmp);
			current += tmp.width;
			current += (4 - (current & 3)) & 3;
			ret.offset[i + 1] = current;
		}
		ret.width = ret.offset[p.Child.size()];
		return ret;
	}

	public InfoNode semantics_check_plain_declaration(Node p) {
		if (p.type != NodeType.PLAIN_DECLARATION) {
			this.CompilerError("wtf on PLAIN_DECLARATION");
		} 
		InfoNode ret = this.semantics_check_type_specifier(p.Child.get(0));
		ret = this.semantics_check_declarator(p.Child.get(1), ret);
		return ret;
	}

	/*
	*		TODO: Statement Check
	*/
	public void semantics_check_compound_statement(Node p) {
		table.next_level();
		Iterator<Node> itr = p.Child.iterator();
		while (itr.hasNext()) {
			Node u = itr.next();
			Iterator<Node> itr2 = u.Child.iterator();
			while (itr2.hasNext()) {
				Node v = itr2.next();
				this.semantics_check(v);
			}
		}
		table.prev_level();
	}

	public void semantics_check_selection_statement(Node p) {
		InfoNode tmp = semantics_check_expression(p.Child.get(0));
		if (!this.isscalar(tmp.type)) {
			this.CompilerError("Type Error, not a scalar!");
		} else {
			this.semantics_check(p.Child.get(1));
			if (p.Child.get(p.Child.size() - 1) != p.Child.get(1))
				this.semantics_check(p.Child.get(p.Child.size() - 1));
		}
	}

	public void semantics_check_iteration_statement(Node p) {
		InfoNode tmp = null;
		if (p.data.equals("while()")) {
			tmp = this.semantics_check_expression(p.Child.get(0));
			if (!isscalar(tmp.type))
				this.CompilerError("EXPRESSION Error in " + p.data);
		} else {
			if (p.data.equals("for(;;)")) {
				int useless = 0;
			} else if (p.data.equals("for(*;;)") || p.data.equals("for(;;*)") ){
				tmp = this.semantics_check_expression(p.Child.get(0));
			} else if (p.data.equals("for(;*;)")) {
				tmp = this.semantics_check_expression(p.Child.get(0));
				if (!isscalar(tmp.type))
					this.CompilerError("Expression Error in " + p.data);
			} else if (p.data.equals("for(*;;*)")) {
				tmp = this.semantics_check_expression(p.Child.get(0));
				tmp = this.semantics_check_expression(p.Child.get(1));
			} else if (p.data.equals("for(*;*;)")) {
				tmp = this.semantics_check_expression(p.Child.get(0));
				tmp = this.semantics_check_expression(p.Child.get(1));
				if (!isscalar(tmp.type))
					this.CompilerError("Expression Error in " + p.data);
			} else if (p.data.equals("for(;*;*)")) {
				tmp = this.semantics_check_expression(p.Child.get(1));
				tmp = this.semantics_check_expression(p.Child.get(0));
				if (!isscalar(tmp.type))
					this.CompilerError("Expression Error in " + p.data);
			} else if (p.data.equals("for(*;*;*)")) {
				tmp = this.semantics_check_expression(p.Child.get(0));
				tmp = this.semantics_check_expression(p.Child.get(2));
				tmp = this.semantics_check_expression(p.Child.get(1));
				if (!isscalar(tmp.type))
					this.CompilerError("Expression Error in " + p.data);
			} else {
				this.CompilerError("Terrible Mistake of for(---)");
			}
		}
		loop_count++;
		this.semantics_check(p.Child.get(p.Child.size() - 1));
		loop_count--;
	}

	public void semantics_check_jump_statement(Node p) {
		if (p.Child.get(0).data.equals("return")) {
			if (signFunc == null)
				this.CompilerError("return Error 0");
			else if (p.Child.size() == 1) {
				if (signFunc.info.function.ret.type != InfoNodeType.VOID)
					this.CompilerError("return Error 1");
			} else {
				InfoNode tmp = semantics_check_expression(p.Child.get(1));
				if (!this.semantics_check_same_type(signFunc.info.function.ret, tmp))
					this.CompilerError("return Error 2");
			}
			p.info = new InfoNode(signFunc);
		} else {
			if (loop_count == 0)
				this.CompilerError(p.Child.get(0).data + "Error");
		}
	}

	public boolean semantics_check_same_type(InfoNode p, InfoNode q) {
		if (isscalar(p.type) && isscalar(q.type))
			return true;
		if (p.type != q.type)
			return false;
		if (p.type == InfoNodeType.STRUCT || p.type == InfoNodeType.UNION)
			return p.info.record.name.equals(q.info.record.name);
		this.CompilerError("Terrible Mistake in same type ");
		return false;
	}

	/*
	 * 		TODO: expression	 
	 */

	public InfoNode semantics_check_expression(Node p) {
		InfoNode ret = null;
		/*
		if (p.Child.size() == 1) {
			ret = this.semantics_check_assignment_expression(p.Child.get(0));
		} else {
			System.out.println(p.data);
			this.semantics_check_expression(p.Child.get(0));
			ret = this.semantics_check_assignment_expression(p.Child.get(1));
		}
		*/
		//System.out.println(p.data + "   " + p.Child.size());
		for (int i = 0; i < p.Child.size(); ++i)
			ret = this.semantics_check_assignment_expression(p.Child.get(i));
		p.info = new InfoNode(ret);
		return ret;
	}

	public InfoNode semantics_check_assignment_expression(Node p) {
		if (p.type != NodeType.ASSIGN_EXPRESSION) {
			return this.semantics_check_logical_or_expression(p);
		}
		//System.out.println("---wlgc---");
		InfoNode x = this.semantics_check_unary_expression(p.Child.get(0));
		if (!x.isleftvalue)
			this.CompilerError("left value happened");
		InfoNode y = this.semantics_check_assignment_expression(p.Child.get(2));
		if (p.Child.get(1).data.equals("=")) {
			if (!semantics_check_same_type(x, y))
				this.CompilerError("Assginment Error of same type");
		} else {
			if (!this.isint(x.type) || !isint(y.type)) 
				this.CompilerError("Assignment Error of not int");
		}
		p.info = new InfoNode(x);
		return x;
	}

	public InfoNode semantics_check_constant_expression(Node p) {
		return this.semantics_check_logical_or_expression(p);
	}

	public InfoNode semantics_check_logical_or_expression(Node p) {
		if (p.type != NodeType.LOGICAL_OR_EXPRESSION) {
			return this.semantics_check_logical_and_expression(p);
		}
		InfoNode x = this.semantics_check_logical_or_expression(p.Child.get(0));
		InfoNode y = this.semantics_check_logical_and_expression(p.Child.get(1));
		if (!this.isscalar(x.type) || !this.isscalar(y.type)) {
			this.CompilerError("|| Error");
		}

		x.isconst &= y.isconst;
		x.type = InfoNodeType.INT;
		if (x.isconst) {
			//x.value = x.value || y.value;
			if (x.value != 0 || y.value != 0)
				x.value = 1;
			else 
				x.value = 0;
		}
		x.isleftvalue = false;
		
		p.info = new InfoNode(x);
		return x;
	}

	public InfoNode semantics_check_logical_and_expression(Node p) {
		if (p.type != NodeType.LOGICAL_AND_EXPRESSION) {
			return this.semantics_check_inclusive_or_expression(p);
		}
		InfoNode x = this.semantics_check_logical_and_expression(p.Child.get(0));
		InfoNode y = this.semantics_check_inclusive_or_expression(p.Child.get(1));
		if (!this.isscalar(x.type) || !this.isscalar(y.type)) {
			this.CompilerError("&& Error");
		}

		x.isconst &= y.isconst;
		x.type = InfoNodeType.INT;
		if (x.isconst) {
			//x.value = x.value && y.value;
			if (x.value != 0 && y.value != 0)
				x.value = 1;
			else
				x.value = 0;
		}
		x.isleftvalue = false;
		
		p.info = new InfoNode(x);
		return x;
	}

	public InfoNode semantics_check_inclusive_or_expression(Node p) {
		if (p.type != NodeType.INCLUSIVE_OR_EXPRESSION) {
			return this.semantics_check_exclusive_or_expression(p);
		}
		InfoNode x = this.semantics_check_inclusive_or_expression(p.Child.get(0));
		InfoNode y = this.semantics_check_exclusive_or_expression(p.Child.get(1));
		if (!this.isint(x.type) || !this.isint(y.type)) {
			this.CompilerError("or Error");
		}

		x.isconst &= y.isconst;
		if (x.type == InfoNodeType.INT || y.type == InfoNodeType.INT)
			x.type = InfoNodeType.INT;
		if (x.isconst)
			x.value = x.value | y.value;
		x.isleftvalue = false;
		
		p.info = new InfoNode(x);
		return x;
	}

	public InfoNode semantics_check_exclusive_or_expression(Node p) {
		if (p.type != NodeType.EXCLUSIVE_OR_EXPRESSION) {
			return this.semantics_check_and_expression(p);
		}
		InfoNode x = this.semantics_check_exclusive_or_expression(p.Child.get(0));
		InfoNode y = this.semantics_check_and_expression(p.Child.get(1));
		if (!this.isint(x.type) || !this.isint(y.type)) {
			this.CompilerError("xor Error");
		}

		x.isconst &= y.isconst;
		if (x.type == InfoNodeType.INT || y.type == InfoNodeType.INT)
			x.type = InfoNodeType.INT;
		if (x.isconst)
			x.value = x.value ^ y.value;
		x.isleftvalue = false;
		
		p.info = new InfoNode(x);
		return x;
	}

	public InfoNode semantics_check_and_expression(Node p) {
		if (p.type != NodeType.AND_EXPRESSION) {
			return this.semantics_check_equality_expression(p);
		}
		InfoNode x = this.semantics_check_and_expression(p.Child.get(0));
		InfoNode y = this.semantics_check_equality_expression(p.Child.get(1));
		if (!this.isint(x.type) || !this.isint(y.type)) {
			this.CompilerError("and Error");
		}

		x.isconst &= y.isconst;
		if (x.type == InfoNodeType.INT || y.type == InfoNodeType.INT)
			x.type = InfoNodeType.INT;
		if (x.isconst)
			x.value = x.value & y.value;
		x.isleftvalue = false;
		
		p.info = new InfoNode(x);
		return x;
	}

	public InfoNode semantics_check_equality_expression(Node p) {
		if (p.type != NodeType.EQUALITY_EXPRESSION) {
			return this.semantics_check_relational_expression(p);
		}
		InfoNode x = this.semantics_check_equality_expression(p.Child.get(0));
		InfoNode y = this.semantics_check_relational_expression(p.Child.get(2));
		if (!isscalar(x.type) || !isscalar(y.type)) {
			this.CompilerError("equality Error");
		}

		x.isconst &= y.isconst;
		x.type = InfoNodeType.INT;
		if (x.isconst) {
			if (p.Child.get(1).data.equals("==")) {
				x.value = (x.value == y.value)?1:0;
			} else
				x.value = (x.value != y.value)?1:0;
		}
		x.isleftvalue = false;
		
		p.info = new InfoNode(x);
		return x;
	}

	public InfoNode semantics_check_relational_expression(Node p) {
		if (p.type != NodeType.RELATIONAL_EXPRESSION) {
			return this.semantics_check_shift_expression(p);
		}
		InfoNode x = this.semantics_check_relational_expression(p.Child.get(0));
		InfoNode y = this.semantics_check_shift_expression(p.Child.get(2));
		if (!isscalar(x.type) || !isscalar(y.type)) {
			this.CompilerError("relational Error");
		}

		x.isconst &= y.isconst;
		x.type = InfoNodeType.INT;
		if (x.isconst) {
			if (p.Child.get(1).data.equals(">="))
				x.value = (x.value >= y.value)?1:0;
			else if (p.Child.get(1).data.equals("<="))
				x.value = (x.value <= y.value)?1:0;
			else if (p.Child.get(1).data.equals("<"))
				x.value = (x.value < y.value)?1:0;
			else 
				x.value = (x.value > y.value)?1:0;
		}
		x.isleftvalue = false;
		
		p.info = new InfoNode(x);
		return x;
	}

	public InfoNode semantics_check_shift_expression(Node p) {
		if (p.type != NodeType.SHIFT_EXPRESSION) {
			return this.semantics_check_additive_expression(p);
		}
		InfoNode x = this.semantics_check_shift_expression(p.Child.get(0));
		InfoNode y = this.semantics_check_additive_expression(p.Child.get(2));
		if (!isint(x.type) || !isint(y.type)) {
			this.CompilerError("shift Error");
		}

		x.isconst &= y.isconst;
		if (x.type == InfoNodeType.INT || y.type == InfoNodeType.INT)
			x.type = InfoNodeType.INT;
		if (x.isconst) {
			if (p.Child.get(1).data.equals(">>"))
				x.value = (x.value >> y.value);
			else
				x.value = (x.value << y.value);
		}
		x.isleftvalue = false;
		
		p.info = new InfoNode(x);
		return x;
	}

	public InfoNode semantics_check_additive_expression(Node p) {
		if (p.type != NodeType.ADDITIVE_EXPRESSION) {
			return this.semantics_check_multiplicative_expression(p);
		}
		InfoNode x = this.semantics_check_additive_expression(p.Child.get(0));
		InfoNode y = this.semantics_check_multiplicative_expression(p.Child.get(2));
		if (!this.isscalar(x.type) || !this.isscalar(y.type)) {
			this.CompilerError("additive(subtive) Error");
		}

		x.isconst = y.isconst = (x.isconst & y.isconst);
		//x.type = InfoNodeType.INT;
		if (x.isconst) {
			if (p.Child.get(1).data.equals("+")) {
				if (this.ispointer(x.type) && this.ispointer(y.type))
					this.CompilerError("additive Error");
				if (this.ispointer(y.type)) {
					x = y;
				} else if (x.isconst){ 
					x.value = x.value + y.value;
				}
			} else {
				if (this.ispointer(y.type)) {
					if (!this.ispointer(x.type)) {
						this.CompilerError("subtive Error");
					} else {
						x.type = InfoNodeType.INT;
						x.isleftvalue = false;
					}
				} else if (x.isconst) {
					x.value = x.value - y.value;
				}
			}
		}
		
		p.info = new InfoNode(x);
		return x;
	}

	public InfoNode semantics_check_multiplicative_expression(Node p) {
		if (p.type != NodeType.MULTIPLICATIVE_EXPRESSION) {
			return this.semantics_check_cast_expression(p);
		}
		InfoNode x = this.semantics_check_multiplicative_expression(p.Child.get(0));
		InfoNode y = this.semantics_check_cast_expression(p.Child.get(2));
		if (!this.isint(x.type) || !this.isint(y.type)) {
			this.CompilerError("multi/div/mod Error");
		}

		if (x.type == InfoNodeType.INT || y.type == InfoNodeType.INT)
			x.type = InfoNodeType.INT;
		if (x.isconst &= y.isconst) {
			if (p.Child.get(1).data.equals("*")) {
				x.value = x.value * y.value;
			} else if (p.Child.get(1).data.equals("/")) {
				x.value = x.value / y.value;
			} else {
				x.value = x.value % y.value;
			}
		}
		x.isleftvalue = false;
		
		p.info = new InfoNode(x);
		return x;
	}

	public InfoNode semantics_check_cast_expression(Node p) {
		if (p.type != NodeType.CAST_EXPRESSION) {
			return this.semantics_check_unary_expression(p);
		}
		InfoNode x = this.semantics_check_type_name(p.Child.get(0));
		InfoNode y = this.semantics_check_cast_expression(p.Child.get(1));
		//System.out.println(x.identifier + "   "+ y.identifier);
		if (x.type == InfoNodeType.FUNCTION || x.type == InfoNodeType.ARRAY ||
			x.type == InfoNodeType.STRUCT || x.type == InfoNodeType.UNION ||
			x.type == InfoNodeType.VOID || x.type == InfoNodeType.NAME) {
			this.CompilerError("cast errer");
		}
		
		InfoNode ret = null;
		if (x.type != InfoNodeType.POINTER) {
			ret = y;
			ret.type = x.type;
		} else {
			ret = new InfoNode(x);
			if (y.isconst) {
				ret.isconst = true;
				ret.value = y.value;
			}
		}
		ret.isleftvalue = false;
		p.info = new InfoNode(ret);
		return ret;
	}

	public InfoNode semantics_check_type_name(Node p) {
		InfoNode ret = null;
		if (p.Child.size() == 1) {
			ret = this.semantics_check_type_specifier(p.Child.get(0));
		} else { 
			ret = new InfoNode();
			ret.type = InfoNodeType.POINTER;
			ret.info.pointer = this.semantics_check_type_name(p.Child.get(0));
		}
		p.info = new InfoNode(ret);
		return ret;
	}

	public InfoNode semantics_check_unary_expression(Node p) {
		if (p.type != NodeType.UNARY_EXPRESSION)
			return this.semantics_check_postfix_expression(p);
		if (p.Child.get(0).type == NodeType.UNARY_OPERATOR) {
			InfoNode ret = this.semantics_check_cast_expression(p.Child.get(1));

			if (p.Child.get(0).data.equals("&")) {
				InfoNode tmp = new InfoNode();
				if (!ret.isleftvalue)
					this.CompilerError("unary & Error");
			} else if (p.Child.get(0).data.equals("*")) { 
				if (ret.type == InfoNodeType.POINTER)
					ret = ret.info.pointer;
				else if (ret.type == InfoNodeType.ARRAY)
					ret = ret.info.array.ptr;
				else this.CompilerError("unary * Error");
			} else {
				if (!this.isint(ret.type))
					this.CompilerError("Unary Normal Error");
				if (ret.isconst) {
					if (p.Child.get(0).data.equals("-")) {
						ret.value = -ret.value;
					} else if (p.Child.get(0).data.equals("~")) {
						ret.value = ~ret.value;
					} else {
						//ret.value = !ret.value;
						ret.value = (ret.value == 0)?1:0;
					}
				}
			}

			p.info = new InfoNode(ret);
			return ret;
		}
		if (p.Child.get(0).data.equals("++")) {
			InfoNode ret = this.semantics_check_unary_expression(p.Child.get(1));
			if (!ret.isleftvalue)
				this.CompilerError("++ unary Error");
			
			p.info = new InfoNode(ret);
			return ret;
		} else if (p.Child.get(0).data.equals("--")) {
			InfoNode ret = this.semantics_check_unary_expression(p.Child.get(1));
			if (!ret.isleftvalue)
				this.CompilerError("-- unary Error");
			
			p.info = new InfoNode(ret);
			return ret;
		} else if (p.Child.get(1).type == NodeType.TYPE_NAME) {//sizeof()
			InfoNode tmp = this.semantics_check_type_name(p.Child.get(1));
			if (!table.query_type(tmp))
				this.CompilerError("size of(" + tmp.identifier +") Error");
			if (tmp.type == InfoNodeType.NAME)
				tmp = table.fetch_type_instance(tmp);
			InfoNode ret = new InfoNode();
			ret.isconst = true;
			ret.type = InfoNodeType.INT;
			ret.value = tmp.width;
			ret.width = 4;

			p.info = new InfoNode(ret);
			return ret;
		}
		//size of 
		InfoNode tmp = this.semantics_check_unary_expression(p.Child.get(1));
		InfoNode ret = new InfoNode();
		ret.isconst = true;
		ret.type = InfoNodeType.INT;
		ret.value = tmp.width;
		ret.width = 4;

		p.info = new InfoNode(ret);
		return ret;
	}

	public InfoNode semantics_check_postfix_expression(Node p) {
		if (p.type != NodeType.POSTFIX_EXPRESSION)
			return this.semantics_check_primary_expression(p);
		InfoNode ret = this.semantics_check_postfix_expression(p.Child.get(0));
		Node postfix = p.Child.get(1);
		if (postfix.data.equals("postfix []")) {
			InfoNode inner = this.semantics_check_expression(postfix.Child.get(0));
			if (!isint(inner.type)) {
				this.CompilerError("post[X != integet] Error");
			}
			if (ret.type != InfoNodeType.ARRAY && ret.type != InfoNodeType.POINTER)
				this.CompilerError("postfix != Array Error");
			if (ret.type == InfoNodeType.ARRAY)
				ret = ret.info.array.ptr;
			else
				ret = ret.info.pointer;

			p.info = new InfoNode(ret);
			return ret;
		} else if (postfix.data.equals("postfix ()")) {
			if (ret.type != InfoNodeType.FUNCTION)
				this.CompilerError("postfix (no func) Error");
			if (postfix.Child.size() == 0) {
				if (ret.info.function.size != 0)
					this.CompilerError("function arguments Error");
			} else if (ret.info.function.size != -1) {
				Node argu = postfix.Child.get(0);
				if (argu.Child.size() != ret.info.function.size) {
					this.CompilerError("function arguments Error");
				}
				Iterator<Node> itr1 = argu.Child.iterator();
				Iterator<InfoNode> itr2 = ret.info.function.pars.iterator();
				while (itr1.hasNext()) {
					Node u = itr1.next();
					InfoNode du = semantics_check_assignment_expression(u);
					InfoNode dv = itr2.next();
					if (!semantics_check_same_type(dv,du))
						this.CompilerError("function argument type Error");
				}
			} else {
				Node argu = postfix.Child.get(0);
				InfoNodeFunction rec = ret.info.function;
				rec.size = argu.Child.size();
				rec.pars = new ArrayList<InfoNode>();
				rec.offset = new int[rec.size + 1];
				rec.offset[0] = 0;
				rec.ret = new InfoNode();
				rec.ret.type = InfoNodeType.VOID;
				rec.ret.width = 0;
				int current = 0;
				for (int i = 0; i < argu.Child.size(); ++i) {
					InfoNode xxx = new InfoNode(this.semantics_check_assignment_expression(argu.Child.get(i)));
					rec.pars.add(xxx);
					current += xxx.width;
					current += (4 - (current & 3)) & 3;
					rec.offset[i + 1] = current;
				}
				rec.width = current;
				p.Child.get(0).info = ret;
			}
			ret = ret.info.function.ret;
			ret.isleftvalue = false;
			
			p.info = new InfoNode(ret);
			return ret;
		}

		if (postfix.data.equals("postfix .")) {
			String id = postfix.Child.get(1).data;
			if (ret.type != InfoNodeType.STRUCT && ret.type != InfoNodeType.UNION)
				this.CompilerError("postfix . Error");
			InfoNodeRecord rec = ret.info.record;
			boolean flag = false;
			for (int i = 0; i < rec.size; ++i) 
				if (rec.field.get(i).identifier.equals(id)) {
					ret = rec.field.get(i);
					flag = true;
					break;
				}
			if (!flag)
				this.CompilerError("postfix . " + id);

			p.info = new InfoNode(ret);
			return ret;
		}
		
		if (postfix.data.equals("postfix ->")) {
			String id = postfix.Child.get(1).data;
			if (ret.type != InfoNodeType.POINTER)
				this.CompilerError("postfix -> error");
			ret = ret.info.pointer;
			if (ret.type == InfoNodeType.NAME)
				ret = table.fetch_type_instance(ret);
			else
				if (ret.type != InfoNodeType.STRUCT && ret.type != InfoNodeType.UNION)
					this.CompilerError("postfix -> error");
			InfoNodeRecord rec = ret.info.record;
			boolean flag = false;
			for (int i = 0; i < rec.size; ++i)
				if (rec.field.get(i).identifier.equals(id)) {
					ret = rec.field.get(i);
					flag = true;
					break;
				}
			if (!flag)
				this.CompilerError("postfix -> " + id);

			p.info = new InfoNode(ret);
			return ret;
		}

		if (postfix.data.equals("postfix ++") || postfix.data.equals("postfix --")) {
			if (!ret.isleftvalue)
				this.CompilerError("left value ++ postfix Error");
			
			if (ret.type != InfoNodeType.POINTER && ret.type != InfoNodeType.NAME)
				this.CompilerError(postfix.data + "Error");

			p.info = new InfoNode(ret);
			return ret;
		}

		this.CompilerError("Terrible Mistakes");
		return ret;
	}

	public InfoNode semantics_check_primary_expression(Node p) {
		InfoNode ret = null;
		if (p.type == NodeType.IDENTIFIER) {
			if (p.data.equals("NULL")){
				ret = new InfoNode();
				ret.isconst = true;
				ret.type = InfoNodeType.INT;
				ret.value = 0;
			} else {
				//System.out.println(p.data);
				ret = table.fetch_identifier(p.data);
				if (ret == null)
					this.CompilerError("No ID:" + p.data + "found");
				ret = new InfoNode(ret);
			}
		} else if (p.type == NodeType.INTEGER_CONSTANT) {
			ret = new InfoNode();
			ret.isinstance = true;
			ret.isconst = true;
			ret.type = InfoNodeType.INT;
			ret.value = string_to_int(p.data);
		} else if (p.type == NodeType.CHARACTER_CONSTANT) {
			ret = new InfoNode();
			ret.isconst = true;
			ret.type = InfoNodeType.CHAR;
			if (p.data.equals("\'\\n\'") || p.data.equals("\'\\r\'"))
				ret.value = 10;
			else if (p.data.equals("\'\\t\'"))
				ret.value = 9;
			else if (p.data.charAt(1) == '\\') {
				ret.value = 0;
				for (int i = 2; i < p.data.length() - 1; ++i)
					ret.value = ret.value * 8 + (p.data.charAt(i) - '0');
			} else {
				if (p.data.length() > 3)
					this.CompilerError("Char " + p.data + " Error");
				ret.value = p.data.charAt(1);
			}
		} else if (p.type == NodeType.STRING_CONSTANT) {
			ret = new InfoNode();
			ret.isinstance = true;
			ret.type = InfoNodeType.POINTER;
			ret.info.pointer = new InfoNode();
			ret.info.pointer.type = InfoNodeType.CHAR;
			ret.info.pointer.width = WIDTH_CHAR;//How to show that
		} else {
			//System.out.println(p.data);
			ret = semantics_check_expression(p.Child.get(0));
		}

		p.info = new InfoNode(ret);
		return ret;
	}
}