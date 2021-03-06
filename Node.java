import java.io.*;
import java.util.*;

public class Node {
	public NodeType type;
	public String data;
	public List<Node> Child;
	public InfoNode info;
	
	public Node() {
		type = null;
		data = null;
		Child = null;
		info = null;
	}
	
	public Node(NodeType type, String data, List<Node> Child) {
		this.type = type;
		this.data = data;
		this.Child = Child;
		info = null;
	}

	public Node(NodeType type, String data) {
		this.type = type;
		this.data = data;
		Child = new ArrayList<Node>();
		info = null;
	}

	public Node(NodeType type, String data, Node a) {
		this.type = type;
		this.data = data;
		
		Child = new ArrayList<Node>();
		Child.add(a);
		info = null;
	}

	public Node(NodeType type, String data, Node a, Node b) {
		this.type = type;
		this.data = data;
		Child = new ArrayList<Node>();
		Child.add(a);
		Child.add(b);
		info = null;
	}

	public Node(NodeType type, String data, Node a, Node b, Node c) {
		this.type = type;
		this.data = data;
		Child = new ArrayList<Node>();
		Child.add(a);
		Child.add(b);
		Child.add(c);
		info = null;
	}

	public Node(NodeType type, String data, Node a, Node b, Node c, Node d) {
		this.type = type;
		this.data = data;
		Child = new ArrayList<Node>();
		Child.add(a);
		Child.add(b);
		Child.add(c);
		Child.add(d);
		info = null;
	}

	public void Merge(Node o) {
		if (o == null) return;
		if (o.Child == null) return;
		if (this.Child == null) {
			this.Child = o.Child;
			return;
		}
		Iterator<Node> itr = o.Child.iterator();
		while (itr.hasNext()) {
			Child.add(itr.next());
		}
	}

	public void Insert(Node o) {
		if (o == null) return;
		if (this.Child == null) {
			Child = new ArrayList<Node>();
		}
		Child.add(o);
	}

	public void printAst(WArray buffer, int depth) {
		int n = (depth - 1) * 2;
		for (int i = 0; i < n; ++i)
			System.out.print(buffer.P(i));
	
		if (depth > 0) {
			System.out.print("|_");
		}
		n = depth * 2;
		buffer.insert(n, '|');
		buffer.insert(n + 1, ' ');
		
		if (this.Child != null) System.out.println(this.data);
			else System.out.println("\033[31;1m"+this.data+"\033[0m");
	
		if (this.Child != null) {
			Iterator<Node> itr = Child.iterator();
			while(itr.hasNext()) {
				Node u = itr.next();
				if (!itr.hasNext()) buffer.insert(n, ' ');
				u.printAst(buffer, depth + 1);
			}
		}
	}

}
