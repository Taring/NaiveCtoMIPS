import java.io.*;
import java.util.*;

public class InfiniteRegister {
    
    public ArrayList<Integer> state;
    public List<Integer> offset;

    final int STATE_VALUE = 0;
    final int STATE_ADDRESS = 1;
    public int local_space;

    public InfiniteRegister() {
        state = new ArrayList<Integer>();
        offset = new ArrayList<Integer>();
        local_space = 0;
    }

    public int size() {
        return state.size();
    }

    public int push(boolean is_global) {
        state.add(STATE_VALUE);
        if (is_global)
            offset.add(-1);
        else
            offset.add(local_space += 4);
        return state.size() - 1;
    }

    public int get_state(int x) {
        int tmp = state.get(x);
        return tmp;
    }

    public void to_address(int x) {
        //state.get(x) = STATE_ADDRESS;
        state.set(x, STATE_ADDRESS);
    }

    public void to_value(int x) {
        //state.get(x) = STATE_VALUE;
        state.set(x, STATE_VALUE);
    }

    public boolean is_address(int x) {
        return state.get(x) == STATE_ADDRESS;
    }

    public boolean is_value(int x) {
        return state.get(x) == STATE_VALUE;
    }

    public boolean global(int x) {
        return offset.get(x) == -1;
    }

}
