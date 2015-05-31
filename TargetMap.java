import java.io.*;
import java.util.*;

public class TargetMap {

	public ArrayList<ArrayList<String> > Key;
	public ArrayList<ArrayList<Integer> > Value;

	static public int level = 0;

	public TargetMap() {
		Key = new ArrayList< ArrayList<String> >();
		Key.add(new ArrayList<String>());
		Value = new ArrayList< ArrayList<Integer> >();
		Value.add(new ArrayList<Integer>());
	}

	public void next_level() {
		++level;
		//HashMap<String, InfoNode> ha = new HashMap<String, InfoNode>();
		if (Key.size() < level + 1) {
			Key.add(new ArrayList<String>());
			Value.add(new ArrayList<Integer>());
		}
	}

	public void prev_level() {
		//Key.get(Key.size() - 1).clear();
		Key.remove(Key.size() - 1);
		//Value.get(Value.size() - 1).clear();
		Value.remove(Value.size() - 1);
		--level;
	}

	public void insert(String str, int x) {
		//System.out.println(str + "  -  " + x);
		Key.get(level).add(str);
		Value.get(level).add(x);
	}

	public int fetch_identifier(String str) {
		for (int i = level; i >= 0; --i)
			for (int j = 0; j < Key.get(i).size(); ++j) {
				String now = Key.get(i).get(j);
				if (now.equals(str))
					return Value.get(i).get(j);
			}
		return -1;
	}
}
