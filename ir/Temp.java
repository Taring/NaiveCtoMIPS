package compiler.ir;

public class Temp extends Address {
    private static int tempCount = 0;

    public int num;

    public Temp() {
        num = tempCount++;
    }
}
