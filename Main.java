import java.io.*;
import java.util.*;

public class Main {
	static public void main(String[] argv ) throws IOException{
		FileReader reader =  new FileReader(argv[0]);
		lexer lex = new lexer(reader);

		parser parse = new parser(lex);

		Node TreeRoot = null;
		try {
			TreeRoot = (Node) parse.parse().value;
		} catch (Exception e) {
			//e.printStackTrace();
			//System.out.println(0);
			System.out.println(1);
			System.exit(1);
		}

		//if (TreeRoot == null) System.out.println("What the Fuck!");
		
		//WArray xxx = new WArray();
 		//TreeRoot.printAst(xxx, 0);

        semantic sem = new semantic(TreeRoot);

        if (sem.legal) {
        	System.out.println(0);
        	System.exit(0);
        }else {
        	System.out.println(1);
        	System.exit(1);
		}
	}
}
