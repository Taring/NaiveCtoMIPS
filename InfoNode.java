import java.io.*;
import java.util.*;

public class InfoNode {
	public InfoNodeType type; 
	public boolean isinstance;
	public boolean isconst;
	public boolean isleftvalue;
	public String identifier;
	public int value;
	public int width;
	
	public class info {
		InfoNodeArray array;
		InfoNodeFunction function;
		InfoNode pointer;
		InfoNodeRecord record;
		
		public info() {
			this.array = null;
			this.function = null;
			this.pointer = null;
			this.record = null;
		}
		
	};
	public info info;
	
	public InfoNode() {
		this.type = null;
		this.isinstance = this.isconst = this.isleftvalue = false;
		this.identifier = null;
		value = 0;
		width = 4;
		this.info = new info();
	}

	public InfoNode(InfoNode p) {
		this.isinstance = p.isinstance;
		this.isconst = p.isconst;
		this.isleftvalue = p.isleftvalue;
		this.type = p.type;
		this.value = p.value;
		this.width = p.width;
		this.info = new info();
		//this.identifier = new String(p.identifier);
		this.identifier = null;
		if (this.type == InfoNodeType.ARRAY) {
			this.info.array = new InfoNodeArray(p.info.array);
			this.identifier = this.info.array.ptr.identifier;
		} else if (this.type == InfoNodeType.POINTER) {
			this.info.pointer = new InfoNode(p.info.pointer);
			this.identifier = this.info.pointer.identifier;
		} else if (this.type == InfoNodeType.FUNCTION) {
			this.info.function = new InfoNodeFunction(p.info.function);
			if (p.identifier != null)
				this.identifier = new String(p.identifier);
		} else if (this.type == InfoNodeType.STRUCT || this.type == InfoNodeType.UNION) {
			this.info.record = new InfoNodeRecord(p.info.record);
			if (p.identifier != null)
				this.identifier = new String(p.identifier);
		} else if (this.type == InfoNodeType.NAME) {
			this.info.record = new InfoNodeRecord();
			if (p.info.record.name != null)
				this.info.record.name = new String(p.info.record.name);
			if (p.identifier != null)
				this.identifier = new String(p.identifier);
		} else 
			if (p.identifier != null)
		this.identifier = new String(p.identifier);
	}

}
