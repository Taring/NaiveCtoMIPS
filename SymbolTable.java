import java.io.*;
import java.util.*;

public class SymbolTable {
	public ArrayList<ArrayList<InfoNode> > S;
	//public Map<String, InfoNode> SorU;
	public int level;

	public SymbolTable() {
		S = new ArrayList< ArrayList<InfoNode> >();
		S.add(new ArrayList<InfoNode>());
		//SorU = new HashMap<String, InfoNode>();
		
		level = 0;
	}

	public void next_level() {
		++level;
		//HashMap<String, InfoNode> ha = new HashMap<String, InfoNode>();
		if (S.size() < level + 1) {
			ArrayList<InfoNode> ha = new ArrayList<InfoNode>();
			S.add(ha);
		}
	}

	public void prev_level() {
		if (level == 0) {
			level--;
			return;
		}
		ArrayList<InfoNode> ha = S.get(S.size() - 1);
		ha.clear();
		S.remove(S.size() - 1);
		--level;
	}

	public void insert(InfoNode p) {
		InfoNode q = new InfoNode(p);
		//S.get(level).put(q.identifier,q);
		S.get(level).add(q);
	}

	public void insert_record(InfoNode p) {// but name with "?#"
		InfoNode q = new InfoNode(p);
		//SorU.put(q.info.record.name, q);
		S.get(level).add(q);
	}

	public boolean query_top(String p) {
		for (int i = 0; i < S.get(level).size(); ++i) {
			InfoNode now = S.get(level).get(i);
			if (now.isinstance && p.equals(now.identifier))
				return true;
		}
		return false;
	}

	public boolean query_function(String p) {
		for (int i = 0; i < S.get(0).size(); ++i) {
			InfoNode now = S.get(0).get(i);
			if (now.type == InfoNodeType.FUNCTION && p.equals(now.identifier) )
				return true;
		}
		return false;
	}

	public boolean query_type(InfoNode p) {
		if (p.type == InfoNodeType.ARRAY || p.type == InfoNodeType.FUNCTION) {
			System.out.println("Naive Speaker");
			return false;
		}
		if (p.type == InfoNodeType.INT || p.type == InfoNodeType.CHAR ||
			p.type == InfoNodeType.VOID || p.type == InfoNodeType.POINTER) {
			return true;
		}

		InfoNodeType real_type = p.type;
		int flag = 0;// Calulate the length of s# or u#
		if (p.type == InfoNodeType.NAME) {
			if (p.info.record.name.charAt(0) == 's') real_type = InfoNodeType.STRUCT;
				else real_type = InfoNodeType.UNION;
			flag = 2;
		}

		for (int i = level; i >= 0; --i)
			for (int j = 0; j < S.get(i).size(); ++j) {
				InfoNode now = S.get(i).get(j);
				if ((!now.isinstance) && now.type == real_type)
					if ( now.info.record.name.equals(p.info.record.name.substring(flag)) )
						return true;
			}
		return false;
	}

	public InfoNode fetch_function(String p) {
		for (int i = 0; i < S.get(0).size(); ++i) {
			InfoNode now = S.get(0).get(i);
			if (now.type == InfoNodeType.FUNCTION && p.equals(now.identifier))
				return new InfoNode(now);
		}
		return null;
	}

	public InfoNode fetch_identifier(String p) {
		for (int i = level; i >= 0; --i)
			for (int j = 0; j < S.get(i).size(); ++j) {
				InfoNode now = S.get(i).get(j);
				if ((now.type == InfoNodeType.FUNCTION || now.isinstance) && p.equals(now.identifier))
					return new InfoNode(now);
			}
		return null;
	}

	public InfoNode fetch_type_instance(InfoNode p) {
		if (p.type == InfoNodeType.ARRAY || p.type == InfoNodeType.FUNCTION || p.type == InfoNodeType.POINTER) {
			System.out.println("Naive Speaker");
			return null;
		}
		if (p.type == InfoNodeType.INT || p.type == InfoNodeType.CHAR || p.type == InfoNodeType.VOID) {
			return new InfoNode(p);
		}

		InfoNodeType real_type = p.type;
		int flag = 0;// Calulate the length of s# or u#
		if (p.type == InfoNodeType.NAME) {
			if (p.info.record.name.charAt(0) == 's') real_type = InfoNodeType.STRUCT;
				else real_type = InfoNodeType.UNION;
			flag = 2;
		}

		for (int i = level; i >= 0; --i)
			for (int j = 0; j < S.get(i).size(); ++j) {
				InfoNode now = S.get(i).get(j);
				if ((!now.isinstance) && now.type == real_type)
					if ( now.info.record.name.equals(p.info.record.name.substring(flag)) )
						return new InfoNode(now);
			}
			
		return null;		
	}
}