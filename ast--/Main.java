import java.io.*;
import java.util.*;

public class Main {
	static public void main(String argv[]) throws IOException{
		StringReader reader =  new StringReader(BufferedInputFile.read("test.c"));
	
		lexer lex = new lexer(reader);

		parser parse = new parser(lex);

		Node TreeRoot = null;
		try {
			TreeRoot = (Node) parse.parse().value;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		if (TreeRoot == null) System.out.println("What the Fuck!");
		
		WArray xxx = new WArray();
 		TreeRoot.printAst(xxx, 0);
	}
}
