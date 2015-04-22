import java.io.*;
import java.util.*;

public class WArray {
		public char[] ch;
		
		public WArray() {
			ch = new char[1006];
			for (int i = 0; i <  1005; ++i)
				ch[i] = ' ';
		}
		
		public void insert(int txt, char chl) {
			ch[txt] = chl;
		}
		
		public char P(int txt) {
			return ch[txt];
		}
}
