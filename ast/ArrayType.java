package compiler.ast;

public class ArrayType extends Type {
    public Type baseType;
    public Expr arraySize;

    public ArrayType() {
        baseType = null;
        arraySize = null;
    }

    public ArrayType(Type baseType, Expr arraySize) {
        this.baseType = baseType;
        this.arraySize = arraySize;
    }
    
    
    
}
