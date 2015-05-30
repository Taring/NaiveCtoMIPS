import java.io.*;
import java.util.*;

public class MIPSNormalPrint {

	public static void MIPSNormalPrint(String filename) throws IOException {

        FileReader file = new FileReader(filename);
        BufferedReader buffer = new BufferedReader(file);
        String str = null;
        
        while ( (str = buffer.readLine()) != null) {
            //String s= buffer.readLine();
            System.out.println(str);
        }
        
        buffer.close();
    }

}
