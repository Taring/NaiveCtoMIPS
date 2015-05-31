import java.io.*;
import java.util.*;

public class RealRegister {
    
    public int reg[] = new int[32];

    public static int begin = 11;
    public static int end = 26;

    public RealRegister() {
        this.clear();
    }

    public int get(int u) {
        return reg[u];
    }

    public void set(int u, int p) {
        reg[u] = p;
    }

    public void clear() {
        for (int i = begin; i < end; ++i)
            reg[i] = -1;
    }
}
