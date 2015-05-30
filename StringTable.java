import java.io.*;
import java.util.*;

public class StringTable {

	public ArrayList<String> Key;
	public ArrayList<Integer> Value;

	static public int level = 0;

	public StringTable() {
		Key = new ArrayList<String>();
		Value = new ArrayList<Integer>();
	}

	public void Insert(String str, int ret) {
		Key.add(str);
		Value.add(ret);
	}

	public int fetch_identifier(String str) {
		for (int j = 0; j < Key.size(); ++j) {
			String now = Key.get(j);
			if (now.equals(str))
				return Value.get(j);
		}
		return -1;
	}
}
