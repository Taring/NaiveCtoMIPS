import java.io.*;
import java.util.*;

public class InfoNodeArray {
	public InfoNode ptr; // The ID of array
	public int size; // the size of array
	public int width; //the bytes of array
	
	public InfoNodeArray() {
		this.ptr = null;
		size = 0;
		width = 0;
	}

	public InfoNodeArray(InfoNodeArray p) {
		this.ptr = new InfoNode(p.ptr);
		this.size = p.size;
		this.width = p.width;
	}
}
