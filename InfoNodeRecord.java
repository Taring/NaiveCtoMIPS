import java.io.*;
import java.util.*;

public class InfoNodeRecord {

	public String name;

	public int size;//the size of X 
	public List<InfoNode> field;//the list of X
	public int offset[];//to calculate the memory of each element of list
	public int width;//..
	
	public InfoNodeRecord() {
		this.field = null;
		width = 0;
		size = 0;
		this.offset = null;
	}

	public InfoNodeRecord(InfoNodeRecord p) {
		this.size = p.size;
		if (p.name != null)
			this.name = new String(p.name);
		this.field = new ArrayList<InfoNode>(p.field);
		//this.field = p.field.clone();
		this.offset = new int[this.size + 1];
		for (int i = 0; i <= this.size; ++i)
			this.offset[i] = p.offset[i];
		this.width = p.width;
	}
}
