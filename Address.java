import java.io.*;
import java.util.*;

public class Address {
	public AddressType type;
	public int value;
	public String str;

	boolean need_load;
	boolean need_clear;

	public Address() {
		type = null;
		value = -1;
		need_load = need_clear = false;
		str = "";
	}

	public Address(Address o) {
		type = o.type;
		value = o.value;
		need_clear = o.need_clear;
		need_load = o.need_load;
		str = new String(o.str);
	}

	public Address(AddressType a, int b) {
		type = a;
		value = b;
		need_load = need_clear = false;
		str = "";
	}

	public Address(AddressType a, String st) {
		type = a;
		value = 0;
		need_load = need_clear = false;
		str = new String(st);
	}

	public String ToString() {
		if (type == AddressType.LABEL)
			return "l:" + String.valueOf(value);
		else if (type == AddressType.CONST) 
			return String.valueOf(value);
		else if (type == AddressType.TEMP)
			return "$" + String.valueOf(value);
		
		return "#" + str;
	}
}
