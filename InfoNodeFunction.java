import java.io.*;
import java.util.*;

public class InfoNodeFunction {
	public int size;//the size of the list of X 
	public List<InfoNode> pars;//the list of X
	public int offset[];//to calculate the memory: offset[x + 1] -> pars[x]
	public int width;//..
	public InfoNode ret;//return Information like
	
	public InfoNodeFunction() {
		this.pars = null;
		this.ret = null;
		this.offset = null;
		width = 0;
		size = 0;
	}

	public InfoNodeFunction(InfoNodeFunction p) {
		this.size = p.size;
		if (p.pars != null) {
			//this.pars = p.pars.clone();
			this.pars = new ArrayList<InfoNode>();
			for (int i = 0; i < p.pars.size(); ++i)
				this.pars.add(new InfoNode(p.pars.get(i)));
		} else
			this.pars = null;
		if (p.size != -1) {
			this.offset = new int[p.size + 1];
			for (int i = 0; i <= p.size; ++i)
				this.offset[i] = p.offset[i];
			/*
			Iterator<Infonode> itr = p.pars.iterator();
			while (itr.hasNext()) {
				Node u = new InfoNode(itr.next());
				this.pars.add(u);
			}
			*/
		} else {
			this.offset = new int[1];
			this.offset[0] = 0;
		}
		this.width = p.width;
		this.ret = new InfoNode(p.ret);
	}
}
