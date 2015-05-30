import java.io.*;
import java.util.*;
//import compiler.ir.*;

public class Main {
	static public void main(String[] argv ) throws IOException{
		
		//StringReader reader =  new StringReader(BufferedInputFile.read(argv[0]));
        //System.out.println("#---the Program Beginning---");		
		Reader r = new InputStreamReader(System.in);

		lexer lex = new lexer(r);

		parser parse = new parser(lex);

		Node TreeRoot = null;
		try {
			TreeRoot = (Node) parse.parse().value;
		} catch (Exception e) {
			//e.printStackTrace();
			//System.out.println(0);
			//System.out.println(1);
			System.exit(1);
		}

		//if (TreeRoot == null) System.out.println("What the Fuck!");
        //WArray xxx = new WArray();
		//TreeRoot.printAst(xxx, 0);

        semantic sem = new semantic();
        sem.semantic_root(TreeRoot);
/*
        if (sem.legal) {
        	//System.out.println(0);
        	System.exit(0);
        }else {
        	//System.out.println(1);
        	System.exit(1);
		}
 */
        if (!sem.legal) {
            //System.out.println(sem.CEstring);
            System.exit(1);
        }
        
        //System.out.println("#---the IR instruction---");
        IR itr = new IR(TreeRoot, sem.table);
        //System.out.println("#---the MIPS instruction---");
        //itr.Local_Register_Allocate();
        itr.MIPS_print();
        //itr.IR_print();
	}
}
