public class Label extends Quadruple {
    public static int labelCount = 0;

    public int num;

    public Label() {
        num = labelCount++;
    }
}
