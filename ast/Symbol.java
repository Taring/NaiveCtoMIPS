package compiler.ast;

public class Symbol {
    private String name;

    private Symbol(String s) {
        this.name = s;
    }

    private static java.util.Map<String, Symbol> dict = new java.util.HashMap<String, Symbol>();

    public static Symbol get(String s) {
        String t = s.intern();
        Symbol ret = dict.get(t);
        if (ret == null) {
            ret = new Symbol(t);
            dict.put(t, ret);
        }
        return ret;
    }

    @Override
    public String toString() {
        return name;
    }
}
